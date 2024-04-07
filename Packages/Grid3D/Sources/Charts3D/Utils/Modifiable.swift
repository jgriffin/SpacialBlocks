//
// Created by John Griffin on 4/5/24
//

import Foundation

public protocol Modifiable {}

public extension Modifiable {
    func with(_ t: (inout Self) -> Void) -> Self {
        copy(self, with: t)
    }
}

public func copy<T>(_ t: T, with: (inout T) -> Void) -> T {
    var copy = t
    with(&copy)
    return copy
}
