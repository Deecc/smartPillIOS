//
//  SPBarCodeViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 28/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNewMedicineViewController.h"

@interface SPBarCodeViewController : UIViewController

@property (nonatomic, assign) SPNewMedicineViewController* delegate;

@end
