//
// Created by John Griffin on 3/28/24
//

import RealityKit
import RealityKitContent
import SwiftUI

struct BlockSceneView: View {
    var enlarge: Bool = false

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        } update: { content in
            // Update the RealityKit content when SwiftUI state changes
            if let scene = content.entities.first {
                let uniformScale: Float = enlarge ? 1.4 : 1.0
                scene.transform.scale = [uniformScale, uniformScale, uniformScale]
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    BlockSceneView()
}
