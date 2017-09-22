//
//  PayListModel.h
//  agreePay
//
//  Created by 范保莹 on 2017/4/21.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayListModel : NSObject

@property (copy,nonatomic) NSString *img ; //标题

@property (copy,nonatomic) NSString *name; //内容

@property (assign,nonatomic) BOOL isAccept ; //是否接受

@end
