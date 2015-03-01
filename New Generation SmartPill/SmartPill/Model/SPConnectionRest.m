//
//  SPConnectionRest.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 09/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPConnectionRest.h"
#import "SPAppDelegate.h"

@implementation SPConnectionRest

- (NSDictionary*)fetchUserFromServer:(SPUser*)user{
    NSString * urlString = [NSString stringWithFormat:@"http://smartpill.noip.me:8080/services/getUserByEmail?e=%@",user.email];
    NSURL * url = [NSURL URLWithString:urlString];   
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    if (response1.length > 0 && requestError == nil) {
        NSArray * wrapper = [NSJSONSerialization JSONObjectWithData:response1 options:0 error:NULL];
        NSDictionary * dictionary = [wrapper objectAtIndex:0];
        return dictionary;
    }
    return nil;
}

- (BOOL)sendUserToServer:(User*)user{
    NSString * urlString = [NSString stringWithFormat:@"http://smartpill.noip.me:8080/services/setUser?email=%@&name=%@&pass=%@",user.email,user.name,user.password];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                        timeoutInterval:10];
    [request setHTTPMethod: @"POST"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    if (requestError == nil) {
        return YES;
    }
    return NO;
}


- (Medicine *)getMedicineWithCodeBarNumber:(NSNumber*)number{
    if (number.intValue > 0) {
        SPAppDelegate * appdelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext * context = appdelegate.managedObjectContext;
        Medicine * medicine = [Medicine medicineWithName:@"Dorflex" availability:@"CodeBarTest" manufactuary:@"Bayer"   activeIngredient:@"Dipirona" quantity:@4 reminder:nil user:[SPUserHandler getOneUserFromDatabase] inManagedObjectContext:context];
        return medicine;
    }
    return nil;
}

@end
