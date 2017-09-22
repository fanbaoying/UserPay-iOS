//
//  ThirdViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/16.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "ThirdViewController.h"
#import "agreeFirstNav.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "ThirdTableViewCell.h"


#import "paySucceedViewController.h"
#import "payFailureViewController.h"

#import "AgreePay.h"

#import "FirstMyBankCardViewController.h"

#import "PasswordPayMoneyViewController.h"

//#import "UPPayPluginDelegate.h"

#define kMaxAmount        9999999


@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)NSArray *titleArr;
@property(strong,nonatomic)NSArray *payImgArr;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UITextField *moneyTextField;
@property(strong,nonatomic)UIButton *okBtn;

@property(strong,nonatomic)UIView *fastPaymentView;

@property(strong,nonatomic)UITapGestureRecognizer *labTGR1;

@property(strong,nonatomic)UIView *cardPaymentView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 125, SCREEN_WIDTH, 340)];
    
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.myTableView.showsVerticalScrollIndicator = NO;
    //    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    
    self.payImgArr = @[@"zhifubao",@"weixin",@"yinlian",@"yiliaoka",@"pocketMoney"];
    self.titleArr = @[@"支付宝",@"微信支付",@"中国银联",@"快捷支付",@"余额支付"];
    
    [self head];
    
    
    //键盘的显示和退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"支付列表" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_moneyTextField resignFirstResponder];
    
}

//pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    
}
//pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    
}

- (void)head{
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 60)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 80, 40)];
    myView.layer.borderWidth = 0.5;
    myView.layer.borderColor = [UIColor colorWithRed:181 /255.0 green:188/255.0 blue:192/255.0 alpha:1].CGColor;
    myView.layer.cornerRadius = 5.0;
    myView.clipsToBounds = YES;
    [self.headView addSubview:myView];
    
    self.moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 80, 40)];
    self.moneyTextField.placeholder =@"支付金额";
    [self.moneyTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [myView addSubview:_moneyTextField];
    
    self.okBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55, 10, 40, 40)];
    [self.okBtn setTitle:@"OK" forState:0];
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.okBtn.layer.borderWidth = 1;
    [self.okBtn setTitleColor:ALLBtnColor forState:0];
    self.okBtn.layer.borderColor = [UIColor colorWithRed:181 /255.0 green:188/255.0 blue:192/255.0 alpha:1].CGColor;
    self.okBtn.layer.cornerRadius = 5.0;
    self.okBtn.clipsToBounds = YES;
    [self.headView addSubview:_okBtn];
    
    
}

- (void)okBtn:(UIButton *)sender {
    
    [_moneyTextField resignFirstResponder];
    
}

- (void) textFieldDidChange:(UITextField *) textField
{
    NSString *text = textField.text;
    NSUInteger index = [text rangeOfString:@"."].location;
    if (index != NSNotFound) {
        double amount = [[text stringByReplacingOccurrencesOfString:@"." withString:@""] doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, kMaxAmount)/100];
    } else {
        double amount = [text doubleValue];
        text = [NSString stringWithFormat:@"%.02f", MIN(amount, kMaxAmount)/100];
    }
    textField.text = text;
}

- (void)paymentView {
    
    self.fastPaymentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    self.fastPaymentView.backgroundColor = ALLBGColor;
    self.labTGR1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fireNext:)];
    [self.fastPaymentView addGestureRecognizer:_labTGR1];
    [self.view addSubview:_fastPaymentView];
    
    self.cardPaymentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    _cardPaymentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cardPaymentView];
    
    FirstMyBankCardViewController *avc = [[FirstMyBankCardViewController alloc]init];
    int amount = [_moneyTextField.text doubleValue]*100;
    avc.moneyStr = [NSString stringWithFormat:@"%d",amount];
    avc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    [self addChildViewController:avc];
    [_cardPaymentView addSubview:avc.view];
    
}

- (void)fireNext:(UIButton *)sender {
    
    self.fastPaymentView.hidden = YES;
    self.cardPaymentView.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _payImgArr.count;
    
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}
    
//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_moneyTextField resignFirstResponder];
    
    if ([_moneyTextField.text doubleValue] <= 0.00) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入付款金额" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
    }else{
    
        if (indexPath.row == 4) {
            
            NSUserDefaults *money2 = [NSUserDefaults standardUserDefaults];
            NSString *money2Str = [money2 objectForKey:@"money2id"];
            
            if ([_moneyTextField.text doubleValue] <= [money2Str doubleValue]) {
                
                PasswordPayMoneyViewController *ppvc = [[PasswordPayMoneyViewController alloc]init];
                
                ppvc.residueMoney = _moneyTextField.text;
                self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:ppvc animated:YES];
                
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"余额不足，请充值" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
                
            }
            
        }else if (indexPath.row == 3) {
            self.fastPaymentView.hidden = YES;
            self.cardPaymentView.hidden = YES;
            self.tabBarController.tabBar.hidden = YES;
            [self paymentView];
        }else{
            
            NSUserDefaults *payMoney = [NSUserDefaults standardUserDefaults];
            [payMoney setObject:@"8" forKey:@"payMoneyid"];
            [payMoney synchronize];
            
            NSMutableDictionary *mutdic1=[NSMutableDictionary dictionaryWithCapacity:0];
            
            srand((unsigned)time(0));
            int i = rand() % 1000000;
            NSLog(@"%d",i);
            
            NSDate *date1 = [NSDate date];
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            [formatter1 setDateStyle:NSDateFormatterMediumStyle];
            [formatter1 setTimeStyle:NSDateFormatterShortStyle];
            [formatter1 setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
            NSString *DateTime1 = [formatter1 stringFromDate:date1];
            mutdic1[@"orderTime"] = DateTime1;
            mutdic1[@"merchantNo"] = @"12345678";
            
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"MMddhhmmss"];
            NSString *DateTime = [formatter stringFromDate:date];
            
            mutdic1[@"merchantOrderNo"] = [NSString stringWithFormat:@"%@%d",DateTime,i];
            mutdic1[@"productName"] = [NSString stringWithFormat:@"付款-%@",DateTime];
            
            NSLog(@"%@",_moneyTextField.text);
            
            int amount = [_moneyTextField.text doubleValue]*100;
            
            mutdic1[@"amount"] = [NSString stringWithFormat:@"%d",amount];
            mutdic1[@"returnUrl"] = @"";
            mutdic1[@"notifyUrl"] = @"";
            mutdic1[@"orderPeriod"] = @"10";
            mutdic1[@"desc"] = @"";
            mutdic1[@"trxType"] = @"";
            mutdic1[@"fundIntoType"] = @"";
            NSString *payType = @"APP";
            if ([payType isEqualToString:@"APP"]) {
                mutdic1[@"payType"] = payType;
            }else{
                NSLog(@"支付类型为大写APP");
            }
            
            if (indexPath.row == 0) {
                NSString *payChannel = @"ALI";
                if ([payChannel isEqualToString:[NSString stringWithFormat:@"ALI"]]) {
                    mutdic1[@"payChannel"] = payChannel;
                }else{
                    NSLog(@"支付宝支付标号为大写ALI");
                }
            }else if (indexPath.row == 1) {
                NSString *payChannel = @"WEIXIN";
                if ([payChannel isEqualToString:[NSString stringWithFormat:@"WEIXIN"]]) {
                    mutdic1[@"payChannel"] = payChannel;
                }else{
                    NSLog(@"微信支付标号为大写WEIXIN");
                }
            }else if (indexPath.row == 2) {
                NSString *payChannel = @"ACP";
                if ([payChannel isEqualToString:[NSString stringWithFormat:@"ACP"]]) {
                    mutdic1[@"payChannel"] = payChannel;
                }else{
                    NSLog(@"银联支付标号为大写ACP");
                }
            }
            
            NSLog(@"%@",mutdic1);
            //网络请求
            FBYHomeService *service = [[FBYHomeService alloc]init];
            [service searchMessage:@"0" andWithAction:nil andWithDic:mutdic1 andUrl:WechatPay andSuccess:^(NSDictionary *dic) {
                
                NSLog(@"%@",dic);
                
                NSLog(@"%@",[dic objectForKey:@"message"]);
                
                NSString *str = [dic objectForKey:@"respCode"];
                
                int intString = [str intValue];
                
                if (intString == 000000) {
                    NSDictionary *dataDic = [dic objectForKey:@"result"];
                    
                    if ([dataDic isEqual:[NSNull null]]) {
                        
                    }else{
                        if (indexPath.row == 0) {
                            [AgreePay payOrder:dataDic appURLScheme:@"agreeAlipay2" withCompletion:^(NSString *agreeResult) {
                            }];
                        }else if (indexPath.row == 1) {
                            NSDictionary *dataDic1 = [dataDic objectForKey:@"credential"];
                            [AgreePay payOrder:dataDic appURLScheme:[dataDic1 objectForKey:@"appid"] withCompletion:^(NSString *agreeResult) {
                            }];
                        }else if (indexPath.row == 2) {
                            ThirdViewController * __weak weakSelf = self;
                            [AgreePay payOrder:dataDic viewController:weakSelf appURLScheme:@"agreeUPPay2" appmodel:@"01" withCompletion:^(NSString *agreeResult) {
                                
                            }];
                        }
                    }
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action1];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            } andFailure:^(int fail) {
                
            }];
        }
        
    }
    
}

- (void)dismiss1:(UIAlertController *)alert{
    
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[ThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.myImg.image = [UIImage imageNamed:_payImgArr[indexPath.row]];
    cell.titleLab.text = _titleArr[indexPath.row];
    
    return cell;
}


//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    header.backgroundColor = ALLBGColor;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/2, 20)];
    titleLab.text = @"选择支付方式";
    //    titleLab.textColor = ALLTextColor;
    titleLab.font = [UIFont systemFontOfSize:16.0];
    [header addSubview:titleLab];
    
    
    return header;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    NSUserDefaults *bank = [NSUserDefaults standardUserDefaults];
    NSString *bankMessage = [bank objectForKey:@"messageid"];
    
    NSLog(@"%@",bankMessage);
    
    if ([bankMessage isEqualToString:[NSString stringWithFormat:@"8100"]]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alert afterDelay:2.0];
    }
    
    
}

- (void)dismiss:(UIAlertController *)alert{
    
    NSUserDefaults *message = [NSUserDefaults standardUserDefaults];
    [message setObject:@"8104" forKey:@"messageid"];
    [message synchronize];
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    self.fastPaymentView.hidden = YES;
    self.cardPaymentView.hidden = YES;
    
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
