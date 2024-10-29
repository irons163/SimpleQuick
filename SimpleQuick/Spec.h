//
//  Spec.h
//  SimpleQuick
//
//  Created by Phil Chang on 2023/7/25.
//  Copyright © 2023 Yahoo. All rights reserved.
//        

#import <XCTest/XCTest.h>

@interface Spec : XCTestCase

/**
 Override this method in your spec to define a set of example groups
 and examples.

 @code
 override class func spec() {
     describe("winter") {
         it("is coming") {
             // ...
         }
     }
 }
 @endcode

 See DSL.swift for more information on what syntax is available.
 */
+ (void)spec;

/**
 Returns the currently executing spec. Use in specs that require XCTestCase
 methods, e.g. expectationWithDescription.

 If you're using `beforeSuite`/`afterSuite`, you should consider the ``currentSpec()`` helper.
*/
@property (class, nonatomic, readonly) Spec *current;

@end
