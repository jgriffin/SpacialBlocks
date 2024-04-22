//
// Created by John Griffin on 4/18/24
//

import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            RealityStack(.right, alignment: .center, spacing: .zero) {
                SphereShape()
                BoxShape()
                SphereShape()
            }
            .padding(.init(0.1))
        }
    }

    #Preview {
        RealityUIView {
            BoxShape()
                .padding(.init(0.01))
        }
    }

#endif
