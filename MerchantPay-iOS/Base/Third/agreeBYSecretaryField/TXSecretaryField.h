//
//  TXSecretaryField.h
//  doubao
//
//  Created by 范保莹 on 2017/2/3.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TXSecretaryField;

@protocol TXSecretaryFieldDelegate <NSObject>
-(void)sectetaryDidFinishedInput:(TXSecretaryField *)secField;
@end


@interface TXSecretaryField : UITextField

@property(nonatomic,weak) id<TXSecretaryFieldDelegate> secretaryDelegate;

@end
