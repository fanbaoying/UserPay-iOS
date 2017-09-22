//
//  CardMessageViewController.m
//  agreeDemo
//
//  Created by 范保莹 on 2017/7/24.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "CardMessageViewController.h"
#import "agreeFirstNav.h"

#import "ShortMessageViewController.h"

@interface CardMessageViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UIView *myView;

@property(strong,nonatomic)UIView *cardView;
@property(strong,nonatomic)UIView *reminderView;
@property(strong,nonatomic)UIView *contentView;
@property(strong,nonatomic)UIView *fooderView;

@property(strong,nonatomic)UITextField *nameTextField;
@property(strong,nonatomic)UITextField *idCardTextField;
@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UIButton *commonBtn;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIButton *okBtn;

@property(assign,nonatomic)BOOL commonBool;

@end

@implementation CardMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_myView];
    
    [self bankCard];
    [self reminder];
    [self content];
    [self fooder];
    
    //键盘的显示和退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"验证银行卡信息" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSLog(@"%@",_bankString);
    NSLog(@"%@",_bankTypeString);
    NSLog(@"%@",_cardNumber);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    if (_bankString == NULL) {
        mutdic[@"bankStr"] = @"";
    }else{
        mutdic[@"bankStr"] = _bankString;
    }
    if (_bankTypeString == NULL) {
        mutdic[@"bankType"] = @"";
    }else{
        mutdic[@"bankType"] = _bankTypeString;
    }
    
    mutdic[@"cardStr"] = _cardNumber;
    NSUserDefaults *bankid = [NSUserDefaults standardUserDefaults];
    [bankid setObject:mutdic forKey:@"bankid"];
    [bankid synchronize];
    
    if (self.nameTextField.text.length == 0) {
        [self.nameTextField becomeFirstResponder];
    }else{
        [self.nameTextField canBecomeFirstResponder];
    }
    
}

//pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.myView.transform = CGAffineTransformMakeTranslation(0, - ty + 170);
    }];
    
}
//pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.myView.transform = CGAffineTransformIdentity;
    }];
}

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bankCard {

    self.cardView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 70)];
    [self.myView addSubview:_cardView];
    
    if ([_cardNameString isEqualToString:[NSString stringWithFormat:@""]]) {
        
        UILabel *cardNumber = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH/5, 30)];
        cardNumber.text = @"卡  号";
        cardNumber.textColor = ALLTextColor;
        [self.cardView addSubview:cardNumber];
        
        UILabel *CardNum = [[UILabel alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 20, SCREEN_WIDTH - SCREEN_WIDTH/5 - 30, 30)];
        CardNum.text = _cardString;
        CardNum.font = [UIFont systemFontOfSize:16.0];
        CardNum.textColor = ALLTextColor;
        [self.cardView addSubview:CardNum];
    }else{
    
        UILabel *bankCard = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/5, 20)];
        bankCard.text = @"银行卡";
        bankCard.textColor = ALLTextColor;
        [self.cardView addSubview:bankCard];
        
        UILabel *bankCardName = [[UILabel alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 10, SCREEN_WIDTH - SCREEN_WIDTH/5 - 30, 20)];
        bankCardName.text = _cardNameString;
        bankCardName.textColor = ALLTextColor;
        [self.cardView addSubview:bankCardName];
        
        UILabel *cardNumber = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH/5, 20)];
        cardNumber.text = @"卡  号";
        cardNumber.textColor = ALLTextColor;
        [self.cardView addSubview:cardNumber];
        
        UILabel *CardNum = [[UILabel alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 40, SCREEN_WIDTH - SCREEN_WIDTH/5 - 30, 20)];
        CardNum.text = _cardString;
        CardNum.font = [UIFont systemFontOfSize:16.0];
        CardNum.textColor = ALLTextColor;
        [self.cardView addSubview:CardNum];
    }
}

- (void)reminder {
    
    self.reminderView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 50)];
    self.reminderView.backgroundColor = ALLBGColor;
    [self.myView addSubview:_reminderView];
    
    UILabel *reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-30, 20)];
    reminderLab.text = @"提醒：后续只能绑定该持卡人的银行卡";
    reminderLab.textColor = ALLTextColor;
    reminderLab.font = [UIFont systemFontOfSize:16.0];
    [self.reminderView addSubview:reminderLab];

}

- (void)content {

    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 150)];
    [self.myView addSubview:_contentView];
    
    NSArray *titleArr = @[@"持卡人",@"身份证",@"手机号"];
    
    for (int i = 0; i < titleArr.count; i ++) {
        
        int count = 50*i;
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, count, SCREEN_WIDTH/5, 50)];
        titleLab.text = titleArr[i];
        [self.contentView addSubview:titleLab];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 50+count, SCREEN_WIDTH-15, 1)];
        lab.backgroundColor = ALLText1Color;
        [self.contentView addSubview:lab];
        
    }
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 0, SCREEN_WIDTH - SCREEN_WIDTH/5 - 30, 50)];
    self.nameTextField.placeholder = @"持卡人姓名";
//    self.nameTextField.text = @"张三";
    [self.contentView addSubview:_nameTextField];
    
    self.idCardTextField = [[UITextField alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 50, SCREEN_WIDTH - SCREEN_WIDTH/5 - 30, 50)];
    self.idCardTextField.placeholder = @"请输入证件号码";
//    self.idCardTextField.text = @"128288 63721888 5674";
    [self.contentView addSubview:_idCardTextField];
    
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(15 + SCREEN_WIDTH/5, 100, SCREEN_WIDTH - SCREEN_WIDTH/5 - 30, 50)];
    self.phoneTextField.placeholder = @"银行预留手机号";
//    self.phoneTextField.text = @"167 3819 1920";
    [self.contentView addSubview:_phoneTextField];
}

- (void)fooder {

    self.fooderView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, SCREEN_HEIGHT - 345)];
    self.fooderView.backgroundColor = ALLBGColor;
    [self.myView addSubview:_fooderView];
    
    self.commonBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 23, 25, 25)];
//    self.commonBtn.layer.borderWidth = 1;
    [self.commonBtn setImage:[UIImage imageNamed:@"no@2x"] forState:UIControlStateNormal];
    [self.commonBtn addTarget:self action:@selector(common:) forControlEvents:UIControlEventTouchUpInside];
//    self.commonBtn.layer.borderColor = [UIColor clearColor].CGColor;
//    self.commonBtn.layer.cornerRadius = 10.0;
//    self.commonBtn.clipsToBounds = YES;
    [self.fooderView addSubview:_commonBtn];
    
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, SCREEN_WIDTH - 60, 30)];
    self.titleLab.textColor = ALLTextColor;
    self.titleLab.font = [UIFont systemFontOfSize:15.0];
    self.titleLab.text = @"同意《用户服务协议》";
    [self.fooderView addSubview:_titleLab];
    
    self.okBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 60)];
    self.okBtn.backgroundColor = ALLText1Color;
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitle:@"验证信息" forState:UIControlStateNormal];
//    self.okBtn.layer.cornerRadius = 5;
    [self.fooderView addSubview:_okBtn];
    
    
}

- (void)common:(UIButton *)sender{
    
    if (_commonBool == NO && ![_nameTextField.text  isEqual: @""] && ![_idCardTextField.text  isEqual: @""] && ![_phoneTextField.text  isEqual: @""]) {
        [self.commonBtn setImage:[UIImage imageNamed:@"yes@2x"] forState:UIControlStateNormal];
        _okBtn.backgroundColor = ALLBtnColor;
        
        _commonBool = YES;
    }else{
        
        [self.commonBtn setImage:[UIImage imageNamed:@"no@2x"] forState:UIControlStateNormal];
        self.okBtn.backgroundColor = [UIColor lightGrayColor];
        
        _commonBool = NO;
        
    }
    
    
    
}

//确认提交
- (void)okBtn:(UIButton *)sender{
    
    if (_commonBool == YES) {
        ShortMessageViewController *smvc = [[ShortMessageViewController alloc]init];
        
        [self.navigationController pushViewController:smvc animated:YES];
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

@end
