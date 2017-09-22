//
//  MyWalletViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/15.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "MyWalletViewController.h"

#import "agreeFirstNav.h"

#import "PayListViewController.h"

@interface MyWalletViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UIView *headerView;
@property(strong,nonatomic)UILabel *moneyLab;
@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UIView *footView;
@property(strong,nonatomic)UIButton *rechargeBtn;


@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    [self header];
    [self foot];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"余额" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)leftBtn {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    NSUserDefaults *money = [NSUserDefaults standardUserDefaults];
    NSString *moneyStr = [money objectForKey:@"moneyid"];
    NSLog(@"%@",moneyStr);
    if ([moneyStr isEqual:[NSString stringWithFormat:@"0"]]) {
        
        NSUserDefaults *money2 = [NSUserDefaults standardUserDefaults];
        NSString *money2Str = [money2 objectForKey:@"money2id"];
        
        self.moneyLab.text = money2Str;
        
    }else{
        self.moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.moneyLab.text doubleValue] + [moneyStr doubleValue]];
        NSUserDefaults *money = [NSUserDefaults standardUserDefaults];
        [money setObject:@"0" forKey:@"moneyid"];
        [money synchronize];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    NSUserDefaults *money2 = [NSUserDefaults standardUserDefaults];
    [money2 setObject:_moneyLab.text forKey:@"money2id"];
    [money2 synchronize];
    
}


- (void)header {

    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    self.headerView.backgroundColor = ALLBGColor;
    [self.view addSubview:_headerView];
    
    self.moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 80)];
    self.moneyLab.font = [UIFont systemFontOfSize:50.0];
    self.moneyLab.text = @"0.00";
    self.moneyLab.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:_moneyLab];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, 30)];
    self.titleLab.text = @"总余额 (元)";
    self.titleLab.font = [UIFont systemFontOfSize:16.0];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = ALLTextColor;
    [self.headerView addSubview:_titleLab];
    
}

- (void)foot {

    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2 + 85, SCREEN_WIDTH, SCREEN_HEIGHT/2 - 85)];
    self.footView.backgroundColor = ALLBGColor;
    [self.view addSubview:_footView];
    
    self.rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, (SCREEN_HEIGHT/2 - 85)/2 - 30, SCREEN_WIDTH-20, 50)];
    self.rechargeBtn.backgroundColor = ALLRedBtnColor;
    [self.rechargeBtn setTitle:@"充值" forState:0];
    self.rechargeBtn.layer.cornerRadius = 5.0;
    self.rechargeBtn.clipsToBounds = YES;
    [self.rechargeBtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:_rechargeBtn];
    
}

- (void)recharge {

    PayListViewController *plvc = [[PayListViewController alloc]init];
    
    [self.navigationController pushViewController:plvc animated:YES];

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
