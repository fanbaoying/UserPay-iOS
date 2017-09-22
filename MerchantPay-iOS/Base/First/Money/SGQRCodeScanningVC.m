//
//  SGQRCodeScanningVC.m
//  SGQRCodeExample
//
//  Created by kingsic on 17/3/20.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import "SGQRCodeScanningVC.h"
#import "SGQRCode.h"

#import "paySucceedViewController.h"

#import "FBYHomeService.h"
#import "AFNetworking.h"

#import "agreeFirstNav.h"

#import "TwoCodeViewController.h"

@interface SGQRCodeScanningVC () <SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;

@property(strong,nonatomic)agreeFirstNav *nav;

//@property(strong,nonatomic)UILabel *customLabel;

@property(strong,nonatomic)UIView *contentView;

@property(strong,nonatomic)UILabel *customLab;
@property(strong,nonatomic)UILabel *reminderLab;
@property(strong,nonatomic)UIImageView *sweepImg;
@property(strong,nonatomic)UILabel *chargeLab;
@property(strong,nonatomic)UIButton *commodityBtn;

@end

@implementation SGQRCodeScanningVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    [self setupNavigationBar];
    [self setupQRCodeScanning];
    [self content];
    
}

-(void)content {

    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*2/3, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    [self.view addSubview:_contentView];
    
    self.customLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.customLab.text = [NSString stringWithFormat:@"¥ %.2f",_moneyDouble];
    self.customLab.font = [UIFont systemFontOfSize:30.0];
    self.customLab.textAlignment = NSTextAlignmentCenter;
    self.customLab.textColor = ALLBtnColor;
    self.customLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_customLab];
    
    self.reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 20)];
    self.reminderLab.text = @"请扫描用户的付款码完成付款";
    self.reminderLab.font = [UIFont systemFontOfSize:14.0];
    self.reminderLab.textAlignment = NSTextAlignmentCenter;
    self.reminderLab.textColor = [UIColor whiteColor];
    self.reminderLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_reminderLab];
    
    self.commodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 90, SCREEN_WIDTH*3/5, 50)];
    self.commodityBtn.backgroundColor = [UIColor clearColor];
    [self.commodityBtn addTarget:self action:@selector(commodity:) forControlEvents:UIControlEventTouchUpInside];
    self.commodityBtn.layer.borderWidth = 1.0;
    self.commodityBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.commodityBtn.layer.cornerRadius = 5.0;
    self.commodityBtn.clipsToBounds = YES;
    [self.commodityBtn setTitle:@"切换付款方式" forState:UIControlStateNormal];
    [self.contentView addSubview:_commodityBtn];
    
}

- (void)commodity:(UIButton *)sender{
    
    TwoCodeViewController *tcvc = [[TwoCodeViewController alloc]init];
    tcvc.moneyDouble1 = _moneyDouble;
    tcvc.view.frame = CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    tcvc.view.alpha = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         tcvc.view.alpha = 1;
                         tcvc.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
                         [self addChildViewController:tcvc];
                         [self.view addSubview:tcvc.view];
                         
                     }completion:^(BOOL finished) {
                         
                     }];
    
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)setupNavigationBar {
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:_navString andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
    
}

- (void)leftBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setupQRCodeScanning {
    SGQRCodeScanManager *manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    if ([result hasPrefix:@"http"]) {
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_URL = result;
//        [self.navigationController pushViewController:jumpVC animated:YES];
        
    } else {
//        ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//        jumpVC.jump_bar_code = result;
//        [self.navigationController pushViewController:jumpVC animated:YES];
    }
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager SG_stopRunning];
        
        [self.scanningView removeTimer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
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
        mutdic1[@"productName"] = [NSString stringWithFormat:@"测试-%@",DateTime1];
        mutdic1[@"merchantOrderNo"] = [NSString stringWithFormat:@"%@%d",DateTime,i];
        
        int amount = _moneyDouble*100;
        mutdic1[@"amount"] = [NSString stringWithFormat:@"%d",amount];
        mutdic1[@"openId"] = [obj stringValue];
        mutdic1[@"returnUrl"] = @"";
        mutdic1[@"notifyUrl"] = @"";
        mutdic1[@"orderPeriod"] = @"10";
        mutdic1[@"desc"] = @"";
        mutdic1[@"trxType"] = @"";
        mutdic1[@"fundIntoType"] = @"";
        NSString *payType = @"MICROPAY";
        if ([payType isEqualToString:@"MICROPAY"]) {
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
        [service searchMessage:nil andWithAction:nil andWithDic:mutdic1 andUrl:SweepCharges andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            
            NSLog(@"%@",[dic objectForKey:@"message"]);
            
            NSString *str = [dic objectForKey:@"respCode"];
            
            int intString = [str intValue];
            
            if (intString == 000000) {
                
                paySucceedViewController *svc = [[paySucceedViewController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
                
                NSDictionary *dataDic = [dic objectForKey:@"result"];
                
                if ([dataDic isEqual:[NSNull null]]) {
                    
                }else{}
            }else{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
                    
                    [self.view addSubview:self.scanningView];
                    [self.contentView removeFromSuperview];
                    [self.nav removeFromSuperview];
                    [self setupNavigationBar];
                    [self setupQRCodeScanning];
                    [self.scanningView addTimer];
                    [self content];
                    
                }];
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
            }
        } andFailure:^(int fail) {
            
        }];
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}

- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}


@end

