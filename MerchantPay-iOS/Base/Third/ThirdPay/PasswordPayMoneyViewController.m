//
//  PasswordPayMoneyViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/16.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "PasswordPayMoneyViewController.h"
#import "agreeFirstNav.h"

#import "TXSecretaryField.h"

@interface PasswordPayMoneyViewController ()<TXSecretaryFieldDelegate>
{
    TXSecretaryField *_passWord;
    
}

@property(strong,nonatomic)agreeFirstNav *nav;


@end

@implementation PasswordPayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    //输入框
    _passWord = [[TXSecretaryField alloc] initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH-40, (SCREEN_WIDTH-40)/6)];
    _passWord.secureTextEntry = YES;
    [_passWord becomeFirstResponder];
    _passWord.keyboardType = UIKeyboardTypeNumberPad;
    _passWord.layer.borderColor = [UIColor whiteColor].CGColor;
    _passWord.layer.borderWidth = 2;
    _passWord.layer.cornerRadius = 4;
    _passWord.secretaryDelegate = self;
    [self.view addSubview:_passWord];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"输入支付密码" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [_passWord becomeFirstResponder];
}

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)sectetaryDidFinishedInput:(TXSecretaryField *)secField{
    if (secField.text.length == 6) {
        
        NSUserDefaults *money2 = [NSUserDefaults standardUserDefaults];
        NSString *money2Str = [money2 objectForKey:@"money2id"];
        
        NSString *residueMoneyStr = [NSString stringWithFormat:@"%.2f",[money2Str doubleValue] - [_residueMoney doubleValue]];
        
        
        [money2 setObject:residueMoneyStr forKey:@"money2id"];
        [money2 synchronize];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"付款成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
    
    }
    NSLog(@"%@",secField.text);
}

- (void)dismiss1:(UIAlertController *)alert{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
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
