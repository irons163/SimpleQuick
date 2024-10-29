//
//  Actual.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

//class Actual {
//    let actual: any Equatable
//    init(_ actual: any Equatable) {
//        self.actual = actual
//    }
//
//    var to: Expectation { get { return Expectation(actual) } }
//    var notTo: Expectation { get { return Expectation(actual, negative: true) } }
//    var toNot: Expectation { get { return notTo } }
//}

public class ActualClosure {
    let actualClosure: () -> (any Equatable)

    init(_ actualClosure: @escaping () -> (any Equatable)) {
        self.actualClosure = actualClosure
    }

    public var to: Expectation { get { return Expectation(actualClosure) } }
    public var notTo: Expectation { get { return Expectation(actualClosure, negative: true) } }
    public var toNot: Expectation { get { return notTo } }

    public var will: AsynchronousExpectation {
        get { return AsynchronousExpectation(actualClosure, negative: false) }
    }

    public var willNot: AsynchronousExpectation {
        get { return AsynchronousExpectation(actualClosure, negative: true) }
    }
}
