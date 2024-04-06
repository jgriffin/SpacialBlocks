
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
        Box3D(size: .init(.one * 2.0), position: .init(.one * 2.0))

        Axes3D()
    }

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
