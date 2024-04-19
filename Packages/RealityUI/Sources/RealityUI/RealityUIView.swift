//
// Created by John Griffin on 4/18/24
//

#if os(visionOS)
    import RealityKit
    import SwiftUI

    public struct RealityUIView: View {
        var realityContent: any RealityContent

        public init(_ realityContent: () -> some RealityContent) {
            self.realityContent = realityContent()
        }

        @State private var renderer = RealityContentRenderer()

        public var body: some View {
            GeometryReader3D { proxy in
                RealityView { content in
                    content.add(renderer.root)

                    let sceneBounds = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
                    renderer.update(with: realityContent, size: Size3D(sceneBounds.extents))
                } update: { content in
                    let sceneBounds = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
                    renderer.update(with: realityContent, size: Size3D(sceneBounds.extents))
                }
            }
        }
    }
#endif

#Preview(windowStyle: .volumetric) {
    RealityUIView { SphereShape() }
}
