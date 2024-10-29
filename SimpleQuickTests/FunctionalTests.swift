//
//  Functional.swift
//  SimpleQuickTests
//
//  Created by Phil Chang on 2023/7/17.
//

import SimpleQuick
import XCTest
//@testable import SimpleQuick
class FunctionalSpec: Spec {
    override var name: String { get { return "FunctionalSpec" } }
    class var isConcreteSpec: Bool { get { return true } }

    override func setUp() {
        currentSpec = FunctionalSpec.specName
        currentExampleGroup = rootExampleGroupForSpec(name: FunctionalSpec.specName)
    }

    class var specName: String { get { return NSStringFromClass(self) } }
//    class func exampleGroups() { }

    func runExampleAtIndex(index: Int) {
        rootExampleGroupForSpec(name: NSStringFromClass(type(of: self))).examples[index].run()
    }

    func testAll() {
        self.exampleGroups()
//        currentExampleGroup?.examples.forEach({ example in
//            example.run()
//        })
    }

    func exampleGroups() {
        describe("Person") {
            var person: Person?
            var thing = false
            var dinosaursExtinct = false
            var mankindExtinct = false

            beforeSuite {
                assert(!dinosaursExtinct, "nothing goes extinct twice")
                dinosaursExtinct = true
            }

            beforeEach { person = Person() }

            it("is happy") {
                XCTAssert(person!.isHappy, "expected person to be happy by default")
            }

            it("is a dreamer").expect(closure: { person!.hopes }).to.contain("winning the lottery")

            it("gets hungry") {
                person!.eatChineseFood()
            }.expect{person!.isHungry}.will.beTrue()

            it("will never be satisfied")
                .expect{person!.isSatisfied}.willNot.beTrue()

            it("does not live with dinosaurs")
                .expect(closure: { dinosaursExtinct }).to.beTrue()
            then
                .expect(closure: { mankindExtinct }).toNot.beTrue()

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

            afterEach() { person = nil }

            afterSuite {
                assert(!mankindExtinct, "tests shouldn't run after the apocalypse")
                mankindExtinct = true
            }
        }
    }
}

class PoetSpec: Spec {

    class var specName: String { get { return NSStringFromClass(self) } }

    override func setUp() {
        currentSpec = PoetSpec.specName
        currentExampleGroup = rootExampleGroupForSpec(name: PoetSpec.specName)
//        exampleGroups()
    }

    func testAll() {
        exampleGroups()
//        currentExampleGroup?.examples.forEach({ example in
//            example.run()
//        })
    }

    func exampleGroups() {
        describe("Poet") {
            var poet: Poet?
            beforeEach { poet = Poet() }

            describe("greeting") {
                context("when the poet is unhappy") {
                    beforeEach { poet!.isHappy = false }
                    it("is dramatic").expect(closure: { poet!.greeting }).to.equal("Woe is me!")
                }

                context("when the poet is happy") {
                    beforeEach { poet!.isHappy = true }
                    it("is joyous").expect(closure: { poet!.greeting }).to.equal("Oh, joyous day!")
                }
            }
        }
    }
}
