//
//  MoneyViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/11.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "MoneyViewController.h"
#import "agreeFirstNav.h"
#import "SGQRCodeScanningVC.h"

@interface MoneyViewController ()<UITextFieldDelegate>



@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UIView *myView;
@property(strong,nonatomic)UITextField *moneyTextField;

@property(strong,nonnull)NSArray *dataArr;

@property(strong,nonatomic)UIView *contentView;
@property(strong,nonatomic)UIButton *numberBtn;

@property(strong,nonatomic)UIView *footView;
@property(strong,nonatomic)UIButton *alipayBtn;
@property(strong,nonatomic)UIButton *wechatBtn;

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(15, 75, SCREEN_WIDTH-30, 60)];
    self.myView.backgroundColor = [UIColor whiteColor];
    self.myView.layer.cornerRadius = 5.0;
    self.myView.layer.borderWidth = 1.0;
    self.myView.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
    self.myView.clipsToBounds = YES;
    [self.bgView addSubview:_myView];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 25, 60)];
    lab.text = @"¥";
    lab.font = [UIFont systemFontOfSize:30.0];
    [self.myView addSubview:lab];
    
    self.moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-40, 60)];
    self.moneyTextField.backgroundColor = [UIColor whiteColor];
    self.moneyTextField.layer.cornerRadius = 5.0;
    self.moneyTextField.clipsToBounds = YES;
    self.moneyTextField.delegate = self;
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField.text = @"";
    self.moneyTextField.font = [UIFont systemFontOfSize:30.0];
    
    [self.myView addSubview:_moneyTextField];
    
    self.alipayBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 175, SCREEN_WIDTH-30, SCREEN_HEIGHT*60/667)];
    [self.alipayBtn setTitle:@"支付宝付款" forState:0];
    self.alipayBtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:168/255.0 blue:223/255.0 alpha:1];
    self.alipayBtn.layer.cornerRadius = 5.0;
    self.alipayBtn.clipsToBounds = YES;
    [self.alipayBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.alipayBtn addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:_alipayBtn];
    
    self.wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT*60/667 + 205, SCREEN_WIDTH-30, SCREEN_HEIGHT*60/667)];
    [self.wechatBtn addTarget:self action:@selector(wechat) forControlEvents:UIControlEventTouchUpInside];
    self.wechatBtn.layer.cornerRadius = 5.0;
    self.wechatBtn.clipsToBounds = YES;
    self.wechatBtn.backgroundColor = [UIColor colorWithRed:117/255.0 green:180/255.0 blue:56/255.0 alpha:1];
    [self.wechatBtn setTitle:@"微信付款" forState:0];
    [self.bgView addSubview:_wechatBtn];
    
//    [self content];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"付款" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.rightBtn addTarget:self action:@selector(touchupDismissButton) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:_nav];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self.moneyTextField becomeFirstResponder];
    
}
//
//- (void)viewDidDisappear:(BOOL)animated {
//
//    [super viewDidDisappear:animated];
//    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    
//}

-(void)touchupDismissButton
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                         self.view.alpha = 0;
                         self.tabBarController.tabBar.hidden = NO;
                     }completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)createPopViewContent
{

    
    
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
//    [textField resignFirstResponder];
//    return NO;
//}


- (void)content {
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2-49, SCREEN_WIDTH-20, SCREEN_HEIGHT*250/667)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.alpha = 1;
    self.contentView.layer.cornerRadius = 5.0;
    self.contentView.clipsToBounds = YES;
//    [self.bgView addSubview:_contentView];
    
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2 + SCREEN_HEIGHT*250/667 - 39, SCREEN_WIDTH-20, SCREEN_HEIGHT*60/667)];
    self.footView.alpha = 1;
    self.footView.backgroundColor = [UIColor whiteColor];
    self.footView.layer.cornerRadius = 5.0;
    self.footView.clipsToBounds = YES;
//    [self.bgView addSubview:_footView];
    
    
    
    NSArray *dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@"10"];
    
    for (int i = 0; i < dataArr.count; i ++) {
        
        if (i < 3) {
            int count1 = (SCREEN_WIDTH-22)*i/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count1, 0, (SCREEN_WIDTH-22)/3, SCREEN_HEIGHT*250/667/4)];
        }else if (i >= 3 && i <= 5){
            int count2 = (SCREEN_WIDTH-22)*(i-3)/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count2, SCREEN_HEIGHT*250/667/4, (SCREEN_WIDTH-22)/3, SCREEN_HEIGHT*250/667/4)];
        }else if (i >= 6 && i <= 8){
            
            int count3 = (SCREEN_WIDTH-22)*(i-6)/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count3, SCREEN_HEIGHT*250/667*2/4, (SCREEN_WIDTH-22)/3, SCREEN_HEIGHT*250/667/4)];
        }else if (i >= 9 && i <= 11){
            
            int count4 = (SCREEN_WIDTH-22)*(i-9)/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count4, SCREEN_HEIGHT*250/667*3/4, (SCREEN_WIDTH-22)/3, SCREEN_HEIGHT*250/667/4)];
            
        }
        
        [self.numberBtn setTitle:dataArr[i] forState:0];
        self.numberBtn.tag = 8000+i;
        [self.numberBtn addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.numberBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
        [self.numberBtn setTitleColor:[UIColor blackColor] forState:0];
        
        [self.numberBtn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [self.numberBtn addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_numberBtn];
        
    }
    
    for (int i = 0; i < 2; i++) {
        int count = (SCREEN_WIDTH-22)*i/3;
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-22)/3 + count, 0, 1, SCREEN_HEIGHT*250/667)];
        lab1.backgroundColor = ALLText2Color;
        [self.contentView addSubview:lab1];
    }
    
    for (int i = 0; i < 3; i++) {
        int count = SCREEN_HEIGHT*250/667*i/4;
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*250/667/4 + count, SCREEN_WIDTH-20, 1)];
        lab1.backgroundColor = ALLText2Color;
        [self.contentView addSubview:lab1];
    }
    
    self.alipayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-20)/2, SCREEN_HEIGHT*60/667)];
    [self.alipayBtn setTitle:@"支付宝付款" forState:0];
    [self.alipayBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.alipayBtn addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:_alipayBtn];
    
    self.wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2, 0, (SCREEN_WIDTH-20)/2, SCREEN_HEIGHT*60/667)];
    [self.wechatBtn addTarget:self action:@selector(wechat) forControlEvents:UIControlEventTouchUpInside];
    self.wechatBtn.backgroundColor = [UIColor colorWithRed:117/255.0 green:180/255.0 blue:56/255.0 alpha:1];
    [self.wechatBtn setTitle:@"微信付款" forState:0];
    [self.footView addSubview:_wechatBtn];
    
}

//  button1普通状态下的背景色
- (void)button1BackGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = [UIColor whiteColor];
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = ALLText2Color;
}

- (void)numberBtn:(UIButton *)sender {

    if (sender.tag == 8000) {
        
    }
    
}

- (void)alipay {
    
    SGQRCodeScanningVC *svc = [[SGQRCodeScanningVC alloc]init];
    svc.navString = @"支付宝付款";
    svc.moneyDouble = [_moneyTextField.text doubleValue];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)wechat {
    
    SGQRCodeScanningVC *svc = [[SGQRCodeScanningVC alloc]init];
    svc.navString = @"微信付款";
    svc.moneyDouble = [_moneyTextField.text doubleValue];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
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
