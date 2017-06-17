//
//  FilmDetailViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/23.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "FilmDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "PlayerView.h"
#import "CNNavigationViewController.h"
#import "AppDelegate.h"

@interface FilmDetailViewController () <PlayerViewDelegete>
@property (nonatomic, strong) PlayerView *playerView;
@property (nonatomic,strong) AVPlayer *player;


@end

@implementation FilmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.playerView = [[PlayerView alloc]init ];//WithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16)];
    self.playerView.delegate = self;
    [self.view addSubview:self.playerView];
    
//    CATransition *transition = [CATransition animation];
//    [transition setDuration:4.0f];
//    transition.fillMode = kCAFillModeForwards;
//    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [transition setType:kCATransitionMoveIn];
//    [transition setSubtype:kCATransitionFade];
//    [self.playerView.layer addAnimation:transition forKey:nil];
    
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(self.view.frame.size.width*9/16));
    }];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"ClashofClans" ofType:@"mp4"];
    NSLog(@"%@",videoPath);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file:///%@",videoPath]];
//    NSURL *url = [NSURL fileURLWithPath:@"~/InCloudNet/Film/ClashofClans.mp4" isDirectory:YES];//@"ClashofClans.mp4"];
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    AVPlayerItem *playItem = [AVPlayerItem playerItemWithAsset:asset];

    _player = [[AVPlayer alloc]initWithPlayerItem:playItem];
    
    [self.playerView setPlayer:_player];
//    AVPlayerViewController *playerController = [[AVPlayerViewController alloc]init];
//    playerController.player = player;
//    
//    [self addChildViewController:playerController];
//    [self.view addSubview:playerController.view];
//    playerController.view.frame = self.view.frame;
//    [player play];
    
}

- (void)fullScreen:(BOOL)statue {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (statue == YES) {
//        [UIView animateWithDuration:1.0f
//                         animations:^{
//                             self.playerView.frame = self.view.frame;
//
//                         }];
        
        
//        [self.playerView setPlayer:_player];
        
//        [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.view);
        }];
//        self.playerView.frame.size.height = self.view.frame.size.height;
        
//        [((CNNavigationViewController *)self.navigationController) shouldAutorotate];
//        [((CNNavigationViewController *)self.navigationController) supportedInterfaceOrientations];
//        [((CNNavigationViewController *)self.navigationController) preferredInterfaceOrientationForPresentation];
    [appDelegate setAllowRotation:1];
        
        //************************//

        NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        
        
    } else {
        
//        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(self.view.frame.size.width*9/16));
//        }];
        
        [appDelegate setAllowRotation:0];
//        [UIView animateWithDuration:1.0f
//                         animations:^{
//                     self.playerView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width*9/16);
//                         }];
//        [self.playerView setPlayer:_player];
        //************************//
        NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        
        [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
        
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
    
    
    [self.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(self.view.frame.size.width*9/16));
    }];
}


//- (BOOL)shouldAutorotate {
//    [super shouldAutorotate];
//    return YES;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    [super supportedInterfaceOrientations];
//    return UIInterfaceOrientationMaskLandscapeLeft;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    [super preferredInterfaceOrientationForPresentation];
//    //自动向左横屏
//    return UIInterfaceOrientationLandscapeLeft;
//}

- (void)viewWillDisappear:(BOOL)animated {
    [self.playerView quit];
    
    //************************//
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate setAllowRotation:0];

    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
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
