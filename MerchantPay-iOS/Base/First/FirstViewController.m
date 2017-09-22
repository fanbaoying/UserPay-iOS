//
//  FirstViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/11.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "FirstViewController.h"

#import "MoneyViewController.h"
#import "OrderViewController.h"
#import "LookViewController.h"

//#import "GYPopView.h"

#import "agreeFirstNav.h"

@interface FirstViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;

//@property(strong,nonatomic)GYPopView *popView;

@property(strong,nonatomic)UIView *headerView;
@property(strong,nonatomic)UIButton *headerBtn;
@property(strong,nonatomic)UILabel *headerLab;

@property(strong,nonatomic)UIView *dataView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *contentLab;

@property(assign,nonatomic)int count;
@property(assign,nonatomic)int count1;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:nil andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.view addSubview:_nav];
    
    [self head];
    [self data];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    self.popView.hidden = NO;
//    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)head {

    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.headerView.backgroundColor = [UIColor colorWithRed:44/255.0 green:48/255.0 blue:75/255.0 alpha:1];
    [self.view addSubview:_headerView];
    
    NSArray *imageArr = @[@"sweep1",@"look2",@"order1"];
    NSArray *titleArr = @[@"立即收款",@"查看流水",@"到账记录"];
    
    for (int i = 0; i < imageArr.count; i ++) {
        
        int count = (50+(SCREEN_WIDTH-220)/2)*i;
        int count1 = (80+(SCREEN_WIDTH-280)/2)*i;
        
        self.headerBtn = [[UIButton alloc]initWithFrame:CGRectMake(35 + count, 64, 50, 50)];
        [self.headerBtn setImage:[UIImage imageNamed:imageArr[i]] forState:0];
        self.headerBtn.tag = 6000 + i;
        [self.headerBtn addTarget:self action:@selector(headerBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:_headerBtn];
        
        self.headerLab = [[UILabel alloc]initWithFrame:CGRectMake(20 + count1, 130, 80, 20)];
        self.headerLab.textColor = [UIColor whiteColor];
        self.headerLab.font = [UIFont systemFontOfSize:15.0];
        self.headerLab.text = titleArr[i];
        self.headerLab.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:_headerLab];
    }
    
}

- (void)headerBtn:(UIButton *)sender {

    if (sender.tag == 6000) {
        self.tabBarController.tabBar.hidden = YES;
        MoneyViewController *avc = [[MoneyViewController alloc]init];
        
        avc.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        avc.view.alpha = 0;
        [UIView animateWithDuration:0.5
                         animations:^{
                             avc.view.alpha = 1;
                             avc.view.frame = self.view.bounds;
                             [self addChildViewController:avc];
                             [self.view addSubview:avc.view];
                             
                         }completion:^(BOOL finished) {
                             
                         }];
        
//        self.popView=[[GYPopView alloc]initWithFrame:CGRectMake(0, 0,
//                                                                      self.view.frame.size.width,
//                                                                      self.view.frame.size.height)];
//        self.popView.first = self;
//        [self.popView showPopView];
        
    }else if(sender.tag == 6001){
//        LookViewController *lvc = [[LookViewController alloc]init];
//        [self presentViewController:lvc animated:YES completion:nil];
    }else{
//        OrderViewController *ovc = [[OrderViewController alloc]init];
//        [self presentViewController:ovc animated:YES completion:nil];
    }
}

- (void)data {

    self.dataView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
    [self.view addSubview:_dataView];
    
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 40)];
    headerLab.text = @"今日数据";
    [self.dataView addSubview:headerLab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
    lab1.backgroundColor = ALLText1Color;
    [self.dataView addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 1, 160)];
    lab2.backgroundColor = ALLText1Color;
    [self.dataView addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 1)];
    lab3.backgroundColor = ALLText1Color;
    [self.dataView addSubview:lab3];
    
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 10)];
    blankView.backgroundColor = ALLBGColor;
    [self.view addSubview:blankView];
    
    NSArray *titleArr = @[@"交易金额",@"交易笔数",@"新增会员",@"回头客"];
    NSArray *contentArr = @[@"0.00元",@"0笔",@"0个",@"0个"];
    
    for (int i = 0; i < titleArr.count; i ++) {
        
        if (i < 2) {
            self.count1 = 0;
            self.count = SCREEN_WIDTH/2*i;
        }else{
            self.count1 = 80;
            self.count = SCREEN_WIDTH/2*(i-2);
        }
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 + _count, 55+_count1, SCREEN_WIDTH/2, 20)];
        self.titleLab.text = titleArr[i];
        self.titleLab.font = [UIFont systemFontOfSize:14.0];
        self.titleLab.textColor = ALLTextColor;
        [self.dataView addSubview:_titleLab];
        
        self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15 + _count, 80+_count1, SCREEN_WIDTH/2, 30)];
        self.contentLab.text = contentArr[i];
        [self.dataView addSubview:_contentLab];
    }
    
}


@end
