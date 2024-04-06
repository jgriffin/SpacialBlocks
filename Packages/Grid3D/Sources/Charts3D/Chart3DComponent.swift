//
// Created by John Griffin on 4/5/24
//

import Foundation
import RealityKit

public struct Chart3DComponent: Component {
    public let content: any EntityRepresentableContent

    public init(content: any EntityRepresentableContent) {
        self.content = content
    }

    public static func ensureRegistered() { _ = _registered }
    private static var _registered: () = Self.registerComponent()
}

public extension Entity {
    var chart3DContent: (any EntityRepresentableContent)? {
        get {
            components[Chart3DComponent.self]?.content
        }
        set {
            components[Chart3DComponent.self] = newValue.map(Chart3DComponent.init)
        }
    }
}
