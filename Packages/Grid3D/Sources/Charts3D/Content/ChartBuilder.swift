//
// Created by John Griffin on 4/5/24
//

import Foundation

@resultBuilder
public enum ChartBuilder {
    public static func buildBlock(_ components: ChartContent...) -> [ChartContent] {
        components
    }
}
