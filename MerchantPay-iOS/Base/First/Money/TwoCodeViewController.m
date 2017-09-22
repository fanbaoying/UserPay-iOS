//
//  TwoCodeViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/15.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "TwoCodeViewController.h"

#import "SGQRCode.h"
#import "FBYHomeService.h"
#import "AFNetworking.h"

@interface TwoCodeViewController ()

@property(strong,nonatomic)UIImageView *twoCodeImg;

@property(strong,nonatomic)UIView *contentView;

@property(strong,nonatomic)UILabel *customLab;
@property(strong,nonatomic)UILabel *reminderLab;
@property(strong,nonatomic)UIButton *commodityBtn;
@end

@implementation TwoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 生成二维码(中间带有图标)
    [self setupGenerate_Icon_QRCode];
    
    
}
- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    [self.contentView removeFromSuperview];
    
}

- (void)content {

    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*2/3-64, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    [self.view addSubview:_contentView];
    
    self.customLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.customLab.text = [NSString stringWithFormat:@"¥ %.2f",_moneyDouble1];
    self.customLab.font = [UIFont systemFontOfSize:30.0];
    self.customLab.textAlignment = NSTextAlignmentCenter;
    self.customLab.textColor = ALLBtnColor;
    self.customLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_customLab];
    
    self.reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 20)];
    self.reminderLab.text = @"请使用微信扫一扫付款";
    self.reminderLab.font = [UIFont systemFontOfSize:14.0];
    self.reminderLab.textAlignment = NSTextAlignmentCenter;
    self.reminderLab.textColor = ALLTextColor;
    self.reminderLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_reminderLab];
    
    self.commodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 90, SCREEN_WIDTH*3/5, 50)];
    self.commodityBtn.backgroundColor = ALLBtnColor;
    [self.commodityBtn addTarget:self action:@selector(commodity:) forControlEvents:UIControlEventTouchUpInside];
    self.commodityBtn.layer.borderWidth = 1.0;
    self.commodityBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.commodityBtn.layer.cornerRadius = 5.0;
    self.commodityBtn.clipsToBounds = YES;
    [self.commodityBtn setTitle:@"切换付款方式" forState:UIControlStateNormal];
    [self.contentView addSubview:_commodityBtn];
}

- (void)commodity:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.view.frame = CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }completion:^(BOOL finished) {
                         
                     }];
    
}

#pragma mark - - - 中间带有图标二维码生成
- (void)setupGenerate_Icon_QRCode {
    
    self.twoCodeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/6, SCREEN_WIDTH/6, SCREEN_WIDTH*2/3, SCREEN_WIDTH*2/3)];
    CGFloat scale = 0.2;
    
     [self.view addSubview:_twoCodeImg];
    
    
    NSMutableDictionary *mutdic1=[NSMutableDictionary dictionaryWithCapacity:0];
    
    srand((unsigned)time(0));
    int i = rand() % 1000000;
    
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
    mutdic1[@"productName"] = [NSString stringWithFormat:@"测试-%@",DateTime];
    mutdic1[@"merchantOrderNo"] = [NSString stringWithFormat:@"%@%d",DateTime,i];
    
    int amount = _moneyDouble1*100;
    mutdic1[@"amount"] = [NSString stringWithFormat:@"%d",amount];
    mutdic1[@"returnUrl"] = @"";
    mutdic1[@"notifyUrl"] = @"";
    mutdic1[@"orderPeriod"] = @"10";
    mutdic1[@"desc"] = @"";
    mutdic1[@"trxType"] = @"";
    mutdic1[@"fundIntoType"] = @"";
    NSString *payType = @"NATIVE";
    if ([payType isEqualToString:@"NATIVE"]) {
        mutdic1[@"payType"] = payType;
    }else{
        NSLog(@"支付类型为大写APP");
    }
    
    NSString *payChannel = @"WEIXIN";
    if ([payChannel isEqualToString:[NSString stringWithFormat:@"WEIXIN"]]) {
        mutdic1[@"payChannel"] = payChannel;
    }else{
        NSLog(@"微信支付标号为大写WEIXIN");
    }
    
    NSLog(@"%@",mutdic1);
    //网络请求
    FBYHomeService *service = [[FBYHomeService alloc]init];
    [service searchMessage:nil andWithAction:nil andWithDic:mutdic1 andUrl:WechatPay andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        NSLog(@"%@",[dic objectForKey:@"message"]);
        
        NSString *str = [dic objectForKey:@"respCode"];
        
        int intString = [str intValue];
        
        if (intString == 000000) {
            NSDictionary *dataDic = [dic objectForKey:@"result"];
            
            if ([dataDic isEqual:[NSNull null]]) {
                
            }else{
            
                // 2、将最终合得的图片显示在UIImageView上
                self.twoCodeImg.image = [SGQRCodeGenerateManager SG_generateWithLogoQRCodeData:[dataDic objectForKey:@"credential"] logoImageName:@"twoCodeLogo" logoScaleToSuperView:scale];
                
                [self content];
                
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
