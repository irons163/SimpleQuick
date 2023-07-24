//
//  Expectation.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

import XCTest

func expect<T: Equatable>(_ actual: T) -> Actual {
    return Actual(actual)
}

func expect(closure: @escaping () -> (any Equatable)) -> ActualClosure {
    return ActualClosure(closure)
}

class Prediction {
    let negative: Bool

    init(negative: Bool) {
        self.negative = negative
    }

    func evaluate(_ matcher: Matcher, ignoreFail: ((_ failureMessage: String) -> ())? = nil) {
        NSException(name: NSExceptionName.internalInconsistencyException,
            reason: "Subclasses must override this method", userInfo: nil).raise()
    }
}

class Expectation: Prediction {
    let actual: any Equatable
    init(_ actual: any Equatable, negative: Bool = false) {
        self.actual = actual
        super.init(negative: negative)
    }

    override func evaluate(_ matcher: Matcher, ignoreFail: ((_ failureMessage: String) -> ())? = nil) {
        if negative,
            matcher.match(actual) {
            let failureMessage = matcher.failureMessage(actual)
            if let ignoreFail {
                ignoreFail(failureMessage)
            } else {
                XCTFail(failureMessage)
            }
        } else if !negative && !matcher.match(actual) {
            let failureMessage = matcher.failureMessage(actual)
            if let ignoreFail {
                ignoreFail(failureMessage)
            } else {
                XCTFail(failureMessage)
            }
        }
    }


}
