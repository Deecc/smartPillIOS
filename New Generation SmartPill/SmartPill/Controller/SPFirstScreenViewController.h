//
//  SPFirstScreenViewController.h
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPCoreDataViewController.h"
#import "SPTabBarViewController.h"
#import "SPPageContentViewController.h"

@interface SPFirstScreenViewController : SPCoreDataViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
