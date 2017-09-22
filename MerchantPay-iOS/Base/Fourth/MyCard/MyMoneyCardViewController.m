//
//  MyMoneyCardViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/16.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "MyMoneyCardViewController.h"
#import "agreeFirstNav.h"

#import "MyMoneyCardTableViewCell.h"
@interface MyMoneyCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)agreeFirstNav *nav;

@end

@implementation MyMoneyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-65)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    self.myTableView.tableFooterView = baseView;
    
    UILabel *reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    reminderLab.textColor = [UIColor lightGrayColor];
    reminderLab.font = [UIFont systemFontOfSize:14.0];
    reminderLab.text = @"没有更多了～";
    reminderLab.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:reminderLab];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"我的卡券" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)leftBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 135;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMoneyCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fby"];
    if (cell == nil) {
        cell = [[MyMoneyCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fby"];
    }
    
    cell.moneyLab.text = @"¥5";
    cell.moneyUserLab.text = @"满55元可用";
    
    cell.titleLab.text = @"商超便利专享";
    cell.contentLab.text = @"限2017-08-15当天使用";
    cell.phoneNumberLab.text = @"限收货手机号为180 1678 6633";
    
    cell.reminderLab.text = @"限今日";
    
    cell.typeLab.text = @"限品类：商品超市";
    
    return cell;
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
