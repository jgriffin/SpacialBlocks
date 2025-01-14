//
// Created by John Griffin on 4/5/24
//

import Foundation

public struct RenderEnvironment: Modifiable {
    private var values: [ObjectIdentifier: Any]

    init(values: [ObjectIdentifier: Any]) {
        self.values = values
    }

    public init() {
        values = [:]
    }
}

public extension RenderEnvironment {
    subscript<K: RenderEnvironmentKey>(_: K.Type) -> K.Value {
        get {
            values[ObjectIdentifier(K.Type.self)] as? K.Value ?? K.defaultValue
        }
        set {
            values[ObjectIdentifier(K.Type.self)] = newValue
        }
    }

    func merging(_ other: RenderEnvironment) -> RenderEnvironment {
        .init(values: values.merging(other.values, uniquingKeysWith: { _, rhs in rhs }))
    }
}

public protocol RenderEnvironmentKey {
    associatedtype Value

    static var defaultValue: Self.Value { get }
}
