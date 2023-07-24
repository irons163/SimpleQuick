//
//  ExampleGroupTests.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/17.
//

import XCTest

func testExampleGroups() {
    var root = ExampleGroup("Person")

    var person: Person?
    root.localBefores.append() {
        person = Person()
    }

    var itIsHappy = Example("is happy") {
        XCTAssert(person!.isHappy, "expected person to be happy by default")
    }
    root.appendExample(example: itIsHappy)

    var whenUnhappy = ExampleGroup("when the person is unhappy")
    whenUnhappy.localBefores.append() {
        person!.isHappy = false
    }
    var itGreetsHalfheartedly = Example("greets halfheartedly") {
        XCTAssertEqual(person!.greeting, "Oh, hi.", "expected a halfhearted greeting")
    }
    whenUnhappy.appendExample(example: itGreetsHalfheartedly)
    root.appendExampleGroup(group: whenUnhappy)

    var whenHappy = ExampleGroup("when the person is happy")
    var itGreetsEnthusiastically = Example("greets enthusiastically") {
        XCTAssertEqual(person!.greeting, "Hello!", "expected an enthusiastic greeting")
    }
    whenHappy.appendExample(example: itGreetsEnthusiastically)
    root.appendExampleGroup(group: whenHappy)

    root.run()
}
