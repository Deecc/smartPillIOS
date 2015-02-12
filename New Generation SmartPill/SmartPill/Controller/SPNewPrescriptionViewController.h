//
//  SPNewPrescriptionViewController.h
//  SmartPill
//
//  Created by Mobile School - Julian on 1/29/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medicine.h"
#import "Recipe.h"

@interface SPNewPrescriptionViewController : UITableViewController

@property (strong,nonatomic) Medicine * medicine;
@property (strong,nonatomic) NSMutableArray * recipes;


@end
