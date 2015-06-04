//
//  SPMedicineHistoryViewController.m
//  SmartPill
//
//  Created by deck on 13/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPMedicineHistoryViewController.h"

@interface SPMedicineHistoryViewController ()

@end

@implementation SPMedicineHistoryViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayBetweenDatesSelected.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Reminder *reminder = [self.arrayBetweenDatesSelected objectAtIndex:indexPath.row];
    
    NSDate * date = reminder.reminder_schedule.schedule;
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"HH:mm"];
    
    CellDrawer * drawer = [[CellDrawer alloc]init];
    [drawer createWhiteContentInCellWithFixSize:cell size:self.view.window.frame.size.width];
    [drawer insertDescriptionLabel:cell text:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    [drawer insertTimeLabelInVCenter:cell text:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
    return cell;
}


@end
