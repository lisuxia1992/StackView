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
    containerView.axis = UILayoutConstraintAxisVertical;
    containerView.distribution = UIStackViewDistributionFillEqually;
    containerView.spacing = 10;
    containerView.alignment = UIStackViewAlignmentFill;
    
    for (NSInteger i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        [containerView addArrangedSubview:view];
    }
    [self.view addSubview:containerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
