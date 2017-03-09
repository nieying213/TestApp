//
//  rootViewController.m
//  GestureDemo
//
//  Created by Nie,Ying(MTBD) on 2017/1/17.
//  Copyright © 2017年 Nie,Ying(MTBD). All rights reserved.
//

#import "rootViewController.h"
#import "menuView.h"
#import "CategriesViewController.h"
#import "CategriesNavViewController.h"

static CGFloat const kMenuWidth = 240.0;
@interface rootViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)menuView *menuView;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanRecognizer;
@property(nonatomic,strong)CategriesViewController *categoriesViewController;
@property(nonatomic,strong)CategriesNavViewController *categoriesNavigationController;
@property (nonatomic, strong) UIButton   *rootBackgroundButton;
@end

@implementation rootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //   self.currentSelectedIndex = 0;
    }
    return self;
}

-(void)loadView{
    [super loadView];
    [self configureViewControllers];
    [self configureViews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureGestures];
  //  [self configureNotifications];
    
    
    //    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    //    [UINavigationBar appearance].titleTextAttributes = @{
    //                                                         NSForegroundColorAttributeName:[UIColor blackColor],
    //                                                         NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)configureViewControllers{
    self.categoriesViewController = [[CategriesViewController alloc] init];
    self.categoriesNavigationController = [[CategriesNavViewController alloc] initWithRootViewController:self.categoriesViewController];
}
    
-(void)configureViews{
    self.rootBackgroundButton               = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rootBackgroundButton.alpha = 0.0;
    self.rootBackgroundButton.backgroundColor = [UIColor blackColor];
    self.rootBackgroundButton.hidden = YES;
    [self.view addSubview:self.rootBackgroundButton];
    
    self.menuView = [[menuView alloc] initWithFrame:(CGRect){-kMenuWidth, 0, kMenuWidth, kScreenHeight}];
    [self.view addSubview:self.menuView];
}
- (void)configureGestures {
    
    self.edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanRecognizer:)];
    self.edgePanRecognizer.edges = UIRectEdgeLeft;
    self.edgePanRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.edgePanRecognizer];
    
//    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
//    panRecognizer.delegate = self;
//    [self.rootBackgroundButton addGestureRecognizer:panRecognizer];
    
}


- (void)handleEdgePanRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / kMenuWidth;
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        //        [self setBlurredScreenShoot];
        self.rootBackgroundButton.hidden = NO;
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self setMenuOffset:kMenuWidth * progress];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        
        CGFloat velocity = [recognizer velocityInView:self.view].x;
        
        if (velocity > 20 || progress > 0.5) {
            
            [UIView animateWithDuration:(1-progress)/1.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:3.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [self setMenuOffset:kMenuWidth];
            } completion:^(BOOL finished) {
                ;
            }];
        }
        else {
            [UIView animateWithDuration:progress/3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setMenuOffset:0];
            } completion:^(BOOL finished) {
                self.rootBackgroundButton.hidden = YES;
                self.rootBackgroundButton.alpha = 0.0;
            }];
        }
        
    }
    
}

- (void)setMenuOffset:(CGFloat)offset {
    
//    self.menuView.x = offset - kMenuWidth;
//    [self.menuView setOffsetProgress:offset/kMenuWidth];
//    self.rootBackgroundButton.alpha = offset/kMenuWidth * 0.3;
//    
//    UIViewController *previousViewController = [self viewControllerForIndex:self.currentSelectedIndex];
//    
//    previousViewController.view.x       = offset/8.0;
    //    self.categoriesNavigationController.view.x   = offset/8.0;
    //    self.favoriteNavigationController.view.x     = offset/8.0;
    //    self.nofificationNavigationController.view.x = offset/8.0;
    
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
