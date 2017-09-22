//
//  FourthViewController.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/11.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "FourthViewController.h"
#import "FourthTableViewCell.h"

#import "MyWalletViewController.h"
#import "MyMoneyCardViewController.h"

@interface FourthViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *myTableView;
@property(strong,nonatomic)NSArray *titleImgArr;
@property(strong,nonatomic)NSArray *contentArr;

@property(strong,nonatomic)UIImageView *headerImgView;
@property(strong,nonatomic)UIButton *headerBtn;
@property(strong,nonatomic)UILabel *nameLab;
@property(strong,nonatomic)UILabel *numberLab;



@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self head];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-249)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    //    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    
    self.titleImgArr = @[@[@"银行卡",@"服务"],@[@"推荐",@"客服"],@[@"设置"]];
    self.contentArr = @[@[@"我的钱包",@"我的卡券"],@[@"推荐好友",@"联系客服"],@[@"设置"]];
    
    UIView *foodView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    foodView.backgroundColor = ALLBGColor;
    self.myTableView.tableFooterView = foodView;
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lab3.backgroundColor = ALLText2Color;
    [foodView addSubview:lab3];
    
}

- (void)head {

    self.headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.headerImgView.image = [UIImage imageNamed:@"bgImg"];
    [self.view addSubview:_headerImgView];
    
    self.headerBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, 50, 50, 50)];
    [self.headerBtn setImage:[UIImage imageNamed:@"head"] forState:0];
    [self.view addSubview:_headerBtn];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 120, SCREEN_WIDTH/2, 30)];
    self.nameLab.text = @"FBY展菲";
    self.nameLab.textColor = [UIColor whiteColor];
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_nameLab];
    
    self.numberLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 150, SCREEN_WIDTH*3/5, 30)];
    self.numberLab.text = @"账号:183****8181";
    self.numberLab.textColor = [UIColor whiteColor];
    self.numberLab.font = [UIFont systemFontOfSize:15.0];
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_numberLab];
    
}

//cell的分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
    
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyWalletViewController *mwvc = [[MyWalletViewController alloc]init];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:mwvc animated:YES];
        }else if (indexPath.row == 1) {
        
            MyMoneyCardViewController *mcvc = [[MyMoneyCardViewController alloc]init];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:mcvc animated:YES];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FourthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[FourthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
    cell.titleImage.image = [UIImage imageNamed:_titleImgArr[indexPath.section][indexPath.row]];
    cell.titleLab.text = _contentArr[indexPath.section][indexPath.row];
    
    return cell;
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    header.backgroundColor = ALLBGColor;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lab1.backgroundColor = ALLText2Color;
    [header addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 9, SCREEN_WIDTH, 1)];
    lab2.backgroundColor = ALLText2Color;
    [header addSubview:lab2];
   
    return header;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
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
