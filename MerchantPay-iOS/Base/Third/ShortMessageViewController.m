//
//  ShortMessageViewController.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/25.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "ShortMessageViewController.h"
#include "agreeFirstNav.h"

#import "MyCardViewController.h"

#import "PasswordViewController.h"

@interface ShortMessageViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UIActivityIndicatorView *activityIndicator;

@property(strong,nonatomic)UIView *headerView;
@property(strong,nonatomic)UIView *contentView;
@property(strong,nonatomic)UIView *fooderView;

@property(strong,nonatomic)UIButton *okBtn;

@property(strong,nonatomic)UIButton *againBtn;

@property(strong,nonatomic)NSTimer *buttonTimer;

@property(assign,nonatomic)BOOL commonBool;

@end

@implementation ShortMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    [self header];
    [self content];
    [self fooder];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 200, 50, 50)];
    self.activityIndicator.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;//设置进度轮显示类型
    
    [self.view addSubview:_activityIndicator];
    
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"手机短信验证" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (self.contentTextField.text.length == 0) {
        [self.contentTextField becomeFirstResponder];
    }else{
        [self.contentTextField canBecomeFirstResponder];
    }
    
}

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)header {
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 70)];
    self.headerView.backgroundColor = ALLBGColor;
    [self.view addSubview:_headerView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-30, 30)];
    titleLab.text = @"请输入手机162****8299收到的短信验证码";
    titleLab.font = [UIFont systemFontOfSize:15.0];
    titleLab.textColor = ALLTextColor;
    [self.headerView addSubview:titleLab];

}

- (void)content {

    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 50)];
    [self.view addSubview:_contentView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/5, 50)];
    titleLab.text = @"验证码";
    [self.contentView addSubview:titleLab];
    
    self.contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 0, SCREEN_WIDTH/3, 50)];
    [self.contentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _contentTextField.placeholder = @"短信验证码";
    _contentTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_contentTextField];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3-35, 10, 1, 30)];
    lab.backgroundColor = ALLText1Color;
    [self.contentView addSubview:lab];
    
    self.againBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3-35, 0, SCREEN_WIDTH/3+20, 50)];
    [_againBtn addTarget:self action:@selector(againBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.againBtn.userInteractionEnabled = NO;
    [self messageTime];
    [_againBtn setTitleColor:ALLTextColor forState:0];
    [self.contentView addSubview:_againBtn];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    
}

- (void)againBtn:(UIButton *)sender{

    [self messageTime];
}

- (void)messageTime {

    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.againBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [_againBtn setTitleColor:[UIColor blackColor] forState:0];
                self.againBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.againBtn setTitle:[NSString stringWithFormat:@"(%@)重新发送",strTime] forState:UIControlStateNormal];
                [_againBtn setTitleColor:ALLTextColor forState:0];
                //To do
                [UIView commitAnimations];
                self.againBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

- (void)fooder {

    self.fooderView = [[UIView alloc]initWithFrame:CGRectMake(0, 185, SCREEN_WIDTH, SCREEN_HEIGHT - 185)];
    self.fooderView.backgroundColor = ALLBGColor;
    [self.view addSubview:_fooderView];
    
    UILabel *reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-15, 20, SCREEN_WIDTH/2, 30)];
    reminderLab.text = @"收不到验证码？";
    reminderLab.textColor = [UIColor colorWithRed:65/255.0 green:93/255.0 blue:140/255.0 alpha:1];
    reminderLab.textAlignment = NSTextAlignmentRight;
    [self.fooderView addSubview:reminderLab];
    
    self.okBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 60)];
    self.okBtn.backgroundColor = ALLText1Color;
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitle:@"验证信息" forState:UIControlStateNormal];
    //    self.okBtn.layer.cornerRadius = 5;
    [self.fooderView addSubview:_okBtn];
    
}

//限制手机号输入
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.contentTextField) {
        if (textField.text.length > 0) {
            _okBtn.backgroundColor = ALLBtnColor;
            
            _commonBool = YES;
        }else{
            self.okBtn.backgroundColor = [UIColor lightGrayColor];
            
            _commonBool = NO;
        }
    }
    
}

//确认提交
- (void)okBtn:(UIButton *)sender{

    if (_commonBool == YES) {
        [self.activityIndicator startAnimating];
        
        [self starTimer];
    }
  
}

- (void)change {
    
    [self.activityIndicator stopAnimating];
    
    PasswordViewController *pvc = [[PasswordViewController alloc]init];
    
    [self.navigationController pushViewController:pvc animated:YES];
    
    [self stopTimer];
}

//开启定时器
- (void)starTimer{
    
    self.buttonTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
}

//关闭定时器
- (void)stopTimer{
    
    [self.buttonTimer invalidate];
    self.buttonTimer = nil;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    [self.view endEditing:YES];
    
}

@end
