//
//  paySucceedViewController.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/21.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "paySucceedViewController.h"
#import "payFirstNav.h"

//#import "FMDB.h"

@interface paySucceedViewController ()

@property(strong,nonatomic)payFirstNav *nav;

@property(strong,nonatomic)UIView *headView1;
@property(strong,nonatomic)UIImageView *myImg;
@property(strong,nonatomic)UILabel *titleLab;


@property(strong,nonatomic)UIView *headView2;
@property(strong,nonatomic)UILabel *titleReminderLab;
@property(strong,nonatomic)UILabel *reminderLab;

//@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSString *amount;
@property(strong,nonatomic)NSString *productName;
@property(strong,nonatomic)NSString *trxNo;
@property(strong,nonatomic)NSString *orderTime;

@end

@implementation paySucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    

    [self head];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 306, SCREEN_WIDTH, SCREEN_HEIGHT-306)];
    myView.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:myView];
    
    self.nav = [[payFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"支付订单" andWithRightBtn:@"完成" andWithBgImg:nil];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSUserDefaults *order = [NSUserDefaults standardUserDefaults];
    NSDictionary *succeedOrder = [order objectForKey:@"orderId"];
    
    NSLog(@"%@",succeedOrder);
    _amount = [succeedOrder objectForKey:@"amount"];
    _productName = [succeedOrder objectForKey:@"productName"];
    _trxNo = [succeedOrder objectForKey:@"trxNo"];
    _orderTime = [succeedOrder objectForKey:@"orderTime"];
    
//    //1.获得数据库文件的路径
//  NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//   NSString *fileName=[doc stringByAppendingPathComponent:@"student.sqlite"];
//
//  //2.获得数据库
//   FMDatabase *db=[FMDatabase databaseWithPath:fileName];
//
//   //3.打开数据库
//    if ([db open]) {
//        //4.创表
////        allOrder[@"trxNo"] = TrxNo;
////        allOrder[@"amount"] = monsyStr;
////        allOrder[@"productName"] = @"test";
////        allOrder[@"orderTime"] = DateTime1;
//        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_agreeOrder (id integer PRIMARY KEY AUTOINCREMENT, trxNo text NOT NULL, amount text NOT NULL, productName text NOT NULL, orderTime text NOT NULL);"];
//        
//        if (result){
//                    NSLog(@"创表成功");
//                    }else{
//                           NSLog(@"创表失败");
//                    }
//        }
//        self.db=db;
//    
//        [self insert];

    
//    [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
//    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
//    
}

//插入数据
//-(void)insert{
//    BOOL res = [self.db executeUpdate:@"INSERT INTO t_agreeOrder (trxNo, amount, productName, orderTime) VALUES (?, ?, ?, ?);", _trxNo, _amount, _productName, _orderTime];
//    
//    if (!res) {
//        NSLog(@"增加数据失败");
//    }else{
//        NSLog(@"增加数据成功");
//    }
//}


- (void)rightBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)head{

    self.headView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 137)];
    [self.view addSubview:_headView1];
    
    self.myImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 25, 60, 60)];
    self.myImg.image = [UIImage imageNamed:@"succeed"];
    [self.headView1 addSubview:_myImg];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 85, SCREEN_WIDTH/2, 35)];
    self.titleLab.text = @"恭喜你，支付成功";
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = [UIFont systemFontOfSize:18.0];
    self.titleLab.textColor = ALLTextColor;
    [self.headView1 addSubview:_titleLab];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 136.5, SCREEN_WIDTH-20, 1)];
    lab.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    [_headView1 addSubview:lab];
    
    self.headView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 201, SCREEN_WIDTH, 105)];
    [self.view addSubview:_headView2];
    
    self.titleReminderLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 35)];
    self.titleReminderLab.text = @"温馨提示";
    self.titleReminderLab.textAlignment = NSTextAlignmentLeft;
    self.titleReminderLab.font = [UIFont systemFontOfSize:16.0];
    self.titleReminderLab.textColor = ALLTextColor;
    [self.headView2 addSubview:_titleReminderLab];
    
    self.reminderLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, SCREEN_WIDTH-20, 50)];
    self.reminderLab.text = @"您已成功支付该订单，请您根据对应窗口，对应号码去取药窗口领取您的药品。祝您早日康复！";
    self.reminderLab.numberOfLines = 0;
    self.reminderLab.textAlignment = NSTextAlignmentLeft;
    self.reminderLab.font = [UIFont systemFontOfSize:14.0];
    self.reminderLab.textColor = ALLTextColor;
    [self.headView2 addSubview:_reminderLab];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 136.5, SCREEN_WIDTH-20, 1)];
    lab1.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    [_headView2 addSubview:lab1];
    
}

@end
