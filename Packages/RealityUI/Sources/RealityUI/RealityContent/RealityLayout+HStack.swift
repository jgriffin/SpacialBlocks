//
// Created by John Griffin on 4/19/24
//

import Spatial

public struct HStackLayout: RealityLayout {
    public func sizeThatFits(contents: [any RealityContent], proposal: ProposedSize3D) -> Size3D {
        guard !contents.isEmpty else { return .zero }

        let proposed = modify(proposal) {
            $0.width = $0.width.map { $0 / .init(contents.count) } ?? ProposedSize3D.defaultSize.width
        }

        let sizes = contents.map { $0.sizeThatFits(proposed) }

        let size = Size3D(
            width: sizes.map(\.width).reduce(0, +),
            height: sizes.map(\.height).reduce(0, max),
            depth: sizes.map(\.depth).reduce(0, max)
        )
        return size
    }

    public func placeContents(contents: [any RealityContent], in size: Size3D) -> [LayoutContentPlacement] {
        guard !contents.isEmpty else { return [] }

        let proposed = modify(ProposedSize3D(size)) {
            $0.width = $0.width.map { $0 / .init(contents.count) } ?? ProposedSize3D.defaultSize.width
        }
        let sizes = contents.map { $0.sizeThatFits(proposed) }

        var position = Point3D()
        let placements = zip(contents, sizes).map { content, size in
            defer { position.x += size.width }
            return LayoutContentPlacement(content: content, size: size, position: position)
        }
        print("placements", placements.map { "\($0.size) \($0.position)" })
        return placements
    }
}

public struct RealityHStack: RealityContent {
    let contents: [any RealityContent]

    public init(@RealityContentsBuilder contents: () -> [any RealityContent]) {
        self.contents = contents()
    }

    public var body: some RealityContent {
        RealityStack(layout: HStackLayout(), contents: contents)
    }
}
