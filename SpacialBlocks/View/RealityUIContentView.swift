//
// Created by John Griffin on 4/22/24
//

import RealityUI
import SwiftUI

struct RealityContentView: View {
    var body: some View {
        RealityUIView {
            RealityStack(.right) {
                Sphere()
                Box()
            }
        }
    }
}

#Preview {
    RealityContentView()
}
