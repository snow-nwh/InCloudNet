//
//  UserCenterViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "UserCenterViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface UserCenterViewController ()
@property (nonatomic,strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic,strong) UIGravityBehavior *gravity;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self turnTable];
}

- (UIDynamicAnimator *)dynamicAnimator {
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (void)turnTable {
    CGPoint center = self.view.center;
    UIButton *ball = [UIButton buttonWithType:UIButtonTypeCustom];
    ball.frame = CGRectMake(center.x+110, center.y-20, 40, 40);
//    ball.center = CGPointMake(center.x, center.y+120);
    ball.layer.cornerRadius = 20;
    [ball setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:ball];
    
    UIButton *ball2 = [UIButton buttonWithType:UIButtonTypeCustom];
    ball2.frame = CGRectMake(center.x+140, center.y-20, 40, 40);
    ball2.layer.cornerRadius = 20;
    [ball2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:ball2];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(center.x-100, center.y-100, 200, 200) cornerRadius:100];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:layer];
    [collision addBoundaryWithIdentifier:@"table" forPath:path];
    [collision addItem:ball];
    [collision addItem:ball2];
    [self.dynamicAnimator addBehavior:collision];
    
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]
                                        initWithItem:ball
                                        offsetFromCenter:UIOffsetMake(10,10)//(50/sqrt(2), 50/sqrt(2))
                                        attachedToAnchor:center];
    
    UIAttachmentBehavior *attachment2 = [[UIAttachmentBehavior alloc]
                                        initWithItem:ball2
                                        offsetFromCenter:UIOffsetMake(20,20)
                                        attachedToAnchor:center];
//    attachment.frequency = 10;
    [self.dynamicAnimator addBehavior:attachment];
    [self.dynamicAnimator addBehavior:attachment2];
    
    self.gravity = [[UIGravityBehavior alloc]init];
    [self.gravity addItem:ball];
    [self.gravity addItem:ball2];
    [self.dynamicAnimator addBehavior:self.gravity];
    [self.gravity setGravityDirection:CGVectorMake(1, 1)];
    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
//    [self.view addGestureRecognizer:panGesture];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
        CGVector vec = self.gravity.gravityDirection;
        if (vec.dx > 0 && vec.dy < 0) {
            CGVector vector = CGVectorMake(-vec.dx, vec.dy);
            [self.gravity setGravityDirection:vector];
        } else if (vec.dx < 0 && vec.dy < 0) {
            CGVector vector = CGVectorMake(vec.dx, -vec.dy);
            [self.gravity setGravityDirection:vector];
        } else if (vec.dx < 0 && vec.dy > 0) {
            CGVector vector = CGVectorMake(-vec.dx, vec.dy);
            [self.gravity setGravityDirection:vector];
        } else if (vec.dx > 0 && vec.dy > 0) {
            CGVector vector = CGVectorMake(vec.dx, -vec.dy);
            [self.gravity setGravityDirection:vector];
        }
    }];
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:self.view];
    NSLog(@"self.view = %@",NSStringFromCGPoint([gesture translationInView:self.view]));
//    NSLog(@"ball = %@",NSStringFromCGPoint([gesture translationInView:gesture.view]));
    [self.gravity setGravityDirection:CGVectorMake(point.x/1000, point.y/1000)];
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
