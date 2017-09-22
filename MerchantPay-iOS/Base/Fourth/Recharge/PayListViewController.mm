//
//  PayListViewController.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/20.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "PayListViewController.h"
#import "agreeFirstNav.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "PayListTableViewCell.h"

#import "MJExtension.h"
#import "PayListModel.h"

#import "paySucceedViewController.h"
#import "payFailureViewController.h"

#import "AgreePay.h"
//#import "UPPayPluginDelegate.h"

@interface PayListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)NSArray *dataArr;

@property (strong,nonatomic) NSMutableArray *sourceArr;

@property(strong,nonatomic)NSArray *titleArr;
@property(strong,nonatomic)NSArray *payImgArr;

@property(strong,nonatomic)UIView *headView;
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIButton *moneyBtn;
@property(strong,nonatomic)UIButton *money1Btn;
@property(strong,nonatomic)UIButton *money2Btn;
@property(strong,nonatomic)UIButton *money3Btn;

@property(strong,nonatomic)UIButton *foodBtn;

@property(strong,nonatomic)NSString *numString;

@property(assign,nonatomic)int orderNum;

@property(assign,nonatomic)BOOL moneyBtnBool;

@property(strong,nonatomic)NSString *moneyStr;

@end

@implementation PayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.moneyStr = @"100";
    self.numString = @"0";
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65 + SCREEN_HEIGHT/3, SCREEN_WIDTH, 300)];
    
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    UIView *foodView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
    
    self.myTableView.tableFooterView = foodView;

    if (!_sourceArr) {
        _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
        
        //假设数据
        NSArray *souArr = @[
                            @{@"img":@"weixin",
                              @"name":@"微信支付"
                              },
                            @{@"img":@"zhifubao",
                              @"name":@"支付宝"
                              },
                            @{@"img":@"yinlian",
                              @"name":@"中国银联"
                              }
                            
                            ];
        for (NSDictionary *dic in souArr){
            
            PayListModel *model = [PayListModel mj_objectWithKeyValues:dic];
            [_sourceArr addObject:model];
        }
    }
    
    for (int i=0; i<self.sourceArr.count; i++) {
        PayListModel *model = self.sourceArr[i];
        if (i == 0) {
            model.isAccept = YES;
        }else{
            model.isAccept = NO;
        }
        
    }
    
    [self head];
    
    self.foodBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT-100, SCREEN_WIDTH-30, 50)];
    [self.foodBtn setTitle:[NSString stringWithFormat:@"立即充值"] forState:0];
    self.foodBtn.backgroundColor = ALLRedBtnColor;
    self.foodBtn.layer.cornerRadius = 5.0;
    self.foodBtn.clipsToBounds = YES;
    [self.foodBtn addTarget:self action:@selector(foodBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.foodBtn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_foodBtn];
    
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"充值" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:200/255.0 green:102/255.0 blue:105/255.0 alpha:1];
}


//确认支付按钮点击事件
- (void)foodBtn:(UIButton *)sender{
    
    self.foodBtn.backgroundColor = [UIColor colorWithRed:213/255.0 green:122/255.0 blue:115/255.0 alpha:1];
    
//    if ([_numString isEqualToString:[NSString stringWithFormat:@"0"]]) {
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
        mutdic1[@"productName"] = [NSString stringWithFormat:@"充值-%@",DateTime];
        NSLog(@"%@",_moneyStr);
    
        int amount = [_moneyStr doubleValue]*100;
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
        
        if ([_numString isEqualToString:[NSString stringWithFormat:@"0"]]) {
            NSString *payChannel = @"WEIXIN";
            if ([payChannel isEqualToString:[NSString stringWithFormat:@"WEIXIN"]]) {
                mutdic1[@"payChannel"] = payChannel;
            }else{
                NSLog(@"微信支付标号为大写WEIXIN");
            }
        }else if ([_numString isEqualToString:[NSString stringWithFormat:@"1"]]) {
            NSString *payChannel = @"ALI";
            if ([payChannel isEqualToString:[NSString stringWithFormat:@"ALI"]]) {
                mutdic1[@"payChannel"] = payChannel;
            }else{
                NSLog(@"支付宝支付标号为大写ALI");
            }
        }else if ([_numString isEqualToString:[NSString stringWithFormat:@"2"]]) {
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
        [service searchMessage:nil andWithAction:nil andWithDic:mutdic1 andUrl:WechatPay andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            
            NSLog(@"%@",[dic objectForKey:@"message"]);
            
            NSString *str = [dic objectForKey:@"respCode"];
            
            int intString = [str intValue];
            
            if (intString == 000000) {
                
                NSUserDefaults *money1 = [NSUserDefaults standardUserDefaults];
                [money1 setObject:_moneyStr forKey:@"moneyid1"];
                [money1 synchronize];
                
                NSDictionary *dataDic = [dic objectForKey:@"result"];
                
                if ([dataDic isEqual:[NSNull null]]) {
                    
                }else{
                    if ([_numString isEqualToString:[NSString stringWithFormat:@"0"]]) {
                        NSDictionary *dataDic1 = [dataDic objectForKey:@"credential"];
                        [AgreePay payOrder:dataDic appURLScheme:[dataDic1 objectForKey:@"appid"] withCompletion:^(NSString *agreeResult) {
//                            如果没有安装微信，会返回“没有安装微信app”
                            NSLog(@"%@",agreeResult);
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:agreeResult preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                            }];
                            [alert addAction:action1];
                            [self presentViewController:alert animated:YES completion:nil];
                        }];
                    }else if ([_numString isEqualToString:[NSString stringWithFormat:@"1"]]) {
                        [AgreePay payOrder:dataDic appURLScheme:@"agreeAlipay2" withCompletion:^(NSString *agreeResult) {
                            
                            NSLog(@"%@",agreeResult);
                        }];
                    }else if ([_numString isEqualToString:[NSString stringWithFormat:@"2"]]) {
                        PayListViewController * __weak weakSelf = self;
                        [AgreePay payOrder:dataDic viewController:weakSelf appURLScheme:@"agreeUPPay2" appmodel:@"01" withCompletion:^(NSString *agreeResult) {
                            
                        }];                    }
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

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)head{

    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/2, 35)];
    self.titleLab.font = [UIFont systemFontOfSize:15.0];
    self.titleLab.text = @"充值金额";
    self.titleLab.textColor = ALLTextColor;
    [self.headView addSubview:_titleLab];
    
    NSArray *dataArr = @[@"充100元",@"充50元",@"充20元",@"充0.01元"];
    
    for (int i = 0; i < dataArr.count; i ++) {
        
        if (i < 2) {
            int count = ((SCREEN_WIDTH-45)/2+15)*i;
            
            if (i == 0) {
                self.moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(15+count, 40, (SCREEN_WIDTH-45)/2, SCREEN_WIDTH/5)];
                self.moneyBtn.backgroundColor = ALLText2Color;
                [self.moneyBtn setTitle:dataArr[i] forState:0];
                [self.moneyBtn setTitleColor:[UIColor blackColor] forState:0];
                self.moneyBtn.tag = 6000+i;
                self.moneyBtn.layer.borderWidth = 1.0;
                self.moneyBtn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
                self.moneyBtn.layer.cornerRadius = 5.0;
                self.moneyBtn.clipsToBounds = YES;
                [self.moneyBtn addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
                [self.headView addSubview:_moneyBtn];
            }else{
                self.money1Btn = [[UIButton alloc]initWithFrame:CGRectMake(15+count, 40, (SCREEN_WIDTH-45)/2, SCREEN_WIDTH/5)];
                [self.money1Btn setTitle:dataArr[i] forState:0];
                [self.money1Btn setTitleColor:[UIColor blackColor] forState:0];
                self.money1Btn.tag = 6000+i;
                self.money1Btn.layer.borderWidth = 1.0;
                self.money1Btn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
                self.money1Btn.layer.cornerRadius = 5.0;
                self.money1Btn.clipsToBounds = YES;
                [self.money1Btn addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
                [self.headView addSubview:_money1Btn];
            }
        }else if (i >=2 && i < 4) {
        
            int count1 = ((SCREEN_WIDTH-45)/2+15)*(i-2);
            if (i == 2) {
                self.money2Btn = [[UIButton alloc]initWithFrame:CGRectMake(15+count1, SCREEN_WIDTH/5 + 55, (SCREEN_WIDTH-45)/2, SCREEN_WIDTH/5)];
                [self.money2Btn setTitle:dataArr[i] forState:0];
                [self.money2Btn setTitleColor:[UIColor blackColor] forState:0];
                self.money2Btn.tag = 6000+i;
                self.money2Btn.layer.borderWidth = 1.0;
                self.money2Btn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
                self.money2Btn.layer.cornerRadius = 5.0;
                self.money2Btn.clipsToBounds = YES;
                [self.money2Btn addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
                [self.headView addSubview:_money2Btn];
            }else{
                self.money3Btn = [[UIButton alloc]initWithFrame:CGRectMake(15+count1, SCREEN_WIDTH/5 + 55, (SCREEN_WIDTH-45)/2, SCREEN_WIDTH/5)];
                [self.money3Btn setTitle:dataArr[i] forState:0];
                [self.money3Btn setTitleColor:[UIColor blackColor] forState:0];
                self.money3Btn.tag = 6000+i;
                self.money3Btn.layer.borderWidth = 1.0;
                self.money3Btn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1].CGColor;
                self.money3Btn.layer.cornerRadius = 5.0;
                self.money3Btn.clipsToBounds = YES;
                [self.money3Btn addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
                [self.headView addSubview:_money3Btn];
            }
            
        }
    }
    
}
- (void)recharge:(UIButton *)sender {
    if (sender.tag == 6000) {
        self.moneyBtn.backgroundColor = ALLText2Color;
        self.money1Btn.backgroundColor = [UIColor whiteColor];
        self.money2Btn.backgroundColor = [UIColor whiteColor];
        self.money3Btn.backgroundColor = [UIColor whiteColor];
        self.moneyStr = @"100";
    }else if (sender.tag == 6001){
        self.moneyBtn.backgroundColor = [UIColor whiteColor];
        self.money1Btn.backgroundColor = ALLText2Color;
        self.money2Btn.backgroundColor = [UIColor whiteColor];
        self.money3Btn.backgroundColor = [UIColor whiteColor];
        self.moneyStr = @"50";
    }else if (sender.tag == 6002){
        self.moneyBtn.backgroundColor = [UIColor whiteColor];
        self.money1Btn.backgroundColor = [UIColor whiteColor];
        self.money2Btn.backgroundColor = ALLText2Color;
        self.money3Btn.backgroundColor = [UIColor whiteColor];
        self.moneyStr = @"20";
    }else if (sender.tag == 6003){
        self.moneyBtn.backgroundColor = [UIColor whiteColor];
        self.money1Btn.backgroundColor = [UIColor whiteColor];
        self.money2Btn.backgroundColor = [UIColor whiteColor];
        self.money3Btn.backgroundColor = ALLText2Color;
        self.moneyStr = @"0.01";
    }
    
}

//cell的分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
    
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 52;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i=0; i<self.sourceArr.count; i++) {
        PayListModel *model = self.sourceArr[i];
        if (indexPath.row ==i) {
            model.isAccept = YES;
        }else{
            model.isAccept = NO;
        }
    }
    
    [self.myTableView reloadData];
    
    self.numString = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    if (indexPath.row == 0){
        
    }else if (indexPath.row == 1){

    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    PayListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[PayListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    PayListModel *model = self.sourceArr[indexPath.row];
    
    cell.model = model;
    
    cell.accept = ^(BOOL isAccept){
        
        [weakSelf updateIndexPathRowStatusSelected:isAccept section:indexPath];
        
    };
    
    return cell;
}

//跟新确认键 //全选中改变状态

- (void)updateIndexPathRowStatusSelected:(BOOL)isSelected section:(NSIndexPath *)indexPath{
    
    for (int i=0; i<self.sourceArr.count; i++) {
        PayListModel *model = self.sourceArr[i];
        if (indexPath.row ==i) {
            model.isAccept = isSelected;
        }else{
            model.isAccept = NO;
        }
    }
    
    [self.myTableView reloadData];
    
    self.numString = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    header.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 20)];
    titleLab.text = @"选择支付方式";
    titleLab.textColor = ALLTextColor;
    titleLab.font = [UIFont systemFontOfSize:14.0];
    [header addSubview:titleLab];
    
    
    return header;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    NSLog(@"6666");
    
}
@end
