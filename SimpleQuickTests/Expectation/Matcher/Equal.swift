//
//  Equal.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

class Equal: Matcher {
    override func failureMessage(_ actual: Any) -> String {
        return "expected \(actual) to be equal to \(expected)"
    }

    override func negativeFailureMessage(_ actual: Any) -> String {
        return "expected \(actual) to not be equal to \(expected)"
    }

    override func match<T: Equatable>(_ actual: T) -> Bool {
        guard let expected = expected as? T else {
            return false
        }
        return actual == expected
    }
}

extension Expectation {
    func equal(_ expected: any Equatable) {
        evaluate(Equal(expected))
    }
}
