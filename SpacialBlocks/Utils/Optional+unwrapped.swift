//
// Created by John Griffin on 4/2/24
//

import Foundation

extension Optional {
    func unwrapped(_ message: String? = nil) throws -> Wrapped {
        guard let value = self else { throw UnwrappedError.unwrappingNil(message) }
        return value
    }

    var unwrapped: Wrapped {
        get throws { try unwrapped() }
    }

    enum UnwrappedError: Error {
        case unwrappingNil(String?)
    }
}
