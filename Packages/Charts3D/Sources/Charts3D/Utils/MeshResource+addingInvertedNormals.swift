//
// Created by John Griffin on 4/8/24
//

import Foundation
import RealityKit

public extension MeshResource {
    // call this to create a 2-sided mesh that will then be displayed
    func addingInvertedNormals() throws -> MeshResource {
        try MeshResource.generate(from: contents.addingInvertedNormals())
    }

    // call this on a mesh that is already displayed to make it 2 sided
    func addInvertedNormals() throws {
        try replace(with: contents.addingInvertedNormals())
    }

    static func generateTwoSidedPlane(
        width: Float,
        height: Float,
        cornerRadius: Float = 0
    ) -> MeshResource {
        let plane = generatePlane(width: width, height: height, cornerRadius: cornerRadius)
        let twoSided = try? plane.addingInvertedNormals()
        return twoSided ?? plane
    }
}

public extension MeshResource.Contents {
    func addingInvertedNormals() -> MeshResource.Contents {
        var newContents = self
        newContents.models = .init(models.map { $0.addingInvertedNormals() })
        return newContents
    }
}

public extension MeshResource.Model {
    func addingInvertedNormals() -> MeshResource.Model {
        addingParts(partsWithNormalsInverted())
    }

    func addingParts(_ additionalParts: [MeshResource.Part]) -> MeshResource.Model {
        modify(self) {
            $0.parts = .init(parts.map { $0 } + additionalParts)
        }
    }

    func partsWithNormalsInverted() -> [MeshResource.Part] {
        parts.compactMap { $0.normalsInverted() }
    }
}

public extension MeshResource.Part {
    func normalsInverted() -> MeshResource.Part? {
        guard let normals, let triangleIndices else {
            print("No normals to invert, returning nil")
            return nil
        }

        let newNormals = normals.map { $0 * -1.0 }
        let newPart = modify(self) {
            $0.normals = .init(newNormals)
            // ordering of points in the triangles must be reversed,
            // or the inversion of the normal has no effect
            $0.triangleIndices = .init(triangleIndices.reversed())
            // id must be unique, or others with that id will be discarded
            $0.id = id + " with inverted normals"
        }
        return newPart
    }
}
