//
//  payFailureViewController.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/21.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "payFailureViewController.h"
#import "payFirstNav.h"

@interface payFailureViewController ()

@property(strong,nonatomic)payFirstNav *nav;

@property(strong,nonatomic)UIView *headView1;
@property(strong,nonatomic)UIImageView *myImg;
@property(strong,nonatomic)UILabel *titleLab;


@property(strong,nonatomic)UIView *headView2;
@property(strong,nonatomic)UILabel *titleReminderLab;
@property(strong,nonatomic)UILabel *reminderLab;

@property(strong,nonatomic)UIButton *lookBtn;
@property(strong,nonatomic)UIButton *againBtn;

@end

@implementation payFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self head];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 376, SCREEN_WIDTH, SCREEN_HEIGHT-376)];
    myView.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:myView];
    
    self.nav = [[payFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"支付订单" andWithRightBtn:@"完成" andWithBgImg:nil];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)rightBtn:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)head{
    
    self.headView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 137)];
    [self.view addSubview:_headView1];
    
    self.myImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 25, 60, 60)];
    self.myImg.image = [UIImage imageNamed:@"failure"];
    [self.headView1 addSubview:_myImg];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 85, SCREEN_WIDTH*3/5, 35)];
    self.titleLab.text = @"订单支付失败";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = [UIFont systemFontOfSize:18.0];
    self.titleLab.textColor = ALLTextColor;
    [self.headView1 addSubview:_titleLab];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 136.5, SCREEN_WIDTH-20, 1)];
    lab.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    [_headView1 addSubview:lab];
    
    self.headView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 201, SCREEN_WIDTH, 175)];
    [self.view addSubview:_headView2];
    
    self.titleReminderLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 35)];
    self.titleReminderLab.text = @"订单信息";
    self.titleReminderLab.textAlignment = NSTextAlignmentLeft;
    self.titleReminderLab.font = [UIFont systemFontOfSize:16.0];
    self.titleReminderLab.textColor = ALLTextColor;
    [self.headView2 addSubview:_titleReminderLab];
    
    self.reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREEN_WIDTH-20, 50)];
    self.reminderLab.text = @"该订单为你保留24小时(从下单日算起)，24小时以后如果还未付款，系统将自动取消该订单。";
    self.reminderLab.numberOfLines = 0;
    self.reminderLab.textAlignment = NSTextAlignmentLeft;
    self.reminderLab.font = [UIFont systemFontOfSize:14.0];
    self.reminderLab.textColor = ALLTextColor;
    [self.headView2 addSubview:_reminderLab];
    
    
    self.lookBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 115, (SCREEN_WIDTH-30)/2, 40)];
    [self.lookBtn setTitle:@"查看订单" forState:0];
    [self.lookBtn setTitleColor:[UIColor colorWithRed:175/255.0 green:182/255.0 blue:186/255.0 alpha:1] forState:0];
    self.lookBtn.layer.borderWidth = 1.0;
    self.lookBtn.layer.borderColor = [UIColor colorWithRed:175/255.0 green:182/255.0 blue:186/255.0 alpha:1].CGColor;
    self.lookBtn.layer.cornerRadius = 5.0;
    self.lookBtn.clipsToBounds = YES;
    [self.headView2 addSubview:_lookBtn];
    
    self.againBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-30)/2+20, 115, (SCREEN_WIDTH-30)/2, 40)];
    [self.againBtn setTitle:@"重新支付" forState:0];
    [self.againBtn setTitleColor:[UIColor colorWithRed:213/255.0 green:122/255.0 blue:115/255.0 alpha:1] forState:0];
    self.againBtn.layer.borderWidth = 1.0;
    self.againBtn.layer.borderColor = [UIColor colorWithRed:213/255.0 green:122/255.0 blue:115/255.0 alpha:1].CGColor;
    self.againBtn.layer.cornerRadius = 5.0;
    self.againBtn.clipsToBounds = YES;
    [self.headView2 addSubview:_againBtn];
    
}

@end
