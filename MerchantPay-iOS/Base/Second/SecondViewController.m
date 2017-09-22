//
//  SecondViewController.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/19.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "SecondViewController.h"
#import "agreeFirstNav.h"

#import "SecondTableViewCell.h"

#import "OrderDetailViewController.h"

#import "AFNetworking.h"
#import "AGREEHomeService.h"

//下拉刷新
#import "MJRefresh.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)MJRefreshAutoGifFooter *footer;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UIButton *typeBtn;
@property(strong,nonatomic)UIButton *orderBtn;
@property(strong,nonatomic)UIButton *timeBtn;

@property(strong,nonatomic)UIView *typeView;
@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UIButton *wechatBtn;
@property(strong,nonatomic)UIButton *alipayBtn;

@property(strong,nonatomic)UIView *orderView;
@property(strong,nonatomic)UIView *bg1View;
@property(strong,nonatomic)UIButton *wechat1Btn;
@property(strong,nonatomic)UIButton *alipay1Btn;

@property(strong,nonatomic)UIView *timeView;
@property(strong,nonatomic)UIView *bg2View;
@property(strong,nonatomic)UIButton *wechat2Btn;
@property(strong,nonatomic)UIButton *alipay2Btn;

@property(assign,nonatomic)BOOL typeBOOL;
@property(strong,nonatomic)UIImageView *downImgView;

@property(assign,nonatomic)BOOL typeBOOL1;
@property(strong,nonatomic)UIImageView *downImgView1;

@property(assign,nonatomic)BOOL typeBOOL2;
@property(strong,nonatomic)UIImageView *downImgView2;

@property(strong,nonatomic)UIView *titleView;
@property(strong,nonatomic)UIImageView *titleImg;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *contentLab;
@property(strong,nonatomic)UILabel *labTitle;

@property(strong,nonatomic)NSArray *titleLabArr;

@property(strong,nonatomic)NSMutableArray *serialNumArr;
@property(strong,nonatomic)NSMutableArray *nameArr;
@property(strong,nonatomic)NSMutableArray *moneyArr;
@property(strong,nonatomic)NSMutableArray *timeArr;
@property(strong,nonatomic)NSMutableArray *trxNoArr;
@property(strong,nonatomic)NSMutableArray *statusArr;


@property(strong,nonatomic)NSString *typeStr;
@property(strong,nonatomic)NSString *orderStr;

@property(assign,nonatomic)int pageNum;

@property(assign,nonatomic)int mjrInt;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.typeStr = @"";
    self.orderStr = @"";
    
    self.serialNumArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.nameArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.moneyArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.timeArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.trxNoArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.statusArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 46)];
    self.headView.backgroundColor = ALLBGColor;
    [self.view addSubview:_headView];
    
    [self titleShow];
    
    [self header];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 111, SCREEN_WIDTH, SCREEN_HEIGHT-160)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    self.myTableView.mj_footer = _footer;
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"订单" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.view addSubview:_nav];
    
    //MJRefresh下拉加载
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJRefresh_header)];
    //MJRefresh上拉加载
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJRefresh_footer)];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.pageNum = 1;
    
    [self Status:_orderStr andPayType:_typeStr andNo:@"1"];
    
    self.tabBarController.tabBar.hidden = NO;
    
    //网络请求
    AGREEHomeService *service = [[AGREEHomeService alloc]init];
    [service searchMessage:nil andWithAction:nil andWithDic:nil andUrl:agreeGetStatics andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        NSLog(@"%@",[dic objectForKey:@"message"]);
        
        NSString *str = [dic objectForKey:@"respCode"];
        
        int intString = [str intValue];
        
        if (intString == 000000) {
            
            NSDictionary *dataDic = [dic objectForKey:@"result"];
            
            if ([dataDic isEqual:[NSNull null]]) {
                
            }else{
                
                NSString *payAmount = [dataDic objectForKey:@"payAmount"];
                NSString *tradeNum = [dataDic objectForKey:@"tradeNum"];
                NSString *refundAmount = [dataDic objectForKey:@"refundAmount"];
                NSString *refundNum = [dataDic objectForKey:@"refundNum"];
                
                self.titleLabArr = @[payAmount,tradeNum,refundAmount,refundNum];
                
                [self titleShow];
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

//下拉刷新
- (void)MJRefresh_header{
    
    [self.myTableView.mj_header beginRefreshing];
    
    self.pageNum = 1;
    [self Status:_orderStr andPayType:_typeStr andNo:@"1"];
}

//上拉刷新
- (void)MJRefresh_footer{
    
    [self.myTableView.mj_footer beginRefreshing];
    
    self.pageNum++;
    NSString *str = [NSString stringWithFormat:@"%d",_pageNum];
    
    [self Status:_orderStr andPayType:_typeStr andNo:str];
}

//获取数据
- (void)Status:(NSString *)status andPayType:(NSString *)payType andNo:(NSString *)index{
    
    //    status 状态  1：支付成功   8:退款成功 空：全部
    //    size 当前页面多少数据
    //    no   当前在第几页
    //    payType  支付方式  2002 支付宝 2001 微信 0002银联
    
    NSString *url = [NSString stringWithFormat:@"%@?status=%@&size=%@&no=%@&payType=%@",agreegetAllPay,status,@"10",index,payType];

    
    //网络请求
    AGREEHomeService *service = [[AGREEHomeService alloc]init];
    [service searchMessage:nil andWithAction:nil andWithDic:nil andUrl:url andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        NSLog(@"%@",[dic objectForKey:@"message"]);
        
        NSString *str = [dic objectForKey:@"respCode"];
        
        int intString = [str intValue];
        
        if (intString == 000000) {
            
            NSDictionary *dataDic = [dic objectForKey:@"result"];
            
            NSArray *serialNumArr = [dataDic objectForKey:@"productName"];
            NSArray *nameArr = [dataDic objectForKey:@"payWayCode"];
            NSArray *moneyArr = [dataDic objectForKey:@"amount"];
            NSArray *timeArr = [dataDic objectForKey:@"createTime"];
            NSArray *trxNoArr = [dataDic objectForKey:@"trxNo"];
            NSArray *statusArr = [dataDic objectForKey:@"status"];
            
            if (moneyArr.count == 0) {
                if ([index isEqualToString:[NSString stringWithFormat:@"1"]]) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        self.typeView.hidden = YES;
                        self.typeBOOL = NO;
                        self.downImgView.image = [UIImage imageNamed:@"down"];
                        
                        self.orderView.hidden = YES;
                        self.typeBOOL1 = NO;
                        self.downImgView1.image = [UIImage imageNamed:@"down"];
                        
                        self.timeView.hidden = YES;
                        self.typeBOOL2 = NO;
                        self.downImgView2.image = [UIImage imageNamed:@"down"];
                    }];
                    
                    [alert addAction:action1];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }else{
                    _pageNum--;
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"已经全部加载完毕" preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:alert animated:YES completion:nil];
                    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:0.5];
                    
                    [self.myTableView.mj_header endRefreshing];
                    [self.myTableView.mj_footer endRefreshing];
                }
            }else{
                
                if ([index isEqualToString:[NSString stringWithFormat:@"1"]]) {
                    [self.serialNumArr removeAllObjects];
                    [self.nameArr removeAllObjects];
                    [self.moneyArr removeAllObjects];
                    [self.timeArr removeAllObjects];
                    [self.trxNoArr removeAllObjects];
                    [self.statusArr removeAllObjects];
                }
                [self.serialNumArr addObjectsFromArray:serialNumArr];
                [self.nameArr addObjectsFromArray:nameArr];
                [self.moneyArr addObjectsFromArray:moneyArr];
                [self.timeArr addObjectsFromArray:timeArr];
                [self.trxNoArr addObjectsFromArray:trxNoArr];
                [self.statusArr addObjectsFromArray:statusArr];
                
                [self.myTableView reloadData];
                
                self.typeView.hidden = YES;
                self.typeBOOL = NO;
                self.downImgView.image = [UIImage imageNamed:@"down"];
                
                self.orderView.hidden = YES;
                self.typeBOOL1 = NO;
                self.downImgView1.image = [UIImage imageNamed:@"down"];
                
                self.timeView.hidden = YES;
                self.typeBOOL2 = NO;
                self.downImgView2.image = [UIImage imageNamed:@"down"];
                
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView.mj_footer endRefreshing];
                
            }
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView.mj_footer endRefreshing];
            }];
            
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    } andFailure:^(int fail) {
        
    }];
    
}

- (void)dismiss:(UIAlertController *)alert{

    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)titleShow{

    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    self.titleView.backgroundColor = ALLBGColor;
//    [self.headView addSubview:_titleView];

    NSArray *titleImgArr = @[@"money",@"add",@"money1",@"reduce"];
//    NSArray *titleLabArr = @[@"12345.78",@"256",@"12.34",@"18"];
    NSArray *contentArr = @[@"订单金额",@"订单笔数",@"退款金额",@"退款笔数"];

    for (int i = 0; i < titleImgArr.count; i++) {
        
        int count = SCREEN_WIDTH*i/4;
        
        self.titleImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-30)/2+count, 0, 30, 30)];
        self.titleImg.image = [UIImage imageNamed:titleImgArr[i]];
        [self.titleView addSubview:_titleImg];
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(count, 35, SCREEN_WIDTH/4, 30)];
        self.titleLab.text = _titleLabArr[i];
        self.titleLab.font = [UIFont systemFontOfSize:18.0];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = ALLTextColor;
        [self.titleView addSubview:_titleLab];
        
        self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(count, 65, SCREEN_WIDTH/4, 20)];
        self.contentLab.text = contentArr[i];
        self.contentLab.font = [UIFont systemFontOfSize:12.0];
        self.contentLab.textAlignment = NSTextAlignmentCenter;
        self.contentLab.textColor = ALLTextColor;
        [self.titleView addSubview:_contentLab];
        
        if (i <= 2) {
          
        self.labTitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4+count, 10, 1, 60)];
        self.labTitle.backgroundColor = [UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:1];;
        [self.titleView addSubview:_labTitle];
            
        }
    }
    
}

- (void)header{

    self.typeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-2)/3, 45)];
    self.typeBtn.backgroundColor = [UIColor whiteColor];
    self.typeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.typeBtn setTitle:@"渠道类型" forState:0];
    [self.typeBtn addTarget:self action:@selector(type:) forControlEvents:UIControlEventTouchUpInside];
    [self.typeBtn setTitleColor:ALLTextColor forState:0];
    [self.headView addSubview:_typeBtn];
    
    self.downImgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)/3-20, 15, 15, 15)];
    self.downImgView.image = [UIImage imageNamed:@"down"];
    [self.headView addSubview:_downImgView];

    self.orderBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)/3+1, 0, (SCREEN_WIDTH-2)/3, 45)];
    self.orderBtn.backgroundColor = [UIColor whiteColor];
    self.orderBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.orderBtn setTitle:@"订单状态" forState:0];
    [self.orderBtn addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderBtn setTitleColor:ALLTextColor forState:0];
    [self.headView addSubview:_orderBtn];
    
    self.downImgView1 = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)*2/3-20, 15, 15, 15)];
    self.downImgView1.image = [UIImage imageNamed:@"down"];
    [self.headView addSubview:_downImgView1];
    
    self.timeBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)*2/3+2, 0, (SCREEN_WIDTH-2)/3, 45)];
    self.timeBtn.backgroundColor = [UIColor whiteColor];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.timeBtn setTitle:@"下单时间" forState:0];
    [self.timeBtn addTarget:self action:@selector(time:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeBtn setTitleColor:ALLTextColor forState:0];
    [self.headView addSubview:_timeBtn];
    
    self.downImgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20, 15, 15, 15)];
    self.downImgView2.image = [UIImage imageNamed:@"down"];
    [self.headView addSubview:_downImgView2];
    
}

//渠道类型
- (void)type:(UIButton *)sender{

    self.orderView.hidden = YES;
    self.typeBOOL1 = NO;
    self.downImgView1.image = [UIImage imageNamed:@"down"];
    
    self.timeView.hidden = YES;
    self.typeBOOL2 = NO;
    self.downImgView2.image = [UIImage imageNamed:@"down"];
    
    if (self.typeBOOL == NO) {
   
    self.typeView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT-159)];
    self.typeView.backgroundColor = [[UIColor colorWithRed:181 /255.0 green:188/255.0 blue:192/255.0 alpha:1] colorWithAlphaComponent:0.4];
    self.typeView.layer.borderWidth = 1.0;
    self.typeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_typeView];
    self.typeView.hidden = NO;
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.typeView addSubview:_bgView];
    NSArray *typrArr = @[@"微信",@"支付宝",@"银联",@"快捷支付",@"全部"];
    
    for (int i = 0; i < typrArr.count; i++) {
        
        int count = 50*i;
        
        self.wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, count, (SCREEN_WIDTH-2)/3, 50)];
        self.wechatBtn.tag = 6000+i;
        [self.wechatBtn setTitleColor:ALLTextColor forState:UIControlStateNormal];
        [self.wechatBtn setTitle:typrArr[i] forState:UIControlStateNormal];
        self.wechatBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self.wechatBtn addTarget:self action:@selector(wechatBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:_wechatBtn];
        
        self.alipayBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)/3, count, (SCREEN_WIDTH-2)*2/3, 50)];
        self.alipayBtn.tag = 6000+i;
        [self.alipayBtn addTarget:self action:@selector(wechatBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.alipayBtn.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:_alipayBtn];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+count, SCREEN_WIDTH, 1)];
        lab.backgroundColor = ALLBGColor;
        [_typeView addSubview:lab];
        
    }
        self.typeBOOL = YES;
        self.downImgView.image = [UIImage imageNamed:@"up"];
        
    }else{
    
        self.typeView.hidden = YES;
        self.typeBOOL = NO;
        self.downImgView.image = [UIImage imageNamed:@"down"];
    }
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.typeView.hidden = YES;
    self.typeBOOL = NO;
    self.downImgView.image = [UIImage imageNamed:@"down"];
    
    self.orderView.hidden = YES;
    self.typeBOOL1 = NO;
    self.downImgView1.image = [UIImage imageNamed:@"down"];
    
    self.timeView.hidden = YES;
    self.typeBOOL2 = NO;
    self.downImgView2.image = [UIImage imageNamed:@"down"];
    
}

//选择支付类型点击事件
- (void)wechatBtn:(UIButton *)sender{

    self.pageNum = 1;
    if (sender.tag == 6000) {
        self.typeStr = @"2001";
        [self Status:_orderStr andPayType:@"2001" andNo:@"1"];
    }else if (sender.tag == 6001) {
        self.typeStr = @"2002";
        [self Status:_orderStr andPayType:@"2002" andNo:@"1"];
    }else if (sender.tag == 6002) {
        self.typeStr = @"0002";
        [self Status:_orderStr andPayType:@"0002" andNo:@"1"];
    }else if (sender.tag == 6003) {
        self.typeStr = @"3001";
        [self Status:_orderStr andPayType:@"3001" andNo:@"1"];
    }else if (sender.tag == 6004) {
        self.typeStr = @"";
        [self Status:_orderStr andPayType:@"" andNo:@"1"];
    }
    
}

//订单状态
- (void)order:(UIButton *)sender{
    
    self.typeView.hidden = YES;
    self.typeBOOL = NO;
    self.downImgView.image = [UIImage imageNamed:@"down"];
    
    self.timeView.hidden = YES;
    self.typeBOOL2 = NO;
    self.downImgView2.image = [UIImage imageNamed:@"down"];
    
    if (self.typeBOOL1 == NO) {
        
        self.orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT-159)];
        self.orderView.backgroundColor = [[UIColor colorWithRed:181 /255.0 green:188/255.0 blue:192/255.0 alpha:1] colorWithAlphaComponent:0.4];
        self.orderView.layer.borderWidth = 1.0;
        self.orderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.view addSubview:_orderView];
        self.orderView.hidden = NO;
        
        self.bg1View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        _bg1View.backgroundColor = [UIColor whiteColor];
        [self.orderView addSubview:_bg1View];
        NSArray *typrArr = @[@"已支付",@"已退款",@"部分退款",@"退款处理中",@"全部"];
        
        for (int i = 0; i < typrArr.count; i++) {
            
            int count = 50*i;
            
            self.wechat1Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, count, (SCREEN_WIDTH-2)/3, 50)];
            self.wechat1Btn.tag = 8000+i;
            [self.wechat1Btn setTitleColor:ALLTextColor forState:UIControlStateNormal];
            [self.wechat1Btn setTitle:typrArr[i] forState:UIControlStateNormal];
            self.wechat1Btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [self.wechat1Btn addTarget:self action:@selector(orderBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.bg1View addSubview:_wechat1Btn];
            
            self.alipay1Btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)/3, count, (SCREEN_WIDTH-2)*2/3, 50)];
            self.alipay1Btn.tag = 8000+i;
            [self.alipay1Btn addTarget:self action:@selector(orderBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.alipay1Btn.backgroundColor = [UIColor whiteColor];
            [self.bg1View addSubview:_alipay1Btn];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+count, SCREEN_WIDTH, 1)];
            lab.backgroundColor = ALLBGColor;
            [_orderView addSubview:lab];
            
        }
        self.typeBOOL1 = YES;
        self.downImgView1.image = [UIImage imageNamed:@"up"];
        
    }else{
        
        self.orderView.hidden = YES;
        self.typeBOOL1 = NO;
        self.downImgView1.image = [UIImage imageNamed:@"down"];
    }
    
}

//选择订单状态点击事件
- (void)orderBtn:(UIButton *)sender{
    
    self.pageNum = 1;
    
    if (sender.tag == 8000) {
        self.orderStr = @"1";
        [self Status:@"1" andPayType:_typeStr andNo:@"1"];
    }else if (sender.tag == 8001) {
        self.orderStr = @"8";
        [self Status:@"8" andPayType:_typeStr andNo:@"1"];
    }else if (sender.tag == 8002) {
        self.orderStr = @"7";
        [self Status:@"7" andPayType:_typeStr andNo:@"1"];
    }else if (sender.tag == 8003) {
        self.orderStr = @"5";
        [self Status:@"5" andPayType:_typeStr andNo:@"1"];
    }else if (sender.tag == 8004) {
        self.orderStr = @"";
        [self Status:@"" andPayType:_typeStr andNo:@"1"];
    }
    
}

//下单时间
- (void)time:(UIButton *)sender{
    
    self.typeView.hidden = YES;
    self.typeBOOL = NO;
    self.downImgView.image = [UIImage imageNamed:@"down"];
    
    self.orderView.hidden = YES;
    self.typeBOOL1 = NO;
    self.downImgView1.image = [UIImage imageNamed:@"down"];
    
    if (self.typeBOOL2 == NO) {
        
        self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT-159)];
        self.timeView.backgroundColor = [[UIColor colorWithRed:181 /255.0 green:188/255.0 blue:192/255.0 alpha:1] colorWithAlphaComponent:0.4];
        self.timeView.layer.borderWidth = 1.0;
        self.timeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.view addSubview:_timeView];
        self.timeView.hidden = NO;
        
        self.bg2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _bg2View.backgroundColor = [UIColor whiteColor];
        [self.timeView addSubview:_bg2View];
        NSArray *typrArr = @[@"",@"",@""];
        
        for (int i = 0; i < typrArr.count; i++) {
            
            int count = 50*i;
            
            self.wechat2Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, count, (SCREEN_WIDTH-2)/3, 50)];
            [self.wechat2Btn setTitleColor:ALLTextColor forState:UIControlStateNormal];
            [self.wechat2Btn setTitle:typrArr[i] forState:UIControlStateNormal];
            self.wechat2Btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [self.wechat2Btn addTarget:self action:@selector(wechatBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.bg2View addSubview:_wechat2Btn];
            
            self.alipay2Btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-2)/3, count, (SCREEN_WIDTH-2)*2/3, 50)];
            [self.alipay2Btn addTarget:self action:@selector(wechatBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.alipay2Btn.backgroundColor = [UIColor whiteColor];
            [self.bg1View addSubview:_alipay2Btn];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+count, SCREEN_WIDTH, 1)];
            lab.backgroundColor = ALLBGColor;
            [_timeView addSubview:lab];
            
        }
        self.typeBOOL2 = YES;
        self.downImgView2.image = [UIImage imageNamed:@"up"];
        
    }else{
        
        self.timeView.hidden = YES;
        self.typeBOOL2 = NO;
        self.downImgView2.image = [UIImage imageNamed:@"down"];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _serialNumArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    OrderDetailViewController *odvc = [[OrderDetailViewController alloc]init];
    
    odvc.trxNoStr = _trxNoArr[indexPath.row];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:odvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fby"];
    
    if (cell == nil) {
        cell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fby"];
    }

    cell.serialNumLab.text = _serialNumArr[indexPath.row];
    
    if ([_nameArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"2002"]]) {
        cell.nameLab.text = @"支付宝";
    }else if ([_nameArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"2001"]]) {
        cell.nameLab.text = @"微信";
    }else if ([_nameArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"0002"]]) {
        cell.nameLab.text = @"银联";
    }else if ([_nameArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"3001"]]) {
        cell.nameLab.text = @"快捷支付";
    }
    cell.moneyLab.text = [NSString stringWithFormat:@"%@元",_moneyArr[indexPath.row]];;
    cell.timeLab.text = [NSString stringWithFormat:@"下单时间：%@",_timeArr[indexPath.row]];
    
    if ([_statusArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"1"]]) {
        cell.reminderLab.hidden = YES;
    }else if ([_statusArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"8"]]) {
        cell.reminderLab.text = @"已退款";
        cell.reminderLab.hidden = NO;
    }else if ([_statusArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"5"]]) {
        cell.reminderLab.text = @"退款处理中";
        cell.reminderLab.hidden = NO;
    }else if ([_statusArr[indexPath.row] isEqualToString:[NSString stringWithFormat:@"7"]]) {
        cell.reminderLab.text = @"部分退款";
        cell.reminderLab.hidden = NO;
    }else {
        cell.reminderLab.text = @"未知";
        cell.reminderLab.hidden = NO;
    }

    return cell;
}

@end
