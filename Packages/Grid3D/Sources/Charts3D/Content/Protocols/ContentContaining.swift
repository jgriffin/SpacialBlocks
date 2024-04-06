//
// Created by John Griffin on 4/5/24
//

import Foundation

public protocol ContentContaining: ChartContent {
    func childrenForRender(_ environment: RenderEnvironment) -> (RenderEnvironment, [EntityRepresentable])?
}
