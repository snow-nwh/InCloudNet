//
//  ChatViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "ChatViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ChatViewController ()

@property (nonatomic,strong) UIDynamicAnimator *dynamic;
@property (nonatomic,strong) CMMotionManager *manager;
@property (nonatomic,strong) NSMutableArray <UIView *>*dataSource;


@end

@implementation ChatViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 8; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(arc4random()%400, arc4random()%300, 40, 40);
        imageView.layer.cornerRadius = 20.0f;
        imageView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f
                                                    green:arc4random()%255/255.f
                                                     blue:arc4random()%255/255.f
                                                    alpha:1.0f];
        [self.dataSource addObject:imageView];
        [self.view addSubview:imageView];
    }
    
    [self dynamicAnimate];
}



- (void)dynamicAnimate {
    _dynamic = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:self.dataSource];
    [_dynamic addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.dataSource];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    
//    CGFloat X = self.view.frame.size.width;
//    CGFloat height = self.view.frame.size.height - 46;
//    [collision addBoundaryWithIdentifier:@"collision1" fromPoint:CGPointMake(0,0) toPoint:CGPointMake(X, 0)];
//    [collision addBoundaryWithIdentifier:@"collision2" fromPoint:CGPointMake(0, 0) toPoint:CGPointMake(0, height)];
//    [collision addBoundaryWithIdentifier:@"collision3" fromPoint:CGPointMake(X,0) toPoint:CGPointMake(X, height)];
//    [collision addBoundaryWithIdentifier:@"collision4" fromPoint:CGPointMake(0, height) toPoint:CGPointMake(X, height)];
    
    //以上设置边界可简化至此
      [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(20, 5, 49, 5)];
    
    UIFieldBehavior *field = [UIFieldBehavior noiseFieldWithSmoothness:1.0f animationSpeed:0.1f];
    for (UIView *view in self.dataSource) {
        [field addItem:view];
    }
    [field setStrength:0.5f];
//    [self.dynamic addBehavior:field];
    

    [self.dynamic addBehavior:collision];
    
    _manager = [[CMMotionManager alloc] init];
    if (_manager.deviceMotionAvailable) {
        NSLog(@"1");
        _manager.deviceMotionUpdateInterval = 0.1;
        [_manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            [gravity setGravityDirection:CGVectorMake(motion.gravity.x, -motion.gravity.y)];
        }];
    }
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
