//
//  SPPageContentViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 11/03/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPPageContentViewController.h"

@interface SPPageContentViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SPPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
