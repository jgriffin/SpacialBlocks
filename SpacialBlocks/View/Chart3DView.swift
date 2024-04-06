
//
// Created by John Griffin on 3/28/24
//

import Charts3D
import Foundation
import Grid3D
import RealityKit
import RealityKitContent
import SwiftUI

/// Establishes a (scaled) 3D grid inside a 3D Volume to make it easy to layout grid-based objects
///
/// When displaying 2D data we often reach for graph paper, pick an origin near the bottom left and extend the axis as needed.
/// Things are a lot more challening in 3D where picking an attractive orgin isn't obvious, scaling / fitting happens in an extra
/// dimension, and there are 3D sizes and transforms all over the place often with center-based positioning.
///
/// UnitGrid3D aims to hide a lot of the tricky scaling/fitting/rotation/orientation math from us and create a coordinate systems where
/// we can just think in terms of a natural 3D unit based coordinate system with a simple origin.
struct Chart3DView: View {
    var chart = Chart3D {
        Box3D()
        Box3D(position: .init(.one))
        Box3D(size: .init(.one * 2.0), position: Point3D([1.0, 2.0, 4.0]))

        Sphere3D(radius: 1, position: .init([1.0, 5.0, -1.0]))
        Cone3D(height: 2, radius: 1, position: .init([2.0, 2.0, -1.0]))
        Cylinder3D(height: 2, radius: 1, position: .init([7.0, 2.0, -1.0]))
        Plane3D(width: 5, height: 4, cornerRadius: 0.01, position: .init([5.0, 5.0, 8.0]))

        Axes3D()
    }
    .setRange(Rect3D(origin: .zero, size: Size3D(width: 10, height: 10, depth: 10)))

    @State private var renderer = EntityRenderer()

    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                Chart3DComponent.ensureRegistered()
                content.add(renderer.root)

                try? renderer.renderChart(chart)
            } update: { content in
                ensureScaledToFit(proxy, content)
                try? renderer.renderChart(chart)
            }
        }
    }

    private func ensureScaledToFit(_ proxy: GeometryProxy3D, _ content: RealityViewContent) {
        let sceneBounds = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
        renderer.ensureScaledToFit(.init(sceneBounds))
    }
}

#Preview(windowStyle: .volumetric) {
    Chart3DView()
}
