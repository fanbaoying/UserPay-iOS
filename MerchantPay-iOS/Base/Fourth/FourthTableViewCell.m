//
//  FourthTableViewCell.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/11.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "FourthTableViewCell.h"

@implementation FourthTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.myView = [[UIView alloc]init];
        
        self.titleImage = [[UIImageView alloc]init];
        self.titleImage.backgroundColor = [UIColor whiteColor];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.titleLab.textColor = ALLTextColor;
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
        
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_titleImage];
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 45);
    
    self.titleImage.frame = CGRectMake(15, 10, 25, 25);
    self.titleLab.frame = CGRectMake(50, 10, SCREEN_WIDTH/2, 25);
    
}

@end
