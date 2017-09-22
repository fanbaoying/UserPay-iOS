//
//  OrderDetailViewController.m
//  agreePay
//
//  Created by 范保莹 on 2017/6/7.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "agreeFirstNav.h"

#import "AFNetworking.h"
#import "AGREEHomeService.h"
#import "FBYHomeService.h"

@interface OrderDetailViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UIView *baseView;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UILabel *contentLab;

@property(strong,nonatomic)UILabel *lab;

@property(strong,nonatomic)UIButton *refundBtn;

@property(strong,nonatomic)NSArray *contentArr;

@property(strong,nonatomic)NSString *payChannel;

@property(strong,nonatomic)NSString *status;

@property(strong,nonatomic)NSString *amountStr;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"订单详情" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)leftBtn:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"%@------",_trxNoStr);
    
    [self networkDate];
 
}

- (void)networkDate{

    NSString *url = [NSString stringWithFormat:@"%@%@",agreegetByTrxNo,_trxNoStr];
    
    //网络请求
    AGREEHomeService *service = [[AGREEHomeService alloc]init];
    [service searchMessage:nil andWithAction:nil andWithDic:nil andUrl:url andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        NSLog(@"%@",[dic objectForKey:@"message"]);
        
        NSString *str = [dic objectForKey:@"respCode"];
        
        int intString = [str intValue];
        
        if (intString == 000000) {
            
            NSDictionary *resultDic = [dic objectForKey:@"result"];
            
            if ([resultDic isEqual:[NSNull null]]) {
                
            }else{
                NSString *productName = [resultDic objectForKey:@"productName"];
                NSString *merchantOrderNo = [resultDic objectForKey:@"merchantOrderNo"];
                NSString *bankTrxNo = [resultDic objectForKey:@"bankTrxNo"];
                NSLog(@"%@",bankTrxNo);
                if ([bankTrxNo isEqual:[NSNull null]]) {
                    bankTrxNo = @"";
                }else{
                    bankTrxNo = [resultDic objectForKey:@"bankTrxNo"];
                }
                
                if ([[resultDic objectForKey:@"payChannel"] isEqualToString:[NSString stringWithFormat:@"0002"]]) {
                    self.payChannel = @"银联";
                }else if ([[resultDic objectForKey:@"payChannel"] isEqualToString:[NSString stringWithFormat:@"2002"]]) {
                    self.payChannel = @"支付宝";
                }else if ([[resultDic objectForKey:@"payChannel"] isEqualToString:[NSString stringWithFormat:@"2001"]]) {
                    self.payChannel = @"微信";
                }else if ([[resultDic objectForKey:@"payChannel"] isEqualToString:[NSString stringWithFormat:@"3001"]]) {
                    self.payChannel = @"快捷支付";
                }
                
                
                NSString *amount = [NSString stringWithFormat:@"¥%@",[resultDic objectForKey:@"amount"]];
                self.amountStr = [resultDic objectForKey:@"amount"];
                
                if ([[resultDic objectForKey:@"status"] isEqualToString:[NSString stringWithFormat:@"1"]]) {
                    self.status = @"已支付";
                    
                    self.refundBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, SCREEN_HEIGHT-84, SCREEN_WIDTH-120, 45)];
                    [self.refundBtn addTarget:self action:@selector(refundBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [self.refundBtn setTitle:@"退款" forState:0];
                    self.refundBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:80/255.0 blue:10/255.0 alpha:1];
                    self.refundBtn.layer.cornerRadius = 5;
                    self.refundBtn.clipsToBounds = YES;
                    [self.view addSubview:_refundBtn];
                    
                }else if ([[resultDic objectForKey:@"status"] isEqualToString:[NSString stringWithFormat:@"8"]]) {
                    self.status = @"已退款";
                    
                }else if ([[resultDic objectForKey:@"status"] isEqualToString:[NSString stringWithFormat:@"7"]]) {
                    self.status = @"部分退款";
                    
                }else if ([[resultDic objectForKey:@"status"] isEqualToString:[NSString stringWithFormat:@"5"]]) {
                    self.status = @"退款处理中";
                    
                }else {
                    self.status = @"未知";
                    
                }
                NSString *createTime = [resultDic objectForKey:@"createTime"];
                NSString *completeTime = [resultDic objectForKey:@"completeTime"];
                
                self.contentArr = @[productName,merchantOrderNo,bankTrxNo,_payChannel,amount,_status,createTime,completeTime];
                
                NSLog(@"%@",_contentArr);
                
                [self header];
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

//退款按钮
- (void)refundBtn:(UIButton *)sender{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退款提示" message:@"确定要对这笔订单发起退款吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *mutdic1=[NSMutableDictionary dictionaryWithCapacity:0];
        mutdic1[@"trxNo"] = _trxNoStr;
        srand((unsigned)time(0));
        int i = rand() % 1000000;
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MMddhhmmss"];
        NSString *DateTime = [formatter stringFromDate:date];
        mutdic1[@"outRefundNo"] = [NSString stringWithFormat:@"%@%d",DateTime,i];
        
        double amountDouble = [_amountStr doubleValue];
        double tenMoney = amountDouble*100;
        NSString *monsyStr = [NSString stringWithFormat:@"%.0f",tenMoney];
        mutdic1[@"amount"] = monsyStr;
        
        NSLog(@"%@",mutdic1);
        
        //网络请求
        FBYHomeService *service = [[FBYHomeService alloc]init];
        [service searchMessage:nil andWithAction:nil andWithDic:mutdic1 andUrl:agreeRefund andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            
            NSLog(@"%@",[dic objectForKey:@"message"]);
            
            NSString *str = [dic objectForKey:@"respCode"];
            
            int intString = [str intValue];
            
            if (intString == 000000) {
                
                NSDictionary *dataDic = [dic objectForKey:@"result"];
                
                if ([dataDic isEqual:[NSNull null]]) {
                    
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.baseView removeFromSuperview];
                        [self.refundBtn removeFromSuperview];
                        [self networkDate];
                    }];
                    
                    [alert addAction:action1];
                    [self presentViewController:alert animated:YES completion:nil];
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
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)header{
    
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-148)];
    [self.view addSubview:_baseView];

    NSArray *titleArr = @[@"订单名称",@"订单编号",@"渠道单号",@"渠道名称",@"订单金额",@"订单状态",@"下单时间",@"支付时间"];
//    self.contentArr = @[@"订单-201706061234578",@"201706061234578",@"20170606123457821133242",@"支付宝",@"¥256.00",@"已支付",@"2017-06-06 12:55:32",@"2017-06-06 12:55:32"];
    
    for (int i = 0; i < 8; i++) {
        
        int count = 50*i;
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(12, count, SCREEN_WIDTH/4, 50)];
        self.titleLab.text = titleArr[i];
        self.titleLab.textColor = ALLText3Color;
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
        [self.baseView addSubview:_titleLab];
        
        self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(12+SCREEN_WIDTH/4, count, SCREEN_WIDTH*3/4-12, 50)];
        NSLog(@"%@",_contentArr[i]);
        
        if (_contentArr[i] == [NSNull null]) {
            self.contentLab.text = @"";
        }else{
            self.contentLab.text = _contentArr[i];
        }
        self.contentLab.font = [UIFont systemFontOfSize:16.0];
        [self.baseView addSubview:_contentLab];
        
        if (i == 4) {
            self.contentLab.textColor = [UIColor colorWithRed:195 /255.0 green:0/255.0 blue:0/255.0 alpha:1];
        }else if (i == 5){
            self.contentLab.textColor = [UIColor colorWithRed:61 /255.0 green:178/255.0 blue:139/255.0 alpha:1];
        }else{
            self.contentLab.textColor = ALLTextColor;
        }

        self.lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+count, SCREEN_WIDTH, 1)];
        self.lab.backgroundColor = [UIColor colorWithRed:181 /255.0 green:188/255.0 blue:192/255.0 alpha:0.5];
        [self.baseView addSubview:_lab];
        
        
    }
    
    
    
}

@end
