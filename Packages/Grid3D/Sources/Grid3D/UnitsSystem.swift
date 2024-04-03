import RealityKit

public class UnitsSystem: RealityKit.System {
    private static let unitsFitQuery = EntityQuery(where: .has(UnitsFitComponent.self))
    private static let unitsPositionQuery = EntityQuery(where: .has(UnitsComponent.self))

    private var previousState: State?

    private struct State: Equatable {
        let fit: UnitsFit
        let unitsById: UnitsById
    }

    typealias UnitsById = [Entity.ID: UnitsComponent]

    public required init(scene _: Scene) {}

    public static func ensureRegistered() { registerOnce }
    private static let registerOnce: Void = UnitsSystem.registerSystem()

    public func update(context: SceneUpdateContext) {
        guard let fit = context.scene.performQuery(Self.unitsFitQuery)
            .compactMap(\.fitComponent).first?.fit
        else {
            return
        }

        let entities = Array(context.scene.performQuery(Self.unitsPositionQuery))
        let unitsById = entities.reduce(into: UnitsById()) { result, entity in
            guard let units = entity.unitsComponent else { return }
            result[entity.id] = units
        }
        let nextState = State(fit: fit, unitsById: unitsById)

        guard previousState != nextState else {
            return
        }
        previousState = nextState
        fit.updatePositionsFor(entities)
    }
}

public struct UnitsComponent: Component, Equatable {
    public var position: Units

    public init(unitsPosition: Units) {
        position = unitsPosition
    }
}

public struct UnitsFitComponent: Component, Equatable {
    var fit: UnitsFit

    init(fit: UnitsFit) {
        self.fit = fit
    }
}

public extension Entity {
    var unitsComponent: UnitsComponent? {
        get { components[UnitsComponent.self] }
        set { components[UnitsComponent.self] = newValue }
    }

    var unitsPosition: Units? {
        get { unitsComponent?.position }
        set {
            unitsComponent = newValue.map { UnitsComponent(unitsPosition: $0) }
        }
    }

    var fitComponent: UnitsFitComponent? {
        get { components[UnitsFitComponent.self] }
        set { components[UnitsFitComponent.self] = newValue }
    }

    var unitsFit: UnitsFit? {
        get { fitComponent?.fit }
        set { fitComponent = newValue.map { UnitsFitComponent(fit: $0) } }
    }
}
