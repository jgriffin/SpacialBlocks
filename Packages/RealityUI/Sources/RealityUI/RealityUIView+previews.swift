//
// Created by John Griffin on 4/18/24
//

import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            RealityStack(.init([1.0, 1, -1]), alignment: .center) {
                SphereShape()
                SphereShape()
                BoxShape()
            }
        }
    }

#endif
