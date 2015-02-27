//
//  SPNewMedicineHistoryViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataViewController.h"

@interface SPNewMedicineHistoryViewController : SPCoreDataViewController


@property (strong,nonatomic) IBOutlet UIDatePicker *initialDate;
@property (strong,nonatomic) IBOutlet UIDatePicker *finalDate;
@property (strong,nonatomic) NSString * stringInitial;
@property (strong,nonatomic) NSString * stringFinal;
@property (strong,nonatomic) NSDate * dateInitial;
@property (strong,nonatomic) NSDate * dateFinal;
@property (strong,nonatomic) NSDate * today;
@property (strong,nonatomic) NSMutableArray *arrayBetweenDatesSelected;
@property (strong,nonatomic) NSDateFormatter *dateFormat;

- (IBAction)displayHistory:(UIButton *)sender;




@end
