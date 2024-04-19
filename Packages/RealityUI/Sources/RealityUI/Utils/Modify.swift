//
// Created by John Griffin on 4/18/24
//

import Foundation

@available(*, unavailable, message: "Don't use modify with classes")
func modify<T: AnyObject>(_ t: T, with: (T) -> Void) -> T {
    with(t)
    return t
}

func modify<T>(_ t: T, with: (inout T) -> Void) -> T {
    var copy = t
    with(&copy)
    return copy
}
