//
// Created by John Griffin on 3/28/24
//

#if os(visionOS)

    import Foundation
    import RealityKit
    import SwiftUI

    /// Establishes a (scaled) 3D grid inside a 3D Volume to make it easy to layout grid-based objects
    ///
    /// When displaying 2D data we often reach for graph paper, pick an origin near the bottom left and extend the axis as needed.
    /// Things are a lot more challening in 3D where picking an attractive orgin isn't obvious, scaling / fitting happens in an extra
    /// dimension, and there are 3D sizes and transforms all over the place often with center-based positioning.
    ///
    /// UnitGrid3D aims to hide a lot of the tricky scaling/fitting/rotation/orientation math from us and create a coordinate systems where
    /// we can just think in terms of a natural 3D unit based coordinate system with a simple origin.
    public struct ChartsView: View {
        var chart: Chart3D

        public init(chart: Chart3D) {
            self.chart = chart
        }

        @State private var renderer = EntityRenderer(scale: .one * 0.5)

        public var body: some View {
            GeometryReader3D { proxy in
                RealityView { content in
                    Chart3DComponent.ensureRegistered()
                    content.add(renderer.root)

                    try? renderer.renderChart(chart)
                } update: { content in
                    ensureSceneBounds(proxy, content)
                    try? renderer.renderChart(chart)
                }
            }
        }

        private func ensureSceneBounds(_ proxy: GeometryProxy3D, _ content: RealityViewContent) {
            let sceneBounds = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
            renderer.setSceneBounds(.init(sceneBounds))
        }
    }

    #Preview(windowStyle: .volumetric) {
        ChartsView(chart: .current)
    }

#endif
