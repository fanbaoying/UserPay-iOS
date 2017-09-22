//
//  PasswordViewController.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/26.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "PasswordViewController.h"
#import "agreeFirstNav.h"

#import "TXSecretaryField.h"

#import "AgainPasswordViewController.h"


@interface PasswordViewController ()<TXSecretaryFieldDelegate>
{
    TXSecretaryField *_passWord;
    
}

@property(strong,nonatomic)agreeFirstNav *nav;

@end

@implementation PasswordViewController

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
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"设置支付密码" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
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
        
        AgainPasswordViewController *apvc = [[AgainPasswordViewController alloc]init];
        apvc.passWordStr = secField.text;
        [self.navigationController pushViewController:apvc animated:YES];
//        [secField resignFirstResponder];
    }
    NSLog(@"%@",secField.text);
}


@end
