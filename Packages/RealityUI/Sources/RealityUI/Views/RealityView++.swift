//
// Created by John Griffin on 4/18/24
//

public extension RealityView {
    func frame(
        width: Double? = nil,
        height: Double? = nil,
        depth: Double? = nil,
        alignment: Alignment3D = .center
    ) -> some RealityView {
        RealityFrame(
            width: width,
            height: height,
            depth: depth,
            alignment: alignment,
            content: self
        )
    }
}
