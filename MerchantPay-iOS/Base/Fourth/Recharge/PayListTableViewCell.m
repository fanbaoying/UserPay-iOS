//
//  PayListTableViewCell.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/20.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "PayListTableViewCell.h"

@implementation PayListTableViewCell

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
        
        self.chooseBtn = [[UIButton alloc]init];
//        self.chooseBtn.layer.borderWidth = 1.0;
//        self.chooseBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.chooseBtn.layer.cornerRadius = 20.0;
        self.chooseBtn.clipsToBounds = YES;
        [self.chooseBtn setImage:[UIImage imageNamed:@"200"] forState:UIControlStateNormal];
        [self.chooseBtn setImage:[UIImage imageNamed:@"100"] forState:UIControlStateSelected];
        [self.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.myView addSubview:_chooseBtn];
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_myImg];
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)setModel:(PayListModel *)model{
    
    self.chooseBtn.selected = model.isAccept;
    
    self.myImg.image = [UIImage imageNamed:model.img];
    self.titleLab.text = model.name;

}

//选择按钮
- (void)chooseBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (_accept) {
        _accept(sender.selected);
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 52);

    self.myImg.frame = CGRectMake(10, 9, 34, 34);
    self.titleLab.frame = CGRectMake(52, 11, SCREEN_WIDTH/2, 30);
    self.chooseBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 6, 40, 40);
    
}

@end
