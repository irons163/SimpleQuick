//
//  Spec.m
//  SimpleQuick
//
//  Created by Phil Chang on 2023/7/25.
//  Copyright © 2023 Yahoo. All rights reserved.
//        

#import "Spec.h"

static Spec *currentSpec = nil;

@interface Spec ()
@end

@implementation Spec

#pragma mark - XCTestCase Overrides

#pragma mark - Public Interface

+ (void)spec { }

+ (Spec*) current {
    return currentSpec;
}

@end
