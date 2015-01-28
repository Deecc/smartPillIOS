
#import "SPReminderDetailsViewController.h"

@interface SPReminderDetailsViewController ()

@end

@implementation SPReminderDetailsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self writingLabels];
}

- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"newReminderEdit"]) {
        SPNewReminderViewController * newReminderVC = segue.destinationViewController;
        newReminderVC.reminder = self.reminder;
    }
}

- (void)writingLabels{
    if (self.reminder) {
        [self.labelMedicineName setText:[self.reminder.medicine valueForKey:@"name"]];

        NSDate * date = self.reminder.reminder_schedule.schedule;
        NSDateFormatter * timeFormat = [[NSDateFormatter alloc]init];
        [timeFormat setDateFormat:@"HH:mm"];
        [self.labelReminderTime setText:[NSString stringWithFormat:@"%@",[timeFormat stringFromDate:date]]];
    }
}

@end
