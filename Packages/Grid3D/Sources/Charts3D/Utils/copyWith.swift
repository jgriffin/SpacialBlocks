//
// Created by John Griffin on 4/5/24
//

import Foundation

public func copy<T>(_ t: T, with: (inout T) -> Void) -> T {
    var copy = t
    with(&copy)
    return copy
}
