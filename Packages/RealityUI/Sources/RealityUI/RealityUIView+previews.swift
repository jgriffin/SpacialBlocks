//
// Created by John Griffin on 4/18/24
//

import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            Stack(.right, alignment: .center, spacing: .zero) {
                Sphere()
                Box()
                Sphere()
            }
            .padding(.init(0.1))
        }
    }

    #Preview {
        RealityUIView {
            Box()
                .padding(.init(0.01))
        }
    }

#endif
