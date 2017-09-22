//
//  MyMoneyCardTableViewCell.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/16.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "MyMoneyCardTableViewCell.h"

@implementation MyMoneyCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myView = [[UIView alloc]init];
        self.myView.layer.borderWidth = 1.0;
        self.myView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1].CGColor;
        
        self.moneyImg = [[UILabel alloc]init];
        self.moneyImg.font = [UIFont systemFontOfSize:14.0];
        self.moneyImg.textColor = ALLRedBtnColor;
        
        self.moneyLab = [[UILabel alloc]init];
        self.moneyLab.font = [UIFont systemFontOfSize:25.0];
        self.moneyLab.textAlignment = NSTextAlignmentCenter;
        self.moneyLab.textColor = ALLRedBtnColor;
        
        self.moneyUserLab = [[UILabel alloc]init];
        self.moneyUserLab.font = [UIFont systemFontOfSize:12.0];
        self.moneyUserLab.textAlignment = NSTextAlignmentCenter;
        self.moneyUserLab.textColor = ALLTextColor;
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:12.0];
        self.contentLab.textColor = ALLTextColor;
        
        self.phoneNumberLab = [[UILabel alloc]init];
        self.phoneNumberLab.font = [UIFont systemFontOfSize:12.0];
        self.phoneNumberLab.textColor = ALLTextColor;
        
        self.reminderLab = [[UILabel alloc]init];
        self.reminderLab.font = [UIFont systemFontOfSize:14.0];
        self.reminderLab.textColor = ALLRedBtnColor;
        
        
        self.typeLab = [[UILabel alloc]init];
        self.typeLab.font = [UIFont systemFontOfSize:10.0];
        self.typeLab.textColor = ALLTextColor;
        
        [self.myView addSubview:_typeLab];
        
        [self.myView addSubview:_reminderLab];
        
        [self.myView addSubview:_contentLab];
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_phoneNumberLab];
        
        [self.myView addSubview:_moneyUserLab];
        [self.myView addSubview:_moneyLab];
        //        [self.myView addSubview:_moneyImg];
        
        [self.contentView addSubview:_myView];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 125);
    
    self.moneyLab.frame = CGRectMake(0, 25, SCREEN_WIDTH/3, 20);
    self.moneyUserLab.frame = CGRectMake(15, 45, SCREEN_WIDTH/4, 20);
    
    self.titleLab.frame = CGRectMake(SCREEN_WIDTH/3, 20, SCREEN_WIDTH/2, 25);
    self.contentLab.frame = CGRectMake(SCREEN_WIDTH/3, 45, SCREEN_WIDTH/2, 20);
    self.phoneNumberLab.frame = CGRectMake(SCREEN_WIDTH/3, 65, SCREEN_WIDTH/2+40, 20);
    
    self.reminderLab.frame = CGRectMake(SCREEN_WIDTH-70, 30, 50, 20);
    
    self.typeLab.frame = CGRectMake(15, 95, SCREEN_WIDTH/2, 25);
    
}

@end
