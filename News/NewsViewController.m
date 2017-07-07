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
//    [self loadWebView];
}
- (void)creatPointArray {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++) {
        CGFloat x = i*30 +10;
        CGFloat y = arc4random()%300 +100;
        CGPoint point = CGPointMake(x, y);
        NSString *str = NSStringFromCGPoint(point);
        [array addObject:str];
    }
    [self drawLineWithArray:array];
}

- (void)drawLineWithArray:(NSArray *)array {
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
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        animation.duration = i*0.1f;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, point.y)];
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

- (void)loadWebView {
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];

    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (CAShapeLayer *layer in self.view.layer.sublayers) {
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
