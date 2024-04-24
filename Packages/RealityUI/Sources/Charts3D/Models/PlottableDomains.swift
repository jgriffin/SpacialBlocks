//
// Created by John Griffin on 4/22/24
//

import Foundation

// MARK: - PlottableDomains

/// (Dictionary) collection of domains
public struct PlottableDomains: CustomStringConvertible {
    var domainsByName: [DomainName: any PlottableDomain]

    public init(_ domains: [DomainName: any PlottableDomain] = [:]) {
        domainsByName = domains
    }

    // MARK: convenience initializers

    public init(_ domains: [any PlottableDomain]) {
        self = domains.reduce(into: PlottableDomains()) { result, next in
            result.merge(next)
        }
    }

    public init<X: Plottable, Y: Plottable, Z: Plottable>(
        x: PlottableValue<X>...,
        y: PlottableValue<Y>...,
        z: PlottableValue<Z>...
    ) {
        var domains = PlottableDomains()
        x.forEach { domains.merge(PlottableValueDomain(axis: .x, $0)) }
        y.forEach { domains.merge(PlottableValueDomain(axis: .y, $0)) }
        z.forEach { domains.merge(PlottableValueDomain(axis: .z, $0)) }
        self = domains
    }

    // MARK: accessors

    public func domains<Value: Plottable>(_: Value.Type) -> [any PlottableDomain<Value>] {
        domainsByName
            .sorted(by: { lhs, rhs in lhs.key < rhs.key })
            .compactMap { $0.value as? any PlottableDomain<Value> }
    }

    // MARK: merge

    public mutating func merge(_ other: any PlottableDomain) {
        if let existing = domainsByName[other.name] {
            guard let merged = existing.merging(other) else { fatalError() }
            domainsByName[other.name] = merged
        } else {
            domainsByName[other.name] = other
        }
    }

    public mutating func merge(_ other: PlottableDomains) {
        for domain in other.domainsByName.values {
            merge(domain)
        }
    }

    public func merging(_ other: PlottableDomains) -> PlottableDomains {
        modify(self) {
            for domain in other.domainsByName.values {
                $0.merge(domain)
            }
        }
    }

    public var description: String {
        domainsByName.values.map { "\($0)" }.joined(separator: ", ")
    }
}

// MARK: - DomainName

public enum DomainAxis: Hashable, Comparable { case x, y, z }

/// Axis and label for identifying domains
public struct DomainName: Hashable, CustomStringConvertible, Comparable {
    public let axis: DomainAxis
    public let label: String

    public init(axis: DomainAxis, label: some StringProtocol) {
        self.axis = axis
        self.label = .init(label)
    }

    // MARK: convenience initializers

    public static func x(_ label: some StringProtocol) -> DomainName {
        DomainName(axis: .x, label: label)
    }

    public static func y(_ label: some StringProtocol) -> DomainName {
        DomainName(axis: .y, label: label)
    }

    public static func z(_ label: some StringProtocol) -> DomainName {
        DomainName(axis: .z, label: label)
    }

    // MARK: members

    public static func < (lhs: DomainName, rhs: DomainName) -> Bool {
        guard lhs.axis == rhs.axis else { return lhs.axis < rhs.axis }
        return lhs.label < rhs.label
    }

    public var description: String {
        "\(axis): \(label)"
    }
}

// MARK: - PlottableDomain

/// protocol for generic collections of domains
public protocol PlottableDomain<Value> {
    associatedtype Value: Plottable
    var name: DomainName { get }
    var values: [Value] { get set }

    func merging(_ value: any PlottableDomain) -> Self?
}

// MARK: - PlottableValueDomain

/// concrete domain of values
public struct PlottableValueDomain<Value: Plottable>: PlottableDomain, CustomStringConvertible {
    public let name: DomainName
    public var values: [Value]

    public init(_ name: DomainName, values: [Value]) {
        self.name = name
        self.values = values
    }

    // MARK: convenience initializers

    public init(axis: DomainAxis, _ value: PlottableValue<Value>) {
        self.init(.init(axis: axis, label: value.label), values: [value.value])
    }

    public func merging(_ other: any PlottableDomain) -> Self? {
        guard let other = other as? Self,
              name == other.name else { return nil }
        return modify(self) { $0.values.append(contentsOf: other.values) }
    }

    public var description: String {
        "'\(name)': \(Value.self) - \(values)"
    }
}
