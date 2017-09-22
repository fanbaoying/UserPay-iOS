//
//  SecondTableViewCell.m
//  agreePay
//
//  Created by 范保莹 on 2017/6/6.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "UILabel+LabelHeightAndWidth.h"

@implementation SecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myView = [[UIView alloc]init];
        
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.font = [UIFont systemFontOfSize:12.0];
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        self.nameLab.textColor = ALLText3Color;
        
        self.serialNumLab = [[UILabel alloc]init];
        self.serialNumLab.font = [UIFont systemFontOfSize:16.0];
        self.serialNumLab.textAlignment = NSTextAlignmentLeft;
        self.serialNumLab.textColor = ALLTextColor;
        
        self.lab1 = [[UILabel alloc]init];
        self.lab1.backgroundColor = ALLBGColor;
        
        self.lab2 = [[UILabel alloc]init];
        self.lab2.backgroundColor = ALLBGColor;
        
        self.moneyLab = [[UILabel alloc]init];
        self.moneyLab.font = [UIFont systemFontOfSize:12.0];
        self.moneyLab.textAlignment = NSTextAlignmentLeft;
        self.moneyLab.textColor = [UIColor colorWithRed:236/255.0 green:90/255.0 blue:43/255.0 alpha:1];
        
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.font = [UIFont systemFontOfSize:12.0];
        self.timeLab.textAlignment = NSTextAlignmentLeft;
        self.timeLab.textColor = ALLText3Color;
        
        self.reminderLab = [[UILabel alloc]init];
        self.reminderLab.font = [UIFont systemFontOfSize:12.0];
        self.reminderLab.textAlignment = NSTextAlignmentCenter;
        self.reminderLab.layer.cornerRadius = 3;
        self.reminderLab.clipsToBounds = YES;
        self.reminderLab.textColor = [UIColor whiteColor];
//        self.reminderLab.text = @"已退款";
        self.reminderLab.backgroundColor = [UIColor lightGrayColor];
        
        [self.myView addSubview:_nameLab];
        [self.myView addSubview:_moneyLab];
        [self.myView addSubview:_lab1];
        [self.myView addSubview:_timeLab];
        [self.myView addSubview:_serialNumLab];
        [self.myView addSubview:_reminderLab];
        [self.myView addSubview:_lab2];
        
        [self.contentView addSubview:_myView];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    
//    self.serialNumLab.frame = CGRectMake(12, 2, SCREEN_WIDTH*2/3, 30);
    CGFloat width = [UILabel getWidthWithTitle:self.serialNumLab.text font:self.serialNumLab.font];
    self.serialNumLab.frame = CGRectMake(12, 2, width, 30);
    CGFloat width3 = [UILabel getWidthWithTitle:self.reminderLab.text font:self.reminderLab.font];
    self.reminderLab.frame = CGRectMake(width+20, 10, width3+4, 15);
    
    CGFloat width1 = [UILabel getWidthWithTitle:self.nameLab.text font:self.nameLab.font];
    self.nameLab.frame = CGRectMake(12, 30, width1, 20);
    self.lab1.frame = CGRectMake(17+width1, 30, 1, 20);
    
    CGFloat width2 = [UILabel getWidthWithTitle:self.moneyLab.text font:self.moneyLab.font];
    self.moneyLab.frame = CGRectMake(23+width1, 30, width2, 20);
    self.timeLab.frame = CGRectMake(12, 50, SCREEN_WIDTH*2/3, 20);
    
    self.lab2.frame = CGRectMake(0, 69, SCREEN_WIDTH, 1);
    
}

@end
