//
//  AsynchronousExpectation.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/20.
//

import Foundation
//import XCTest

public class AsynchronousExpectation {
    let timeOut: TimeInterval = 1.0
    let actualClosure: () -> (any Equatable)
    let negative: Bool
    public init(_ actualClosure: @escaping () -> any Equatable, negative: Bool) {
        self.actualClosure = actualClosure
        self.negative = negative
    }

    public func evaluate(_ matcher: Matcher) {
        let expirationDate = Date(timeIntervalSinceNow: timeOut)
        while (true) {
            let expired = Date().compare(expirationDate) != ComparisonResult.orderedAscending
            let actual = actualClosure()
            let matched = matcher.match(actual)

            // The semantics of "will" and "will not" differ greatly.
            //
            // We can stop waiting for "will" as soon as we match, even if we have not
            // waited until a time out.
            //
            // "willNot", on the other hand, implies that we never matched,
            // even after waiting until the time out.
            if (negative && _shouldEndNegativeWait(expired, matched, matcher.negativeFailureMessage(actual)) ||
                !negative && _shouldEndPositiveWait(expired, matched, matcher.failureMessage(actual))) {
                    break
            }

            RunLoop.current.run(until: Date(timeIntervalSinceNow:0.01))
        }
    }

    func _shouldEndPositiveWait(_ expired: Bool, _ matched: Bool, _ failureMessage: String) -> Bool {
        if matched || expired {
            if !matched {
//                XCTFail(failureMessage)
                NSException(name: NSExceptionName.internalInconsistencyException,
                    reason: "Subclasses must override this method", userInfo: nil).raise()
            }
            return true
        } else {
            return false
        }
    }

    func _shouldEndNegativeWait(_ expired: Bool, _ matched: Bool, _ failureMessage: String) -> Bool {
        if expired {
            if matched {
//                XCTFail(failureMessage)
                NSException(name: NSExceptionName.internalInconsistencyException,
                    reason: "Subclasses must override this method", userInfo: nil).raise()
            }
            return true
        } else {
            return false
        }
    }
}
