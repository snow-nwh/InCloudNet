//
//  PlayerView.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/24.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView()



@end


@implementation PlayerView

{
    UIButton *playButton;
    UIButton *fullScreenButton;
    BOOL isPlaying;
    BOOL userTouched;
    NSTimer *timer;

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initControlPanel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControlPanel];
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (void)setPlayer:(AVPlayer *)player {
    _player = player;
    AVPlayerLayer *layer = (AVPlayerLayer *)self.layer;
    [layer setPlayer:player];
}

- (void)initControlPanel {
//    self.backgroundColor = [UIColor redColor];
    
    UIVisualEffectView *mainPanel = [[UIVisualEffectView alloc]init];
    mainPanel.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    mainPanel.alpha = 0.8f;//    [visual.contentView addSubview:_headImage];


    //UIView *mainPanel = [[UIView alloc]init];
    //mainPanel.backgroundColor = [UIColor greenColor];
    [self addSubview:mainPanel];

    [mainPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setTitle:@"△" forState:UIControlStateNormal];
    [playButton setTitle:@"||" forState:UIControlStateSelected];
    playButton.layer.borderWidth = 0.5f;
    playButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [mainPanel addSubview:playButton];
    
    fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [fullScreenButton setTitle:@"X" forState:UIControlStateNormal];
    fullScreenButton.layer.borderWidth = 0.5f;
    fullScreenButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [fullScreenButton addTarget:self action:@selector(fullScreenButton:) forControlEvents:UIControlEventTouchUpInside];
    [mainPanel addSubview:fullScreenButton];
    
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mainPanel);
        make.height.equalTo(mainPanel);
        make.width.equalTo(@40);
    }];

    [fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(playButton);
        make.top.right.equalTo(mainPanel);

    }];
    
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (!userTouched && isPlaying) {
            mainPanel.hidden = YES;
        } else {
            mainPanel.hidden = NO;
            userTouched = NO;
        }
    }];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

#pragma mark - play
- (void)play:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [self.player play];
        isPlaying = YES;
    } else {
        [self.player pause];
        isPlaying = NO;
    }
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1)
                                          queue:dispatch_get_main_queue()
                                     usingBlock:^(CMTime time) {
                                         CMTime currentTime = _player.currentItem.currentTime;
                                         CMTime duration = _player.currentItem.duration;
                                         float pro = CMTimeGetSeconds(currentTime)/CMTimeGetSeconds(duration);
                                         if (pro == 1.0f) {
                                             isPlaying = NO;
                                             
                                         }
                                     }];
}

- (void)fullScreenButton:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        if ([self.delegate respondsToSelector:@selector(fullScreen:)]) {
            [self.delegate fullScreen:YES];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(fullScreen:)]) {
            [self.delegate fullScreen:NO];
        }    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    userTouched = YES;
}

- (void)quit {
    [timer invalidate];
    [_player pause];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
