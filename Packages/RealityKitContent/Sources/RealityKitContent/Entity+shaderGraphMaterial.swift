//
// Created by John Griffin on 4/2/24
//

import RealityKit

extension Entity {
    var modelComponent: ModelComponent? {
        components[ModelComponent.self]
    }

    var shaderGraphMaterial: ShaderGraphMaterial? {
        modelComponent?.materials.first as? ShaderGraphMaterial
    }

    func update(shaderGraphMaterial oldMaterial: ShaderGraphMaterial,
                _ handler: (inout ShaderGraphMaterial) throws -> Void) rethrows
    {
        var material = oldMaterial
        try handler(&material)

        if var component = modelComponent {
            component.materials = [material]
            components.set(component)
        }
    }

    var parameterNames: [String]? {
        shaderGraphMaterial?.parameterNames
    }

    func hasMaterialParameter(named: String) -> Bool {
        parameterNames?.contains(where: { $0 == named }) ?? false
    }

    func findShaderMaterial(holderName: String) -> ShaderGraphMaterial? {
        findEntity(named: holderName)?.shaderGraphMaterial
    }
}

extension ShaderGraphMaterial {
    mutating func setParameter(_ name: some RawRepresentable<String>, value: MaterialParameters.Value) throws {
        try setParameter(name: name.rawValue, value: value)
    }
}
