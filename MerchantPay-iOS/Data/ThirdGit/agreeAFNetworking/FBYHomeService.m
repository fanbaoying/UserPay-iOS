//
//  FBYHomeService.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/24.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "FBYHomeService.h"

#import "AFNetworking.h"

@implementation FBYHomeService
- (void)searchMessage:(NSString *)pageNum andWithAction:(NSString *)action andWithDic:(NSDictionary *)Alldic andUrl:(NSString *)url andSuccess:(void (^)(NSDictionary *))success andFailure:(void (^)(int))failure{

    

//    NSLog(@"%@----",Alldic);
    //1.创建ADHTTPSESSIONMANGER对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //2.设置该对象返回类型
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if([pageNum intValue] == 1){
        //调出请求头
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //将token封装入请求头
        
        [manager.requestSerializer setValue:@"6a6c41d0-4c96-4696-b542-61dc184da097" forHTTPHeaderField:@"token"];
        
        [manager POST:url parameters:Alldic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = responseObject;
            
            success(dic);
            
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //        NSLog(@"----返回错误");
            //                NSLog(@"网络请求返回错误信息%@",error);
            
        }];
        
    }else {
        
        NSString *urlstr= [NSString stringWithFormat:@"%@%@",AGREENewFuWuURL,url];
        
        [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"x-signature"];
        [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"x-timestamp"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager POST:urlstr parameters:Alldic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *dic = responseObject;
            
            success(dic);
            
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //        NSLog(@"----返回错误");
            //                NSLog(@"网络请求返回错误信息%@",error);
            
        }];
        
    }

    

}

@end
