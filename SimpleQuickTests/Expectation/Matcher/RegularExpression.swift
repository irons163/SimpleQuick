//
//  RegularExpression.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/24.
//

class RegularExpression: Matcher {
    override func failureMessage(_ actual: Any) -> String {
        return "expected \(actual) to be equal to \(expected)"
    }

    override func negativeFailureMessage(_ actual: Any) -> String {
        return "expected \(actual) to not be equal to \(expected)"
    }

    override func match<T: Equatable>(_ actual: T) -> Bool {
        guard let actual = actual as? String,
              let expected = expected as? String else {
            return false
        }
        return actual.range(of: expected, options: [.regularExpression]) != nil
    }
}

extension Expectation {
    func match(_ expected: any Equatable) {
        evaluate(Equal(expected))
    }
}
