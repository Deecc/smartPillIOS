//
//  SmartPillTests.m
//  SmartPillTests
//
//  Created by Dennis da Silva Nunes on 11/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPUserHandler.h"

@interface SPTests : XCTestCase

@end

@implementation SPTests



- (void)testCreateFacebookUserWithName
{
    id user = [SPUserHandler createFacebookUserWithName:@"julian" Email:@"juliansansat@yahoo.com.br" UserFacebookId:@"julianignacio"];
    
    XCTAssertNotNil(user, @"is nil");
    //if ([user isKindOfClass:[SPUser class]]) {
    //  NSLog(@"Teste do usuário %@", [user name]);
    //}
}

@end

