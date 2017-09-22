//
//  PayPasswordViewController.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/26.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "PayPasswordViewController.h"
#import "agreeFirstNav.h"

#import "TXSecretaryField.h"

#import "FBYHomeService.h"
#import "AFNetworking.h"

#import "ThirdViewController.h"

@interface PayPasswordViewController ()<TXSecretaryFieldDelegate>
{
    TXSecretaryField *_passWord;
    
}

@property(strong,nonatomic)agreeFirstNav *nav;

@end

@implementation PayPasswordViewController

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
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"身份验证" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
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
        
        if ([secField.text isEqualToString:[NSString stringWithFormat:@"%@",_passwordStr]]) {
            
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
            mutdic1[@"editTime"] = DateTime1;
            mutdic1[@"orderTime"] = DateTime1;
            mutdic1[@"merchantNo"] = @"12345678";
            
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"MMddhhmmss"];
            NSString *DateTime = [formatter stringFromDate:date];
            mutdic1[@"productName"] = [NSString stringWithFormat:@"测试-%@",DateTime];
            mutdic1[@"merchantOrderNo"] = [NSString stringWithFormat:@"%@%d",DateTime,i];
            mutdic1[@"trxNo"] = [NSString stringWithFormat:@"%@%d",DateTime,i];
            NSLog(@"%@",_moneyAmount);
            mutdic1[@"payWayCode"] = @"3001";
            mutdic1[@"status"] = @"1";
            mutdic1[@"orderAmount"] = _moneyAmount;
            mutdic1[@"returnUrl"] = @"";
            mutdic1[@"notifyUrl"] = @"";
            mutdic1[@"orderPeriod"] = @"10";
            mutdic1[@"trxType"] = @"";
            mutdic1[@"fundIntoType"] = @"";
            mutdic1[@"isRefund"] = @"101";
            mutdic1[@"payTypeCode"] = @"APP";
            
            NSLog(@"%@",mutdic1);
            //网络请求
            FBYHomeService *service = [[FBYHomeService alloc]init];
            [service searchMessage:@"1" andWithAction:nil andWithDic:mutdic1 andUrl:cardPay andSuccess:^(NSDictionary *dic) {
                
                NSLog(@"%@",dic);
                
                NSLog(@"%@",[dic objectForKey:@"msg"]);
                
                NSString *str = [dic objectForKey:@"code"];
                
                int intString = [str intValue];
                
                if (intString == 0) {
//                    NSDictionary *dataDic = [dic objectForKey:@"result"];
//                    
//                    if ([dataDic isEqual:[NSNull null]]) {
//                        
//                    }else{
//                        
//                        }
//                    }
                
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[ThirdViewController class]]) {
                    
                    NSUserDefaults *message = [NSUserDefaults standardUserDefaults];
                    [message setObject:@"8100" forKey:@"messageid"];
                            [message synchronize];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                            
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                    }
                    
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action1];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            } andFailure:^(int fail) {
                
            }];
            
        }
        
    }
    NSLog(@"%@",secField.text);
}

@end
