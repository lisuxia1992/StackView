//
//  ViewController.m
//  StackVIewDemo
//
//  Created by jihuiduo on 16/8/10.
//  Copyright © 2016年 cherry. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIStackView *containerView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    containerView = [[UIStackView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 200)];
    //子视图布局方向：水平或垂直
    containerView.axis = UILayoutConstraintAxisHorizontal;//水平布局
    //子控件依据何种规矩布局
    containerView.distribution = UIStackViewDistributionFillEqually;//子控件均分
    //子控件之间的最小间距
    containerView.spacing = 10;
    //子控件的对齐方式
    containerView.alignment = UIStackViewAlignmentFill;
    NSArray *tempArray = @[@"了是东风科技",@"开始的疯狂活动是多久发货的开发环境放多久发货谁开的房间水电费地方就好看是东风科技",@"老师的开发接口都是附近看到快快快快快快快快快",@"好看"];
    for (NSInteger i = 0; i < 4; i++) {
//        UIView *view = [[UIView alloc]init];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        label.numberOfLines = 0;
        label.text = tempArray[i];
        
        [containerView addArrangedSubview:label];
        
    }
    [self.view addSubview:containerView];
}

/**
 *  @author cherry
 *
 *  添加视图
 *
 *  @param sender
 */
- (IBAction)addAction:(id)sender {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor orangeColor];
    label.text = @"是东风科技死了胜利大街";
    label.numberOfLines = 0;
    [containerView addArrangedSubview:label];
}

/**
 *  @author cherry
 *
 *  删除一个视图
 *
 *  @param sender
 */
- (IBAction)deleteAction:(id)sender {
    //removeArrangedSubview， 只会把子控件从arrangedSubviews数组中移除，
    //不会从subviews中移除，如果需要可调用removeFromSuperview
    UIView *view = [containerView.subviews lastObject];
    [containerView removeArrangedSubview:view];
    [view removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
