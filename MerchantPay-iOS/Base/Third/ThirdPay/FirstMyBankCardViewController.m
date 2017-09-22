//
//  FirstMyBankCardViewController.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/27.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "FirstMyBankCardViewController.h"

#import "agreeFirstNav.h"

#import "MyCardTableViewCell.h"

#import "BankCardViewController.h"

#import "FMDB.h"

#import "PayPasswordViewController.h"

@interface FirstMyBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation FirstMyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 1)];
    myLab.backgroundColor = ALLText1Color;
    [self.view addSubview:myLab];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT/2-65)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    //    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    self.baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    _baseView.backgroundColor = ALLBGColor;
    
    self.okBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 60)];
    self.okBtn.backgroundColor = ALLBtnColor;
    [self.okBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [_baseView addSubview:_okBtn];
    
    self.myTableView.tableFooterView = _baseView;
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"我的银行卡" andWithRightBtn:@"删除" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
//    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
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

//- (void)leftBtn:(UIButton *)sender{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

//- (void)rightBtn:(UIButton *)sender{
//
//    [self deleteData];
//}

// 删除所有数据
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

// 删除某一条数据数据
- (void)deleteOneData:(NSString *)cardStr {
    NSLog(@"%s", __func__);
    
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"agree.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString *sql = [NSString stringWithFormat:@"delete from t_agreeOrder where cardStr = %@",cardStr];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PayPasswordViewController *ppvc = [[PayPasswordViewController alloc]init];
    ppvc.passwordStr = _passwordArr[indexPath.row];
    ppvc.moneyAmount = _moneyStr;
    [self.navigationController pushViewController:ppvc animated:YES];
    
}

/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_cardStrArr[indexPath.row]);
    [self deleteOneData:_cardStrArr[indexPath.row]];
    
    // 删除模型
    [self.bankStrArr removeObjectAtIndex:indexPath.row];
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    
//    
//    return _baseView;
//    
//}

- (void)okBtn:(UIButton *)sender {
    
    BankCardViewController *bcvc = [[BankCardViewController alloc]init];
    
    [self.navigationController pushViewController:bcvc animated:YES];
    
}
@end
