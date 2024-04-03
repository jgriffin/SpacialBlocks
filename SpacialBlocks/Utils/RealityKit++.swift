//
// Created by John Griffin on 4/1/24
//

import RealityKit

extension RealityKit.Material {
    func repeating(_ count: Int) -> [Self] {
        Array(repeating: self, count: count)
    }
}

extension RealityKit.ModelComponent {
    init(mesh: MeshResource, material: any RealityKit.Material) {
        self.init(mesh: mesh, materials: material.repeating(mesh.expectedMaterialCount))
    }
}
