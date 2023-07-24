//
//  Matcher.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

import Foundation

class Matcher {
    let expected: any Equatable
    init(_ expected: any Equatable) {
        self.expected = expected
    }

    func failureMessage(_ actual: Any) -> String {
        return "expected \(actual) to match \(expected)"
    }

    func negativeFailureMessage(_ actual: Any) -> String {
        return "expected \(actual) to not match \(expected)"
    }

    func match<T: Equatable>(_ actual: T) -> Bool {
        NSException(name: NSExceptionName.internalInconsistencyException,
                    reason:"Matchers must override match()",
                    userInfo: nil).raise()
        return false
    }

    func doesNotMatch<T: Equatable>(_ actual: T) -> Bool {
        NSException(name: NSExceptionName.internalInconsistencyException,
                    reason:"Matchers must override match()",
                    userInfo: nil).raise()
        return false
    }
}
