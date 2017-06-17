//
//  CNNavigationViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/23.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "CNNavigationViewController.h"

@interface CNNavigationViewController ()

@end

@implementation CNNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    [super shouldAutorotate];
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    [super supportedInterfaceOrientations];
    return UIInterfaceOrientationMaskAllButUpsideDown;
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
