//
//  GYPopView.m
//  Demo
//
//  Created by Galen on 2017/8/11.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYPopView.h"
#import "agreeFirstNav.h"

#import "SweepViewController.h"

@interface GYPopView()

@property(strong,nonatomic)agreeFirstNav *nav;

@property ( nonatomic, retain ) UIView *bgView;

@property(strong,nonatomic)UITextField *moneyTextField;

@property(strong,nonatomic)UIView *contentView;
@property(strong,nonatomic)UIButton *numberBtn;

@property(strong,nonatomic)UIView *footView;
@property(strong,nonatomic)UIButton *alipayBtn;
@property(strong,nonatomic)UIButton *wechatBtn;

@end

@implementation GYPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)bgView
{
if (!_bgView)
    {
        _bgView=[[UIView alloc]initWithFrame:self.bounds];
        _bgView.backgroundColor=[UIColor clearColor];
    }
    
    return _bgView;
}

-(instancetype)init
{
    if (self=[super init])
    {
       self= [super initWithFrame:CGRectMake(0, 0,
                                        [UIScreen mainScreen].bounds.size.width,
                                        [UIScreen mainScreen].bounds.size.height)];
       

    }
    
    return self;
    
    
}

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame])
    {

        self.backgroundColor=[UIColor darkGrayColor];

        [self createPopViewContent];
        
        
    }
    return self;
    
    
}

-(void)createPopViewContent
{

    [self addSubview:self.bgView];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:nil andWithRightBtn:@"close" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.rightBtn addTarget:self action:@selector(touchupDismissButton) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:_nav];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(15, 74, SCREEN_WIDTH-30, 60)];
    myView.backgroundColor = [UIColor whiteColor];
    myView.layer.cornerRadius = 5.0;
    myView.clipsToBounds = YES;
    [self.bgView addSubview:myView];
    
    self.moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 74, SCREEN_WIDTH-40, 60)];
    self.moneyTextField.backgroundColor = [UIColor whiteColor];
    self.moneyTextField.layer.cornerRadius = 5.0;
    self.moneyTextField.clipsToBounds = YES;
    self.moneyTextField.textAlignment = NSTextAlignmentRight;
    self.moneyTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTextField.text = @"¥ 0";
    self.moneyTextField.font = [UIFont systemFontOfSize:30.0];
    
    [self.bgView addSubview:_moneyTextField];
    
    [self content];

}


- (void)content {
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2, SCREEN_WIDTH-20, 250)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5.0;
    self.contentView.clipsToBounds = YES;
    [self.bgView addSubview:_contentView];
    
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2 + 260, SCREEN_WIDTH-20, 60)];
    self.footView.backgroundColor = [UIColor whiteColor];
    self.footView.layer.cornerRadius = 5.0;
    self.footView.clipsToBounds = YES;
    [self.bgView addSubview:_footView];
    
    for (int i = 0; i < 2; i++) {
        int count = (SCREEN_WIDTH-22)*i/3;
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-22)/3 + count, 0, 1, 250)];
        lab1.backgroundColor = ALLText2Color;
        [self.contentView addSubview:lab1];
    }
    
    for (int i = 0; i < 3; i++) {
        int count = 250*i/4;
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 250/4 + count, SCREEN_WIDTH-20, 1)];
        lab1.backgroundColor = ALLText2Color;
        [self.contentView addSubview:lab1];
    }
    
    NSArray *dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@"10"];
    
    for (int i = 0; i < dataArr.count; i ++) {
        
        if (i < 3) {
            int count1 = (SCREEN_WIDTH-22)*i/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count1, 0, (SCREEN_WIDTH-22)/3, 250/4)];
            [self.numberBtn setTitle:dataArr[i] forState:0];
            self.numberBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
            [self.numberBtn setTitleColor:[UIColor blackColor] forState:0];
            [self.contentView addSubview:_numberBtn];
        }else if (i >= 3 && i <= 5){
            int count2 = (SCREEN_WIDTH-22)*(i-3)/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count2, 250/4, (SCREEN_WIDTH-22)/3, 250/4)];
            [self.numberBtn setTitle:dataArr[i] forState:0];
            self.numberBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
            [self.numberBtn setTitleColor:[UIColor blackColor] forState:0];
            [self.contentView addSubview:_numberBtn];
        }else if (i >= 6 && i <= 8){
        
            int count3 = (SCREEN_WIDTH-22)*(i-6)/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count3, 250*2/4, (SCREEN_WIDTH-22)/3, 250/4)];
            [self.numberBtn setTitle:dataArr[i] forState:0];
            self.numberBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
            [self.numberBtn setTitleColor:[UIColor blackColor] forState:0];
            [self.contentView addSubview:_numberBtn];
        }else if (i >= 9 && i <= 11){
            
            int count4 = (SCREEN_WIDTH-22)*(i-9)/3;
            self.numberBtn = [[UIButton alloc]initWithFrame:CGRectMake(count4, 250*3/4, (SCREEN_WIDTH-22)/3, 250/4)];
            [self.numberBtn setTitle:dataArr[i] forState:0];
            self.numberBtn.titleLabel.font = [UIFont systemFontOfSize:30.0];
            [self.numberBtn setTitleColor:[UIColor blackColor] forState:0];
            [self.contentView addSubview:_numberBtn];
        }
   
    }

    self.alipayBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-20)/2, 60)];
    [self.alipayBtn setTitle:@"支付宝收款" forState:0];
    [self.alipayBtn setTitleColor:[UIColor blackColor] forState:0];
    [self.alipayBtn addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:_alipayBtn];
    
    self.wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20)/2, 0, (SCREEN_WIDTH-20)/2, 60)];
    [self.wechatBtn addTarget:self action:@selector(wechat) forControlEvents:UIControlEventTouchUpInside];
    self.wechatBtn.backgroundColor = [UIColor colorWithRed:117/255.0 green:180/255.0 blue:56/255.0 alpha:1];
    [self.wechatBtn setTitle:@"微信收款" forState:0];
    [self.footView addSubview:_wechatBtn];
    
}

- (void)alipay {

    SweepViewController *svc = [[SweepViewController alloc]init];
    svc.navString = @"支付宝收款";
    
    self.hidden = YES;
    [self endEditing:YES];
    [self.first.navigationController pushViewController:svc animated:YES];
    
}

-(void)wechat {

    
    
}

-(void)touchupDismissButton
{
    [self endEditing:YES];
    [UIView animateWithDuration:1.0 animations:^{
        self.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0];
        
        self.bgView.frame=CGRectMake(0,
                                   CGRectGetHeight(self.frame),
                                   CGRectGetWidth(self.frame),
                                   CGRectGetHeight(self.frame));
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.bgView=nil;
        
        
    }];
    
    
    
    
}

-(void)showPopView
{
    
    self.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0];
    
    self.bgView.frame=CGRectMake(0,
                               CGRectGetHeight(self.frame),
                               CGRectGetWidth(self.frame),
                               CGRectGetHeight(self.frame));
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.7];
        
        self.bgView.frame=CGRectMake(0,0,
                                   CGRectGetWidth(self.frame),
                                   CGRectGetHeight(self.frame));
        
//        [self.moneyTextField becomeFirstResponder];
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

@end
