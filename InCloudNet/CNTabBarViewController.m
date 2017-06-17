//
//  CNTabBarViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "CNTabBarViewController.h"
#import "CNNavigationViewController.h"
#import "ChatViewController.h"
#import "NewsViewController.h"
#import "FilmViewController.h"
#import "UserCenterViewController.h"

@interface CNTabBarViewController ()

@end

@implementation CNTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ChatViewController *chat = [[ChatViewController alloc]init];
    chat.tabBarItem.title = @"聊天";
    
    NewsViewController *news = [[NewsViewController alloc]init];
    news.tabBarItem.title = @"新闻";
    
    FilmViewController *film = [[FilmViewController alloc]init];
    film.tabBarItem.title = @"影音";
    CNNavigationViewController *nvc = [[CNNavigationViewController alloc]initWithRootViewController:film];
    nvc.tabBarItem.title = @"娱乐";
    
    UserCenterViewController *user = [[UserCenterViewController alloc]init];
    CNNavigationViewController *nvc3 = [[CNNavigationViewController alloc]initWithRootViewController:user];
    nvc3.tabBarItem.title = @"我";
    
    NSArray *tabArray = [NSArray arrayWithObjects:nvc,chat,news,nvc3, nil];
    
    self.viewControllers = tabArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
