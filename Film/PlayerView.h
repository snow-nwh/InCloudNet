//
//  PlayerView.h
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/24.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol PlayerViewDelegete <NSObject>

- (void)fullScreen:(BOOL)statue;

@end

@interface PlayerView : UIView
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic,strong) AVPlayer *player;
- (void)setPlayer:(AVPlayer *)player;


@property (nonatomic,strong) UIView *controlPanel;


+ (Class)layerClass;

@property (nonatomic, weak, nullable) id <PlayerViewDelegete> delegate;

NS_ASSUME_NONNULL_END

- (void)quit;

@end
