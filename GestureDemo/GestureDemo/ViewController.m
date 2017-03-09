//
//  ViewController.m
//  GestureDemo
//
//  Created by Nie,Ying(MTBD) on 2017/1/17.
//  Copyright © 2017年 Nie,Ying(MTBD). All rights reserved.
//

#import "ViewController.h"
#import "menuView.h"
@interface ViewController ()
@property(nonatomic,strong)UIView *panView;
@property(nonatomic,strong)UIView *edgeView;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.panView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 100)];
    [self.panView setBackgroundColor:[UIColor redColor]];
    UILabel *  panLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 150, 40)];
    [panLabel setText:@"博客园-FlyElephant"];
    [panLabel setFont:[UIFont systemFontOfSize:14]];
    [self.panView addSubview:panLabel];
    [self.view addSubview:self.panView];
    UIPanGestureRecognizer  *pangestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.panView addGestureRecognizer:pangestureRecognizer];
    
    
    self.centerX = CGRectGetWidth(self.view.bounds)/2;
    self.centerY = CGRectGetHeight(self.view.bounds)/2;
    self.edgeView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, CGRectGetWidth(self.view.bounds), 100)];
    [self.edgeView setBackgroundColor:[UIColor greenColor]];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 320, 40)];
    [lab setText:@"原文地址:http://www.cnblogs.com/xiaofeixiang/"];
    [lab setFont:[UIFont systemFontOfSize:14]];
    [self.edgeView addSubview:lab];
    [self.view addSubview:self.edgeView];
    
    UIScreenEdgePanGestureRecognizer *rightEdgeGesture =
    [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleRightEdgeGesture:)];
    rightEdgeGesture.edges = UIRectEdgeRight;           // 右滑显示
    [self.view addGestureRecognizer:rightEdgeGesture];
}

-(void)panGesture:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:gesture.view];
    NSLog(@"%@",[NSString stringWithFormat:@"(%0.0f, %0.0f)", translation.x, translation.y]);
}

-(void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    //当前被触摸的view
    UIView *view = [self.view hitTest:[gesture locationInView:gesture.view]
                            withEvent:nil];
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state)
    {
        CGPoint translation = [gesture translationInView:gesture.view];
        [UIView animateWithDuration:0.5 animations:^{
            view.center = CGPointMake(self.centerX + translation.x, view.center.y);
            NSLog(@"%@",NSStringFromCGPoint(view.center));
        }];
    }
    else//取消，失败，结束的时候返回原处
    {
        [UIView animateWithDuration:0.5 animations:^{
            view.center = CGPointMake(self.centerX, view.center.y);
        }];
    }
}
    


@end
