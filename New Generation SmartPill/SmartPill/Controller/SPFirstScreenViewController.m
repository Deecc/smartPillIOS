//
//  SPFirstScreenViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 05/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import "SPFirstScreenViewController.h"

@interface SPFirstScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation SPFirstScreenViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setButtonsName];
    _pageTitles = @[@"Gerencie", @"Lembre", @"Planeje"];
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png"];
    /////////////////
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    SPPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.pageControl];
    [self.view bringSubviewToFront:self.blackButton];
    [self.view bringSubviewToFront:self.greenButton];
}

/////////////////////////////////////////////////////////
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((SPPageContentViewController*) viewController).pageIndex;
    [self.pageControl setCurrentPage:index];
    if (index == NSNotFound) {
        return nil;
    }else if(index == 0){
        index = 2;
    }else{
        index--;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((SPPageContentViewController*) viewController).pageIndex;
    
    [self.pageControl setCurrentPage:index];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        index = 0;
        
    }
    
    return [self viewControllerAtIndex:index];
}

- (SPPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    SPPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}



////////////////////////////////////////////////////////

- (User*)getLastUser{
    return [SPUserHandler getOneUserFromDatabase];
}

- (void)storingCurrentUserInfo{
    SPUser * user = nil;
    User * userDatabase = [self getLastUser];
    SPAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    if (userDatabase.facebook.idFacebook) {
        user = [SPUserHandler createFacebookUserWithName:userDatabase.name
                                                   Email:userDatabase.email
                                          UserFacebookId:userDatabase.facebook.idFacebook];
    }else if (userDatabase.google.idGoogle){
        user = [SPUserHandler createGoogleUserWithName:userDatabase.name Email:userDatabase.email UserGoogleId:userDatabase.google.idGoogle];
    }else{
        user = [SPUserHandler createUserWithName:userDatabase.name Email:userDatabase.email UserId:userDatabase.idUser andPassword:userDatabase.password];
    }
    delegate.currentUser = user;
}

- (IBAction)goToLastUserScheduleScreen:(id)sender {
    if ([self getLastUser]) {
        SPTabBarViewController * viewControllerTabBar = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
        [self storingCurrentUserInfo];
        viewControllerTabBar.navigationItem.hidesBackButton = YES;
        [self.navigationController pushViewController:viewControllerTabBar animated:YES];
    }
}

- (void)setButtonsName{
    User * user = [self getLastUser];
    if (user) {
        [self.blackButton setTitle:user.name forState:UIControlStateNormal];
    }else{
        [self.blackButton setTitle:@"" forState:UIControlStateNormal];
        [self.greenButton setTitle:@"Entrar/Inscrever-se" forState:UIControlStateNormal];
    }
    [self.blackButton.layer setBorderWidth:2.0f];
    [self.blackButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.blackButton.layer.cornerRadius = 5;
    [self.greenButton.layer setBorderWidth:2.0f];
    [self.greenButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.greenButton.layer.cornerRadius = 5;

}
@end
