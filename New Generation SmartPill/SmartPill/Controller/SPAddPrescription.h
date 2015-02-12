//
//  SPAddPrescription.h
//  SmartPill
//
//  Created by Mobile School - Julian on 2/3/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPAppDelegate.h"
#import "SPViewController.h"
#import "SPTabBarViewController.h"
#import "SPMedicineDetailsViewController.h"
#import "SPNewMedicineViewController.h"

@interface SPAddPrescription : UIViewController< UITableViewDataSource>
@property (nonatomic, retain) NSIndexPath* checkedIndexPath;
@end
