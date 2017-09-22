//
//  ThirdTableViewCell.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/16.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.myView = [[UIView alloc]init];
        
        self.myImg = [[UIImageView alloc]init];
        self.myImg.layer.cornerRadius = 17;
        self.myImg.clipsToBounds = YES;
        self.myImg.backgroundColor = [UIColor whiteColor];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
        
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_myImg];
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    
    self.myImg.frame = CGRectMake(15, 13, 34, 34);
    self.titleLab.frame = CGRectMake(55, 15, SCREEN_WIDTH/2, 30);
    
}

@end
