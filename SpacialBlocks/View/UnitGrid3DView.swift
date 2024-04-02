//
// Created by John Griffin on 3/28/24
//

import RealityKit
import RealityKitContent
import SwiftUI
import Grid3D

/// Establishes a (scaled) 3D grid inside a 3D Volume to make it easy to layout grid-based objects
///
/// When displaying 2D data we often reach for graph paper, pick an origin near the bottom left and extend the axis as needed.
/// Things are a lot more challening in 3D where picking an attractive orgin isn't obvious, scaling / fitting happens in an extra
/// dimension, and there are 3D sizes and transforms all over the place often with center-based positioning.
///
/// UnitGrid3D aims to hide a lot of the tricky scaling/fitting/rotation/orienctation math from us and create a coordinate systems where
/// we can just think in terms of a natural 3D unit based coordinate system with a simple origin.
struct UnitGrid3DView: View {
    var gridConstraints: Grid3D.UnitsConstraints = .init(
        requiredUnits: .init(min: [0, 0, 0], max: [9, 5, 6]),
        paddingMin: [1,0,0]
    )

    var cubePositions: [SIMD3<Float>] = [
        [0, 0, 0], [2, 0, 0],
    ]

    @State private var e = GridEntities()
    @State private var r: GridResources?

    @State private var scaledRoot = Entity()
    @State private var unitsCenter = Entity()
    @State private var unitsFit: Grid3D.UnitsFit?

    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                guard let r = await GridResources.loadResources() else {
                    debugPrint("resource loading failed")
                    return
                }
                self.r = r

                // setup a scaled root
                content.add(scaledRoot)
                scaledRoot.addChild(unitsCenter)

                let defaultFit = Grid3D.UnitsFit(
                    unitsBounds: gridConstraints.requiredUnits,
                    scale: .one / 10,
                    bias: gridConstraints.unitBias
                )

                for cubePosition in cubePositions {
                    let cubeMesh = MeshResource.generateBox(size: 1)
                    let cube = ModelEntity(
                        mesh: cubeMesh,
                        materials: .init(repeating: r.plasticMaterial, count: cubeMesh.expectedMaterialCount)
                    )
                    unitsCenter.addChild(cube)
                    cube.position = defaultFit.positionForUnits(cubePosition)
                }

                ensureGridFit(proxy, content)
            } update: { content in
                ensureGridFit(proxy, content)
            }
        }
        .onChange(of: unitsFit) { _, newValue in
            guard let newValue else { return }
            applyUnitsFit(newValue)
        }
    }

    private func ensureGridFit(_ proxy: GeometryProxy3D, _ content: RealityViewContent) {
        guard r != nil else { return }
        debugPrint(scaledRoot.position)

        let sceneBounds = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
        let fit = try! Grid3D.UnitsFit(from: gridConstraints, sceneBounds: sceneBounds)
        if unitsFit != fit {
            unitsFit = fit
        }
    }
}

extension UnitGrid3DView {
    struct GridEntities {
        let ground = ModelEntity()
        let back = ModelEntity()
        let right = ModelEntity()
    }

    enum EntityError: Error {
        case failedToFindEntity(String?)
    }

    func applyUnitsFit(_ fit: Grid3D.UnitsFit) {
        debugPrint("scaledRoot.scale: \(fit.scale)")
        scaledRoot.scale = fit.scale

        if let r {
            ensureGridPlanes(fit, gridMaterial: r.unitsGridMaterial)
        } else {
            assertionFailure("applyGridFit called without materials")
        }
    }

    private func ensureGridPlanes(
        _ fit: Grid3D.UnitsFit,
        gridMaterial: ShaderGraphMaterial
    ) {
        let unitsBounds = fit.unitsBounds
        let unitsExtents = unitsBounds.extents

        let groundMesh = MeshResource.generateBox(width: unitsExtents.x, height: 0.01, depth: unitsExtents.z)
        let backMesh = MeshResource.generateBox(width: unitsExtents.x, height: unitsExtents.y, depth: 0.01)
        let rightMesh = MeshResource.generateBox(width: 0.01, height: unitsExtents.y, depth: unitsExtents.z)

        let bias = remainder(unitsExtents, [2,2,2]) / 2
        var gridMaterial = gridMaterial
        try? gridMaterial.setParameter(name: "positionBias", value: .simd3Float(bias))

        e.ground.model = ModelComponent(mesh: groundMesh, material: gridMaterial)
        e.back.model = ModelComponent(mesh: backMesh, material: gridMaterial)
        e.right.model = ModelComponent(mesh: rightMesh, material: gridMaterial)

        scaledRoot.addChild(e.ground)
        scaledRoot.addChild(e.back)
        scaledRoot.addChild(e.right)

        // the grid coordinate space is positioned center-centered, so we can position based
        // on the extents, the unitOrigin takes care of things for other entities
        e.ground.position = [0, -unitsExtents.y / 2, 0]
        e.back.position = [0, 0, -unitsExtents.z / 2]
        e.right.position = [unitsExtents.x / 2, 0, 0]
    }
}

#Preview(windowStyle: .volumetric) {
    UnitGrid3DView()
}
