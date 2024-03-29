//
// Created by John Griffin on 3/28/24
//

import RealityKit
import RealityKitContent
import SwiftUI

struct BlockSceneView: View {
    @State private var scaledRoot = Entity()
    @State private var cubeOrigin = Entity()

    var intialCubePositions: [SIMD3<Float>] = [
        [0, 0, 0], [0.1, 0, 0]
    ]

    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                do {
                    // setup a scaled root
                    content.add(scaledRoot)

                    // Add the initial RealityKit content
                    let gridScene = try await Entity(named: "CubeGrid", in: realityKitContentBundle)
                    guard let grid = gridScene.findEntity(named: "gridRoot") else {
                        throw EntityError.failedToFindEntity("gridRoot")
                    }
                    guard let block = gridScene.findEntity(named: "PlasticBlock") else {
                        throw EntityError.failedToFindEntity("PlasticBlock")
                    }


                    scaledRoot.addChild(cubeOrigin)
                    cubeOrigin.position = [-0.05, 0.05, 0]
                    cubeOrigin.addChild(gridScene)
//
//
//                    scaledRoot.addChild(grid)
//
                    for cubePosition in intialCubePositions {
                        let copy = block.clone(recursive: true)
                        copy.position = cubePosition
                        cubeOrigin.addChild(copy)
                    }
                } catch {
                    debugPrint("loading error: \(error)")
                }
            } update: { content in
                ensureRootScale(proxy, content)
            }
        }
    }

    enum EntityError: Error {
        case failedToFindEntity(String?)
    }

    func ensureRootScale(
        _ proxy: GeometryProxy3D,
        _ content: RealityViewContent
    ) {
        let box = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
        // debugPrint("boundingBox extents: \(box.extents.desc) min: \(box.min.desc) max: \(box.max.desc)")

        let minExtent = box.extents.min()
        let scaleFactor = minExtent / 1
        // debugPrint("scale: \(scaleFactor)")

        let scale = SIMD3<Float>.one * scaleFactor
        if scaledRoot.scale != scale {
            // debugPrint("scaledRoot.scale: \(scale)")
            scaledRoot.scale = scale
        }
    }
}

#Preview(windowStyle: .volumetric) {
    BlockSceneView()
}
