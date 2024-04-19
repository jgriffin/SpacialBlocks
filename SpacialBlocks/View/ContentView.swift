//
// Created by John Griffin on 3/28/24
//

// import Charts3D
import RealityKit
import RealityUI
import SwiftUI

struct ContentView: View {
    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
//        UnitGrid3DView()
//        ChartsView(chart: .current)
        RealityUIView(SphereShape())
            .onChange(of: showImmersiveSpace) { _, newValue in
                Task { @MainActor in
                    await updateImmersiveSpaceShown(newValue)
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })
            .toolbar {
                ToolbarItemGroup(placement: .bottomOrnament) {
                    VStack(spacing: 12) {
//                        Toggle("Enlarge RealityView Content", isOn: $enlarge)
                        Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                    }
                }
            }
    }

    @MainActor
    private func updateImmersiveSpaceShown(_ show: Bool) async {
        if show {
            switch await openImmersiveSpace(id: "ImmersiveSpace") {
            case .opened:
                immersiveSpaceIsShown = true
            case .error, .userCancelled:
                fallthrough
            @unknown default:
                immersiveSpaceIsShown = false
                showImmersiveSpace = false
            }
        } else if immersiveSpaceIsShown {
            await dismissImmersiveSpace()
            immersiveSpaceIsShown = false
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
