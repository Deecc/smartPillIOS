//
//  SPTripPlanningResultsViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 19/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPTripPlanningResultsViewController.h"

@interface SPTripPlanningResultsViewController ()

@property (nonatomic)  NSMutableArray * selectedRemindersOneOfEach;
@property (nonatomic)  NSMutableArray * sumOfSameNameResults;
@property (nonatomic)  NSMutableArray * arrayOfArray;


@end

@implementation SPTripPlanningResultsViewController

- (NSMutableArray*)selectedMedicines{
    
    if (!_selectedReminders) {
        _selectedReminders = [@[] mutableCopy];
    }
    return _selectedReminders;
}

- (NSMutableArray*)resultOfMedicineQuantities{
    
    if (!_resultOfMedicineQuantities) {
        _resultOfMedicineQuantities = [@[] mutableCopy];
    }
    return _resultOfMedicineQuantities;
}

- (NSMutableArray*)arrayOfArray{
    
    if (!_arrayOfArray) {
        _arrayOfArray = [@[self.selectedReminders,self.resultOfMedicineQuantities]mutableCopy];
    }
    return _arrayOfArray;
}

- (NSMutableArray*)selectedRemindersOneOfEach{
    
    if (!_selectedRemindersOneOfEach) {
        _selectedRemindersOneOfEach = [@[] mutableCopy];
        NSMutableSet * setSelectedReminders = [[NSMutableSet alloc]init];
        for (Reminder * rem in self.selectedReminders) {
            [setSelectedReminders addObject:rem.medicine.name];
        }
        _selectedRemindersOneOfEach = [[setSelectedReminders allObjects] mutableCopy];
    }
    return _selectedRemindersOneOfEach;
}

- (NSMutableArray*)sumOfSameNameResults{
    if (!_sumOfSameNameResults) {
        _sumOfSameNameResults = [@[] mutableCopy];
        for (Reminder * rem in self.selectedReminders) {
            for (int index = 0; index <= [self.selectedRemindersOneOfEach count]-1; index++) {
                
                if ([rem.medicine.name isEqualToString:[self.selectedRemindersOneOfEach objectAtIndex:index]]) {
                    
                    if ([_sumOfSameNameResults count]==0 || [_sumOfSameNameResults count] == index){
                        [_sumOfSameNameResults addObject:[NSNumber numberWithInt:1]];
                    }else{
                        int timesNumber = [[_sumOfSameNameResults objectAtIndex:index] intValue];
                        [_sumOfSameNameResults replaceObjectAtIndex:index withObject:[NSNumber numberWithInt: timesNumber + 1]];
                    }
                }
            }
        }
    }
    if ([_sumOfSameNameResults count]==0) {
        for (int arrayCount = 0; [self.resultOfMedicineQuantities count]>arrayCount; arrayCount++) {
            [_sumOfSameNameResults addObject:@1];
        }
    }
    return _sumOfSameNameResults;
}

#pragma mark - Table view data source

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.selectedRemindersOneOfEach count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *medicineName = [self.selectedRemindersOneOfEach objectAtIndex:indexPath.row];
    NSNumber *timesMedicinesPerDay = [self.sumOfSameNameResults objectAtIndex:indexPath.row];
    NSNumber *numberOfTripDaysTimesMedicinesPerDay = [NSNumber numberWithInt:self.numberOfTripDays.intValue * timesMedicinesPerDay.intValue];
    
    [cell.textLabel setText:medicineName];
    [cell.detailTextLabel setText: [NSString stringWithFormat:@"%@", numberOfTripDaysTimesMedicinesPerDay]];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
