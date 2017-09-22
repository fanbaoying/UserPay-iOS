//
//  MyCardTableViewCell.m
//  testSDK
//
//  Created by 范保莹 on 2017/7/26.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "MyCardTableViewCell.h"

@implementation MyCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.myView = [[UIView alloc]init];
        
        self.cardName = [[UILabel alloc]init];
        self.cardName.font = [UIFont systemFontOfSize:16.0];
//        self.cardName.textAlignment = NSTextAlignmentLeft;
        self.cardName.textColor = ALLTextColor;
        
        self.cardStyle = [[UILabel alloc]init];
        self.cardStyle.font = [UIFont systemFontOfSize:14.0];
//        self.cardStyle.textAlignment = NSTextAlignmentLeft;
        self.cardStyle.textColor = ALLTextColor;
        
        self.cardNum = [[UILabel alloc]init];
//        self.cardNum.font = [UIFont systemFontOfSize:14.0];
//        self.cardNum.textAlignment = NSTextAlignmentLeft;
        self.cardNum.textColor = ALLTextColor;
        
        
        [self.myView addSubview:_cardNum];
        [self.myView addSubview:_cardStyle];
        [self.myView addSubview:_cardName];
        
        [self.contentView addSubview:_myView];
        
    }
    
    return self;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 85);
    
    self.cardName.frame = CGRectMake(15, 5, SCREEN_WIDTH, 20);
    self.cardStyle.frame = CGRectMake(15, 30, SCREEN_WIDTH, 20);
    self.cardNum.frame = CGRectMake(15, 60, SCREEN_WIDTH, 20);
    
}


@end
