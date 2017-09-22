//
//  BankCardViewController.m
//  agreeDemo
//
//  Created by 范保莹 on 2017/7/24.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "BankCardViewController.h"
#import "agreeFirstNav.h"

#import "CardMessageViewController.h"

@interface BankCardViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *contentLab;

@property(strong,nonatomic)UIView *titleView;
@property(strong,nonatomic)UIView *contentView;

@property(strong,nonatomic)UIView *fooderView;
@property(strong,nonatomic)UIButton *nextBtn;

@property(strong,nonatomic)UILabel *reminderLab;

@property(assign,nonatomic)BOOL commonBool;

@property(assign,nonatomic)BOOL nextBool;


@property(strong,nonatomic)NSString *bankStr;
@property(strong,nonatomic)NSString *cardTypeStr;
@property(strong,nonatomic)NSString *cardNoLength;

@property(strong,nonatomic)NSString *cardNumber;

@property(strong,nonatomic)NSString *keyString;

@end

@implementation BankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    [self content];
    
    [self fooder];
    
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"添加银行卡" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
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

- (void)content{
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 50)];
    self.titleView.backgroundColor = ALLBGColor;
    [self.view addSubview:_titleView];

    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-20, 20)];
    self.titleLab.text = @"请绑定账户本人的银行卡";
    self.titleLab.textColor = ALLTextColor;
    [self.titleView addSubview:_titleLab];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, 60)];
    [self.view addSubview:_contentView];
    
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/5, 40)];
    self.contentLab.text = @"卡  号";
    [self.contentView addSubview:_contentLab];
    
    self.contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5+15, 10, SCREEN_WIDTH-SCREEN_WIDTH/5-30, 40)];
    self.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [self.contentTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.contentTextField.placeholder = @"无需网银／免手续费";
    self.contentTextField.delegate = self;
    [self.contentView addSubview:_contentTextField];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

- (void)fooder{

    self.fooderView = [[UIView alloc]initWithFrame:CGRectMake(0, 175, SCREEN_WIDTH, SCREEN_HEIGHT-175)];
    self.fooderView.backgroundColor = ALLBGColor;
    [self.view addSubview:_fooderView];
    
    self.reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 20)];
    self.reminderLab.text = @"";
    [self.fooderView addSubview:_reminderLab];
    
    self.nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 70, SCREEN_WIDTH-30, 60)];
    self.nextBtn.backgroundColor = [UIColor lightGrayColor];
    [self.nextBtn setTitle:@"下一步" forState:0];
    [self.nextBtn addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.fooderView addSubview:_nextBtn];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.contentTextField) {
        // 4位分隔银行卡卡号
        NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@",text);
//        text为输入框内的文本，没有“ ”的内容
        self.cardNumber = text;
        [self textData:text];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if ([newString stringByReplacingOccurrencesOfString:@" " withString:@""].length >= 21) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
    }
    return YES;
}

- (void)textData:(NSString *)text {

    NSLog(@"%@",text);
    
    if ([_reminderLab.text isEqualToString:[NSString stringWithFormat:@""]]) {

    //第一种方法读取
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:@"bank.json"];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dic);
        
    NSDictionary *bankNameDic = [dic objectForKey:text];
    self.keyString = text;
    self.bankStr = [bankNameDic objectForKey:@"bank"];
    self.cardTypeStr = [bankNameDic objectForKey:@"cardType"];
    self.cardNoLength = [bankNameDic objectForKey:@"cardNoLength"];
    NSLog(@"%@%@%@",_bankStr,_cardTypeStr,_cardNoLength);
        
    }
    if (_bankStr != NULL) {
        self.reminderLab.text = [NSString stringWithFormat:@"%@%@",_bankStr,_cardTypeStr];
        
        if (text.length == [_cardNoLength intValue]) {
            
            _nextBtn.backgroundColor = ALLBtnColor;
            _commonBool = YES;
            _nextBool = NO;
        }else{
        
            self.nextBtn.backgroundColor = [UIColor lightGrayColor];
            _commonBool = NO;
            _nextBool = NO;
        }
        
        if (text.length < _keyString.length) {
            self.reminderLab.text = @"";
        }
        
    }else{
        self.reminderLab.text = @"";
        
        NSLog(@"%lu",text.length);
        
        if (text.length >= 11 && text.length <= 19) {
            
            _nextBtn.backgroundColor = ALLBtnColor;
            _commonBool = YES;
            _nextBool = YES;
            
        }else{
            
            self.nextBtn.backgroundColor = [UIColor lightGrayColor];
            _commonBool = NO;
            _nextBool = NO;
        }
        
        
    }
    
}

//限制手机号输入
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.contentTextField) {
//        
//        
//        
//    }
//    
//}

- (void)nextBtn:(UIButton *)sender{

    if (_commonBool == YES) {

    if (_nextBool == YES) {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认卡号准确无误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CardMessageViewController *cmvc = [[CardMessageViewController alloc]init];
        
        cmvc.cardString = _contentTextField.text;
        cmvc.cardNameString = _reminderLab.text;
        cmvc.bankString = _bankStr;
        cmvc.bankTypeString = _cardTypeStr;
        cmvc.cardNumber = _cardNumber;
        
        [self.navigationController pushViewController:cmvc animated:YES];
    }];
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
    }else{
        CardMessageViewController *cmvc = [[CardMessageViewController alloc]init];
    
        cmvc.cardString = _contentTextField.text;
        cmvc.cardNameString = _reminderLab.text;
        cmvc.bankString = _bankStr;
        cmvc.bankTypeString = _cardTypeStr;
        cmvc.cardNumber = _cardNumber;
        
        [self.navigationController pushViewController:cmvc animated:YES];
    }
        
    }
    
    if ([_contentTextField.text isEqualToString:[NSString stringWithFormat:@"8"]]) {
        CardMessageViewController *cmvc = [[CardMessageViewController alloc]init];
        [self.navigationController pushViewController:cmvc animated:YES];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

@end
