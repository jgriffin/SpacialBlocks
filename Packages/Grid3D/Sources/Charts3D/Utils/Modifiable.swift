//
// Created by John Griffin on 4/5/24
//

import Foundation

public protocol Modifiable {}

public extension Modifiable {
    func modify(_ with: (inout Self) -> Void) -> Self {
        Charts3D.modify(self, with: with)
    }
}

public func modify<T>(_ t: T, with: (inout T) -> Void) -> T {
    var copy = t
    with(&copy)
    return copy
}
