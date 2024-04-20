//
// Created by John Griffin on 4/18/24
//

import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            RealityStack(.right, alignment: .center, spacing: .one * 0.1) {
                SphereShape()
                BoxShape()
                SphereShape()
            }
        }
    }

#endif
