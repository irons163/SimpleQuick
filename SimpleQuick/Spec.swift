//
//  Spec.swift
//  SimpleQuick
//
//  Created by Phil Chang on 2023/7/25.
//  Copyright © 2023 Yahoo. All rights reserved.
//        

import XCTest
//#if SWIFT_PACKAGE
open class Spec: XCTestCase {
    public var currentSpec: String?
    public var currentExampleGroup: ExampleGroup?

    public func rootExampleGroupForSpec(name: String) -> ExampleGroup {
        if let group = specs[name] {
            return group
        } else {
            let group = ExampleGroup("root example group")
            specs[name] = group
            return group
        }
    }

    func appendBeforeSuite(_ closure: @escaping () -> ()) {
        _beforeSuite.append(closure)
    }

    func appendAfterSuite(_ closure: @escaping () -> ()) {
        _afterSuite.append(closure)
    }

    @discardableResult
    public func describe(_ description: String, closure: () -> ()) -> Self {
        var group = ExampleGroup(description)
        currentExampleGroup!.appendExampleGroup(group: group)
        currentExampleGroup = group
        closure()
        currentExampleGroup = group.parent
        return self
    }

    @discardableResult
    public func context(_ description: String, closure: () -> ()) -> Self {
        describe(description, closure: closure)
    }

    public func beforeEach(closure: @escaping () -> ()) {
//        currentExampleGroup!.localBefores.append(closure)
        closure()
    }

    public func afterEach(closure: @escaping () -> ()) {
//        currentExampleGroup!.localAfters.append(closure)
        closure()
    }

    public func beforeSuite(closure: @escaping () -> ()) {
//        appendBeforeSuite(closure)
        closure()
    }

    public func afterSuite(closure: @escaping () -> ()) {
//        appendAfterSuite(closure)
        closure()
    }

    @discardableResult
    public func it(_ description: String, closure: (() -> ())? = nil) -> Self {
        let example = Example(description, closure)
        currentExampleGroup!.appendExample(example: example)
        closure?()
        return self
    }

//    func expect<T: Equatable>(_ actual: T) -> Actual {
//        return Actual(actual)
//    }

    public func expect(closure: @escaping () -> (any Equatable)) -> ActualClosure {
        return ActualClosure(closure)
    }

    public var then: Spec {
        return self
    }

    public func then(_ description: String = "", closure: (() -> ())? = nil) -> Self {
        let example = Example(description, closure)
        currentExampleGroup!.appendExample(example: example)
        return self
    }
}
//#endif
