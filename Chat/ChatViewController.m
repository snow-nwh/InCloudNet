//
//  ChatViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIButton *qq = [UIButton buttonWithType:UIButtonTypeCustom];
    [qq setTitle:@"QQ" forState:UIControlStateNormal];
    qq.layer.masksToBounds = YES;
    qq.layer.cornerRadius = 5.0f;
    qq.backgroundColor = [UIColor blueColor];
    [self.view addSubview:qq];
    
    
    UIButton *weixin = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixin setTitle:@"微信" forState:UIControlStateNormal];
    weixin.layer.masksToBounds = YES;
    weixin.layer.cornerRadius = 5.0f;
    weixin.backgroundColor = [UIColor blueColor];
    [self.view addSubview:weixin];

    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).inset(84.0f);
        make.left.equalTo(self.view).inset(10.0f);
        make.right.equalTo(self.view).inset(10.0f);
        make.height.equalTo(@80);
    }];
    
    [weixin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qq).inset(100.0f);
        make.left.equalTo(self.view).inset(10.0f);
        make.right.equalTo(self.view).inset(10.0f);
        make.height.equalTo(@80);
    }];
    
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
