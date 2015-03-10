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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    // create a background image for the cell:
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"cell"]];
    [cell setBackgroundView:bgView];
    [cell setIndentationWidth:0.0];
    //
    Reminder *reminder = [self.arrayBetweenDatesSelected objectAtIndex:indexPath.row];
    
    NSDate * date = reminder.reminder_schedule.schedule;
    NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
    [timeFormat setDateFormat:@"HH:mm"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
    
    [cell.detailTextLabel setText:[[reminder valueForKey:@"medicine"]valueForKey:@"name"]];
    

    
    return cell;
}


@end
