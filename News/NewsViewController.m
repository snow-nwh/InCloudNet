//
//  NewsViewController.m
//  InCloudNet
//
//  Created by 聂文辉 on 2017/5/20.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self creatPointArray];
}
- (void)creatPointArray {
    NSMutableArray *array = [NSMutableArray array];
    CGPoint originPoint = CGPointMake(50, 400);
    CGPoint oppositePoint = CGPointMake(350, 100);
    for (NSInteger i = 0; i < 10; i++) {
        CGFloat x = i*(oppositePoint.x-originPoint.x)/10 +originPoint.x;
        CGFloat y = arc4random()%(int32_t)(originPoint.y-oppositePoint.y) +oppositePoint.y;
        CGPoint point = CGPointMake(x, y);
        NSString *str = NSStringFromCGPoint(point);
        [array addObject:str];
    }
    [self drawLineWithArray:array
                originPoint:originPoint
              oppositePoint:oppositePoint];
}

- (void)drawLineWithArray:(NSArray *)array
              originPoint:(CGPoint)originPoint
            oppositePoint:(CGPoint)oppositePoint{
    UIBezierPath *yPath = [UIBezierPath bezierPath];
    CAShapeLayer *yLayer = [CAShapeLayer layer];
    [yPath moveToPoint:originPoint];
    [yPath addLineToPoint:CGPointMake(originPoint.x, oppositePoint.y)];
    [yPath stroke];
    yLayer.path = yPath.CGPath;
    yLayer.strokeColor = [UIColor blueColor].CGColor;
    yLayer.lineWidth = 2.0f;
    yLayer.lineDashPattern = @[@(10),@(10)];
    [self.view.layer addSublayer:yLayer];
    
    UIBezierPath *xPath = [UIBezierPath bezierPath];
    CAShapeLayer *xLayer = [CAShapeLayer layer];
    [xPath moveToPoint:originPoint];
    [xPath addLineToPoint:CGPointMake(oppositePoint.x, originPoint.y)];
    [xPath stroke];
    xLayer.path = xPath.CGPath;
    xLayer.strokeColor = [UIColor blueColor].CGColor;
    xLayer.lineWidth = 2.0f;
    xLayer.lineDashPattern = @[@(10),@(10)];
    [self.view.layer addSublayer:xLayer];
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    CAShapeLayer *layer = [CAShapeLayer layer];

    for (NSInteger i = 0; i < array.count;i++) {
        NSString *pointString = array[i];
        CGPoint point = CGPointFromString(pointString);
        if (i) {
            [bezier addLineToPoint:point];
        } else {
            [bezier moveToPoint:point];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGRect buttonFrame = CGRectMake(0, 0, 8, 8);
        button.frame = buttonFrame;
        button.center = point;
        button.layer.cornerRadius = 4;
        [button setBackgroundColor:[UIColor redColor]];
        [layer addSublayer:button.layer];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];//keyPath直接给position不用.x或.y
        animation.duration = i*0.1f;
        //top
//        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(point.x, 0)];
        //left
//        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, point.y)];
        //bottom
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(point.x, originPoint.y)];
        animation.toValue = [NSValue valueWithCGPoint:point];
        
        [button.layer addAnimation:animation forKey:nil];
    }
    [bezier stroke];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor orangeColor].CGColor;
    layer.lineWidth = 2.0f;
    layer.path = bezier.CGPath;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.repeatCount = YES;
    animation.duration = 0.9f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (NSInteger i = 0; i < self.view.layer.sublayers.count;) {
        CALayer *layer = self.view.layer.sublayers[i];
        [layer removeFromSuperlayer];
    }
    [self creatPointArray];
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
