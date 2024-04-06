//
// Created by John Griffin on 4/5/24
//

import Foundation

public protocol Chart3DContentContainer: Chart3DContent {
    func childrenForRender(_ environment: RenderEnvironment) -> (RenderEnvironment, [EntityRepresentableContent])?
}
