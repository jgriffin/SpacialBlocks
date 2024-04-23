//
// Created by John Griffin on 4/22/24
//

import Charts3D
import RealityUI
import SwiftUI

struct ChartContentView: View {
    var body: some View {
        RealityUIView {
            Chart3D {
                PointMark(.init(xyz: 0, 0, 0))
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ChartContentView()
}
