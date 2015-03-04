//
//  SPConnectionRest.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 09/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//
#import "SPUserHandler.h"
#import <Foundation/Foundation.h>

@interface SPConnectionRest : NSObject

- (NSDictionary*)fetchUserFromServer:(SPUser*)user;
- (BOOL)sendUserToServer:(SPUser*)user;
- (Medicine *)getMedicineWithCodeBarNumber:(NSNumber*)number;
- (BOOL)sendMedicine:(Medicine*)medicine
            fromUser:(User*)user;
@end
