

//
//  YCTabBarController.m
//  MobShareDemo
//
//  Created by 张小超(外包) on 2018/1/18.
//  Copyright © 2018年 张小超(外包). All rights reserved.
//

#import "YCTabBarController.h"
#import "PATabBarView.h"
#import "PAUserCenterMianViewController.h"
#import "PAHomeViewController.h"
#import "PAMessageHomeViewController.h"
#import "PAHRXMineViewController.h"
#import "PABaseTableViewController.h"

@interface YCTabBarController ()<PATabBarViewDelegate>

@property (nonatomic, strong) PATabBarView *tabbarView;
@property (nonatomic, strong) NSArray* titleArr;
@property (nonatomic, strong) NSArray* unselectImgArr;
@property (nonatomic, strong) NSArray* selectImgArr;

@end

@implementation YCTabBarController

- (PATabBarView *)tabbarView{
    if (!_tabbarView) {
        _tabbarView = [[PATabBarView alloc]init];
        [self.view addSubview:_tabbarView];
        _tabbarView.delegate = self;
    }
    return _tabbarView;
}

- (NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"消息",@"圈子",@"HRX",@"活动",@"我的"];
    }
    return _titleArr;
}

- (NSArray *)unselectImgArr{
    if (!_unselectImgArr) {
        _unselectImgArr = @[@"ic_home", @"ic_found",@"", @"ic_personal",@"ic_personal"];
    }
    return _unselectImgArr;
}

-(NSArray *)selectImgArr{
    if (!_selectImgArr) {
        _selectImgArr = @[@"ic_home", @"ic_found",@"", @"ic_personal",@"ic_personal"];
    }
    return _selectImgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBar setHidden:YES];
    self.tabbarView.frame = self.tabBar.frame;
    
    [self setViewController];
    [self setHRXItem];
}

- (void)setViewController{
    PAMessageHomeViewController *messageVC = [[PAMessageHomeViewController alloc]init];
    messageVC.title = @"消息";
    PANavigationController *messageNav = [[PANavigationController alloc]initWithRootViewController:messageVC];
    
    PAHomeViewController *home = [[PAHomeViewController alloc]init];
    home.title = @"HRX";
    PANavigationController *homeNavCtr = [[PANavigationController alloc] initWithRootViewController:home];
    
    
    PABaseTableViewController *circle = [[PABaseTableViewController alloc]init];
    circle.title =@"圈子";
    PANavigationController *circleNavCtr = [[PANavigationController alloc] initWithRootViewController:circle];
    
    
    PABaseTableViewController *activity = [[PABaseTableViewController alloc]init];
    activity.title = @"活动";
    PANavigationController *activityNavCtr = [[PANavigationController alloc] initWithRootViewController:activity];
    
    
    PAHRXMineViewController *myCenter = [[PAHRXMineViewController alloc] init];
    myCenter.title = @"我的";
    PANavigationController *myCenterNavCtr = [[PANavigationController alloc] initWithRootViewController:myCenter];
    
    [self setViewControllers:@[messageNav,circleNavCtr,homeNavCtr,activityNavCtr,myCenterNavCtr]];
    
    [self.tabbarView setItemsTitle:self.titleArr unselectImg:self.unselectImgArr selectImg:self.selectImgArr];
    
    [self setSelectViewControllerInit];
}

- (void)setSelectViewControllerInit{
    NSInteger index = 0;
    self.selectedIndex = index;
    [self.tabbarView setSelectItemWithIndex:index];
}

- (void)setHRXItem{
    CGFloat width = 50;
    CGFloat height = 50;
    UIButton *but = [self.tabbarView itemWithIndex:2];
    CGRect frame = but.frame;
    frame = CGRectMake(frame.origin.x + (frame.size.width - width) / 2, (frame.size.height - height) / 2 - 6,width, height);
    but.frame = frame;
    [but setTitleEdgeInsets:UIEdgeInsetsZero];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = width / 2;
    but.userInteractionEnabled = YES;
    but.titleLabel.font = [UIFont systemFontOfSize:14];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [but setBackgroundColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [but setBackgroundColor:[UIColor colorWithRed:241.0 / 255 green:253.0 / 255 blue:1 alpha:1] forState:UIControlStateNormal];
}

#pragma mark - PATabBarViewDelegate
- (void)didSelectViewControllerIndex:(NSInteger)index{
    self.selectedIndex = index;
}


@end
