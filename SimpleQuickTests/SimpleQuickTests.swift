//
//  SimpleQuickTests.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/24.
//

import XCTest
//@testable import SimpleQuick
import SimpleQuick

class MatchTest: Spec {

    func testMatchPositive() {
        expect(closure: { "11:14" }).to.evaluate(RegularExpression("\\d{2}:\\d{2}"))
    }

    func testMatchNegative() {
        expect(closure: { "hello" }).toNot.evaluate(RegularExpression("\\d{2}:\\d{2}"))
    }

    func testMatchPositiveMessage() {
            expect(closure: { "hello" }).to.evaluate(RegularExpression("\\d{2}:\\d{2}")) { failureMessage in
            print("\(failureMessage), but somewhat want to testing continue")
        }
    }

    func testMatchNegativeMessage() {
        let customFailureMessage = "expected to not match <\\d{2}:\\d{2}>, got <11:14>"
            expect(closure: { "11:14" })
            .toNot.evaluate(RegularExpression("\\d{2}:\\d{2}")) { failureMessage in
                print(customFailureMessage)
                print("failed, but somewhat want to testing")
            }
    }

    func testMatchNils() {
            expect(closure: { nil as String? }).to.evaluate(RegularExpression("\\d{2}:\\d{2}")) { failureMessage in
            print("failed, but somewhat want to testing")
        }
            expect(closure: { nil as String? }).toNot.evaluate(RegularExpression("\\d{2}:\\d{2}"))
    }
}
