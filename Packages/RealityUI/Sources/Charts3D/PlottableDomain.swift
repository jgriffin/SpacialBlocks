//
// Created by John Griffin on 4/22/24
//

import Foundation

// MARK: - Plottable Domain

public protocol PlottableDomain<Value> {
    associatedtype Value: Plottable
    var label: String { get }
    var values: [Value] { get set }

    func merging(_ value: any PlottableDomain) -> Self?
}

public extension PlottableDomain {
    typealias TypeID = String
    var typeId: TypeID { "\(ObjectIdentifier(Self.self)):\(label)" }
}

public struct PlottableValueDomain<Value: Plottable>: PlottableDomain {
    public let label: String
    public var values: [Value]

    public init(label: some StringProtocol, values: [Value]) {
        self.label = .init(label)
        self.values = values
    }

    public init(_ value: PlottableValue<Value>) {
        self.init(label: value.label, values: [value.value])
    }

    public func merging(_ other: any PlottableDomain) -> Self? {
        guard let other = other as? Self,
              label == other.label else { return nil }
        return modify(self) { $0.values.append(contentsOf: other.values) }
    }
}

// MARK: - PlottableDimensionDomains

public struct PlottableDomains {
    var domainsMap: [PlottableDomain.TypeID: any PlottableDomain]

    public init(_ domains: [PlottableDomain.TypeID: any PlottableDomain] = [:]) {
        domainsMap = domains
    }

    public init(_ domains: [any PlottableDomain]) {
        self = domains.reduce(into: PlottableDomains()) { result, next in
            result.merge(next)
        }
    }

    public init<Value: Plottable>(_ values: PlottableValue<Value>...) {
        let valueDomains = values.map { PlottableValueDomain($0) }
        self.init(valueDomains)
    }

    // MARK: merge

    public func domains<Value: Plottable>(_: Value.Type) -> [any PlottableDomain<Value>] {
        domainsMap
            .sorted(by: { lhs, rhs in lhs.key < rhs.key })
            .compactMap { $0.value as? any PlottableDomain<Value> }
    }

    // MARK: merge

    public mutating func merge(_ other: any PlottableDomain) {
        if let existing = domainsMap[other.typeId] {
            guard let merged = existing.merging(other) else { fatalError() }
            domainsMap[other.typeId] = merged
        } else {
            domainsMap[other.typeId] = other
        }
    }

    public mutating func merge(_ other: PlottableDomains) {
        for domain in other.domainsMap.values {
            merge(domain)
        }
    }

    // MARK: merging

    public func merging(_ other: PlottableDomains) -> PlottableDomains {
        modify(self) {
            for domain in other.domainsMap.values {
                $0.merge(domain)
            }
        }
    }
}

public struct DimensionDomains {
    public var x, y, z: PlottableDomains

    public init() {
        x = .init()
        y = .init()
        z = .init()
    }

    public init(
        x: PlottableDomains,
        y: PlottableDomains,
        z: PlottableDomains
    ) {
        self.x = x
        self.y = y
        self.z = z
    }
}

public extension DimensionDomains {
    mutating func merge(_ other: DimensionDomains) {
        x.merge(other.x)
        y.merge(other.y)
        z.merge(other.z)
    }

    func merging(_ other: DimensionDomains) -> DimensionDomains {
        modify(self) {
            $0.merge(other)
        }
    }
}
