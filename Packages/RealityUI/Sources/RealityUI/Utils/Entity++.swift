//
// Created by John Griffin on 4/19/24
//

import RealityKit

extension Entity {
    func modify(_ with: (Self) -> Void) -> Self {
        with(self)
        return self
    }
}
