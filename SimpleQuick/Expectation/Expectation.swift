//
//  Expectation.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/19.
//

//import XCTest

public class Prediction {
    let negative: Bool

    public init(negative: Bool) {
        self.negative = negative
    }

    public func evaluate(_ matcher: Matcher, ignoreFail: ((_ failureMessage: String) -> ())? = nil) {
        NSException(name: NSExceptionName.internalInconsistencyException,
            reason: "Subclasses must override this method", userInfo: nil).raise()
    }
}

public class Expectation: Prediction {
    var actual: any Equatable {
        return actualClosure()
    }
    let actualClosure: () -> (any Equatable)
    public init(_ actualClosure: @escaping () -> (any Equatable), negative: Bool = false) {
        self.actualClosure = actualClosure
        super.init(negative: negative)
    }

    override public func evaluate(_ matcher: Matcher, ignoreFail: ((_ failureMessage: String) -> ())? = nil) {
        if negative,
            matcher.match(actual) {
            let failureMessage = matcher.failureMessage(actual)
            if let ignoreFail {
                ignoreFail(failureMessage)
            } else {
//                XCTFail(failureMessage)
                NSException(name: NSExceptionName.internalInconsistencyException,
                    reason: "Subclasses must override this method", userInfo: nil).raise()
            }
        } else if !negative && !matcher.match(actual) {
            let failureMessage = matcher.failureMessage(actual)
            if let ignoreFail {
                ignoreFail(failureMessage)
            } else {
//                XCTFail(failureMessage)
                NSException(name: NSExceptionName.internalInconsistencyException,
                    reason: "Subclasses must override this method", userInfo: nil).raise()
            }
        }
    }


}
