//
//  MyCardViewController.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/25.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "MyCardViewController.h"
#import "agreeFirstNav.h"

#import "MyCardTableViewCell.h"

#import "BankCardViewController.h"

#import "FMDB.h"

#import "PayPasswordViewController.h"

@interface MyCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *myTableView;

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UIButton *okBtn;

@property(strong,nonatomic)UIView *baseView;

@property(nonatomic,strong)FMDatabase *db;

@property(strong,nonatomic)NSMutableArray *bankStrArr;

@property(strong,nonatomic)NSMutableArray *bankTypeArr;

@property(strong,nonatomic)NSMutableArray *cardStrArr;

@property(strong,nonatomic)NSMutableArray *passwordArr;

@end

@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT-65)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
//    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"我的银行卡" andWithRightBtn:@"删除" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.bankStrArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.bankTypeArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.cardStrArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.passwordArr = [[NSMutableArray alloc]initWithCapacity:0];
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
    
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([db open]) {
        
    }
    self.db=db;
    
    // 1.执行查询语句
    FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_agreeOrder"];
    
    // 2.遍历结果
    while ([resultSet next]) {
        
        NSString *bankStr = [resultSet stringForColumn:@"bankStr"];
        [self.bankStrArr addObject:bankStr];
        NSLog(@"%@",_bankStrArr);
        NSString *bankType = [resultSet stringForColumn:@"bankType"];
        [self.bankTypeArr addObject:bankType];
        NSString *cardStr = [resultSet stringForColumn:@"cardStr"];
        [self.cardStrArr addObject:cardStr];
        NSString *password = [resultSet stringForColumn:@"password"];
        [self.passwordArr addObject:password];
        
    }
    
    [self.myTableView reloadData];
    
}

- (void)leftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)rightBtn:(UIButton *)sender{
//    
//    [self deleteData];
//}

// 删除数据
- (void)deleteData {
    NSLog(@"%s", __func__);
    
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString *sql = @"delete from t_agreeOrder";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [db close];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _bankStrArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PayPasswordViewController *ppvc = [[PayPasswordViewController alloc]init];
    ppvc.passwordStr = _passwordArr[indexPath.row];
    [self.navigationController pushViewController:ppvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fby"];
    
    if (cell == nil) {
        cell = [[MyCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fby"];
    }
    
    cell.cardName.text = _bankStrArr[indexPath.row];
    cell.cardStyle.text = _bankTypeArr[indexPath.row];
    
    NSString *cardNumber = _cardStrArr[indexPath.row];
    
    cell.cardNum.text = [NSString stringWithFormat:@"**** **** **** %@",[cardNumber substringFromIndex:cardNumber.length-4]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _baseView.backgroundColor = ALLBGColor;
    
    self.okBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, SCREEN_WIDTH-30, 60)];
    self.okBtn.backgroundColor = ALLBtnColor;
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [_baseView addSubview:_okBtn];
    
    return _baseView;
    
}

- (void)okBtn:(UIButton *)sender {

    BankCardViewController *bcvc = [[BankCardViewController alloc]init];
    
    [self.navigationController pushViewController:bcvc animated:YES];
    
}

@end
