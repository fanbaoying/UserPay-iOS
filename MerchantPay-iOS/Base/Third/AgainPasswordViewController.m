//
//  AgainPasswordViewController.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/26.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "AgainPasswordViewController.h"
#import "agreeFirstNav.h"

#import "TXSecretaryField.h"

#import "MyCardViewController.h"

#import "FMDB.h"
@interface AgainPasswordViewController ()<TXSecretaryFieldDelegate>
{
    TXSecretaryField *_passWord;
    
}

@property(strong,nonatomic)agreeFirstNav *nav;

@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSString *bankStr;
@property(strong,nonatomic)NSString *bankType;
@property(strong,nonatomic)NSString *cardStr;

@end

@implementation AgainPasswordViewController

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
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"确认支付密码" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)sectetaryDidFinishedInput:(TXSecretaryField *)secField{
    if (secField.text.length == 6) {
    
        if ([_passWordStr isEqual:[NSString stringWithFormat:@"%@",secField.text]]) {
            
            NSUserDefaults *bank = [NSUserDefaults standardUserDefaults];
            NSDictionary *succeedBankCard = [bank objectForKey:@"bankid"];
            
            NSLog(@"%@",succeedBankCard);
            _bankStr = [succeedBankCard objectForKey:@"bankStr"];
            _bankType = [succeedBankCard objectForKey:@"bankType"];
            _cardStr = [succeedBankCard objectForKey:@"cardStr"];
            
            //1.获得数据库文件的路径
            NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
            
            //2.获得数据库
            FMDatabase *db=[FMDatabase databaseWithPath:fileName];
            
            //3.打开数据库
            if ([db open]) {
                //4.创表
                BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_agreeOrder (id integer PRIMARY KEY AUTOINCREMENT, bankStr text NOT NULL, bankType text NOT NULL, cardStr text NOT NULL, password text NOT NULL);"];
                
                if (result){
                    NSLog(@"创表成功");
                }else{
                    NSLog(@"创表失败");
                }
            }
            self.db=db;
            
            [self insert];

        }else{
        
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码不同" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
            
        }

        //        [secField resignFirstResponder];
    }
    NSLog(@"%@",secField.text);
}

//插入数据
-(void)insert{
    BOOL res = [self.db executeUpdate:@"INSERT INTO t_agreeOrder (bankStr, bankType, cardStr, password) VALUES (?, ?, ?, ?);", _bankStr, _bankType, _cardStr, _passWordStr];
    
    if (!res) {
        NSLog(@"增加数据失败");
    }else{
        NSLog(@"增加数据成功");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"银行卡添加成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:alert afterDelay:2.0];
    
    }
}

- (void)dismiss:(UIAlertController *)alert{
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
