//
//  Functional.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/17.
//

import XCTest

var currentSpec: String?
var currentExampleGroup: ExampleGroup?
var specs: Dictionary<String, ExampleGroup> = [:]
var _beforeSuite: [(() -> ())] = []
var _beforeSuiteNotRunYet = true
var _afterSuite: [(() -> ())] = []
var _afterSuiteNotRunYet = true

var exampleCount: Int {
    get {
        var count = 0
        for (_, group) in specs {
            group.walkDownExamples { (example: Example) -> () in
                count += 1
            }
        }
        return count
    }
}

func rootExampleGroupForSpec(name: String) -> ExampleGroup {
    if let group = specs[name] {
        return group
    } else {
        let group = ExampleGroup("root example group")
        specs[name] = group
        return group
    }
}

func runBeforeSpec() {
    assert(_beforeSuiteNotRunYet, "runBeforeSuite was called twice")
    for closure in _beforeSuite {
        closure()
    }
    _beforeSuiteNotRunYet = false
}

func runAfterSpec() {
    assert(_afterSuiteNotRunYet, "runAfterSuite was called twice")
    for closure in _afterSuite {
        closure()
    }
    _afterSuiteNotRunYet = false
}

func appendBeforeSuite(_ closure: @escaping () -> ()) {
    _beforeSuite.append(closure)
}

func appendAfterSuite(_ closure: @escaping () -> ()) {
    _afterSuite.append(closure)
}

func describe(_ description: String, closure: () -> ()) {
    var group = ExampleGroup(description)
    currentExampleGroup!.appendExampleGroup(group: group)
    currentExampleGroup = group
    closure()
    currentExampleGroup = group.parent
}

func context(_ description: String, closure: () -> ()) {
    describe(description, closure: closure)
}

func beforeEach(closure: @escaping () -> ()) {
    currentExampleGroup!.localBefores.append(closure)
}

func afterEach(closure: @escaping () -> ()) {
    currentExampleGroup!.localAfters.append(closure)
}

func beforeSuite(closure: @escaping () -> ()) {
    appendBeforeSuite(closure)
}

func afterSuite(closure: @escaping () -> ()) {
    appendAfterSuite(closure)
}

func it(_ description: String, closure: @escaping () -> ()) {
    let example = Example(description, closure)
    currentExampleGroup!.appendExample(example: example)
}

class FunctionalSpec: XCTestCase {
    override var name: String { get { return "FunctionalSpec" } }
    class var isConcreteSpec: Bool { get { return true } }

    override class func setUp() {
        currentSpec = FunctionalSpec.specName
        currentExampleGroup = rootExampleGroupForSpec(name: FunctionalSpec.specName)
        FunctionalSpec.exampleGroups()
    }

    class var specName: String { get { return NSStringFromClass(self) } }
//    class func exampleGroups() { }

    func runExampleAtIndex(index: Int) {
        rootExampleGroupForSpec(name: NSStringFromClass(type(of: self))).examples[index].run()
    }

    func testAll() {
        currentExampleGroup?.examples.forEach({ example in
            example.run()
        })
    }

    class func exampleGroups() {
        describe("Person") {
            var person: Person?
            var thing = false
            var dinosaursExtinct = false
            var mankindExtinct = false

            beforeSuite {
                assert(!dinosaursExtinct, "nothing goes extinct twice")
                dinosaursExtinct = true
            }

            afterSuite {
                assert(!mankindExtinct, "tests shouldn't run after the apocalypse")
                mankindExtinct = true
            }

            beforeEach() { person = Person() }
            afterEach() { person = nil }


            it("is happy") {
                XCTAssert(person!.isHappy, "expected person to be happy by default")
            }

            it("is a dreamer") {
                expect(person!.hopes).to.contain("winning the lottery")
            }

            it("gets hungry") {
                person!.eatChineseFood()
                expect{person!.isHungry}.will.beTrue()
            }

            it("will never be satisfied") {
                expect{person!.isSatisfied}.willNot.beTrue()
            }

            it("does not live with dinosaurs") {
                expect(dinosaursExtinct).to.beTrue()
                expect(mankindExtinct).toNot.beTrue()
            }

            describe("greeting") {
                context("when the person is unhappy") {
                    beforeEach() { person!.isHappy = false }
                    it("is lukewarm") {
                        XCTAssertEqual(person!.greeting, "Oh, hi.", "expected a lukewarm greeting")
                    }
                }

                context("when the person is happy") {
                    beforeEach() { person!.isHappy = true }
                    it("is enthusiastic") {
                        XCTAssertEqual(person!.greeting, "Hello!", "expected an enthusiastic greeting")
                    }
                }
            }
        }
    }
}

class PoetSpec: XCTestCase {

    class var specName: String { get { return NSStringFromClass(self) } }

    override class func setUp() {
        currentSpec = PoetSpec.specName
        currentExampleGroup = rootExampleGroupForSpec(name: PoetSpec.specName)
        PoetSpec.exampleGroups()
    }

    func testAll() {
        currentExampleGroup?.examples.forEach({ example in
            example.run()
        })
    }

    class func exampleGroups() {
        describe("Poet") {
            // FIXME: Radar worthy? `var poet: Poet?` results in build error:
            // "Could not find member 'greeting'"
            var poet: Person?
            beforeEach { poet = Poet() }

            describe("greeting") {
                context("when the poet is unhappy") {
                    beforeEach { poet!.isHappy = false }
                    it("is dramatic") {
                        expect(poet!.greeting).to.equal("Woe is me!")
                    }
                }

                context("when the poet is happy") {
                    beforeEach { poet!.isHappy = true }
                    it("is joyous") {
                        expect(poet!.greeting).to.equal("Oh, joyous day!")
                    }
                }
            }
        }
    }
}
