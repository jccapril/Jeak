//
//  Chain.swift
//  UICore
//
//  Created by Flutter on 2021/3/23.
//


public protocol Leaf {
    associatedtype LeafType
    var leaf: LeafType { get }
    static var leaf: LeafType.Type { get }
}

public extension Leaf {
    var leaf: LeafBox<Self> { LeafBox(value: self) }

    static var leaf: LeafBox<Self>.Type { LeafBox.self }
}


public struct LeafBox<T> {
    public let value: T

    public init(value: T) { self.value = value }
}

public extension LeafBox {
    var instance: T { value }
}
