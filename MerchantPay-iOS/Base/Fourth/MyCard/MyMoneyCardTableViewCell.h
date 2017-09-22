//
//  MyMoneyCardTableViewCell.h
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/16.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMoneyCardTableViewCell : UITableViewCell
@property(strong,nonatomic)UIView *myView;

@property(strong,nonatomic)UILabel *moneyImg;
@property(strong,nonatomic)UILabel *moneyLab;
@property(strong,nonatomic)UILabel *moneyUserLab;

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *contentLab;
@property(strong,nonatomic)UILabel *phoneNumberLab;

@property(strong,nonatomic)UILabel *reminderLab;
@property(strong,nonatomic)UIButton *userLab;

@property(strong,nonatomic)UILabel *typeLab;
@end
