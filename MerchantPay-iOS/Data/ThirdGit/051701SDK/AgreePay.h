//
//  AgreePay.h
//  telephone
//
//  Created by 范保莹 on 2017/5/16.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef void (^AgreeCompletion)(NSString *agreeResult);

@interface AgreePay : NSObject

+ (void)payOrder:(NSDictionary *)payData viewController:(UIViewController*)viewController appURLScheme:(NSString *)fromScheme appmodel:(NSString *)model withCompletion:(AgreeCompletion)completionBlock;

+ (void)payOrder:(NSDictionary *)payData appURLScheme:(NSString *)fromScheme withCompletion:(AgreeCompletion)completion;

+ (BOOL)AgreeOpenURL:(NSURL *)url withCompletion:(AgreeCompletion)completion;



@end
