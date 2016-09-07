//
//  NavigationViewController.m
//  HMJSearchBar
//
//  Created by MJHee on 16/9/5.
//  Copyright © 2016年 MJHee. All rights reserved.
//

#import "NavigationViewController.h"
#import "UIView+Extension.h"

@interface NavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [self.navigationBar setBarStyle:UIBarStyleBlack];
        self.navigationBar.translucent = NO;
        [self.navigationBar setBarTintColor:[UIColor purpleColor]];
    }
    return self;
}

+ (void)initialize {
    //设置整个项目item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    //设置可用状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];

    //设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //清空手势代理,然后就会重新出现手势移除控制器的功能
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {     // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;

        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"iconfont-fanhui"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

        //将按钮往左移动20
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        // 设置尺寸
        btn.width  = 40;
        btn.height = 40;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }

    [super pushViewController:viewController animated:animated];
}

- (void)back {
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    return YES;
}// called to push. return NO not to.

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
}// called at end of animation of push or immediately if not animated

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    return YES;
}// same as push methods

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
}

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

@end
