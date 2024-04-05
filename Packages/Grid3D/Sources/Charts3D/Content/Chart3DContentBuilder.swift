//
// Created by John Griffin on 4/5/24
//

import Foundation

@resultBuilder
public enum Chart3DContentBuilder {
    public static func buildBlock(_ components: Chart3DContent...) -> [Chart3DContent] {
        components
    }
}
