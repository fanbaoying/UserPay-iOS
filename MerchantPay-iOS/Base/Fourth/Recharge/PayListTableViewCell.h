//
//  PayListTableViewCell.h
//  agreePay
//
//  Created by 范保莹 on 2017/4/20.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayListModel.h"

typedef void (^acceptBlock)(BOOL isAccept);

@interface PayListTableViewCell : UITableViewCell

@property (strong,nonatomic) PayListModel *model;
@property (copy,nonatomic) acceptBlock accept;

@property(strong,nonatomic)UIView *myView;

@property(strong,nonatomic)UIImageView *myImg;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UIButton *chooseBtn;



@end
