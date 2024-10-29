//
//  Contain.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

import Foundation

class Contain: Matcher {
    override func failureMessage(_ actual: Any) -> String {
        return "expected \(actual) to contain \(expected)"
    }

    override func negativeFailureMessage(_ actual: Any) -> String {
        return "expected \(actual) to contain \(expected)"
    }

    override func match<T: Equatable>(_ actual: T) -> Bool {
        if let array = actual as? NSArray {
            return array.contains(expected)
        } else if let set = actual as? NSSet {
            return set.contains(expected)
        } else {
            return false
        }
    }
}

extension Expectation {
    public func contain(_ expected: any Equatable) {
        evaluate(Contain(expected))
    }
}
