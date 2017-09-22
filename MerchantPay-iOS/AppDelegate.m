//
//  AppDelegate.m
//  MerchantPay-iOS
//
//  Created by 范保莹 on 2017/8/11.
//  Copyright © 2017年 MerchantPay. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

#import "MoneyViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#import "AgreePay.h"

#import "MyWalletViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.tabBar = [[UITabBarController alloc]init];
    
    NSUserDefaults *money = [NSUserDefaults standardUserDefaults];
    [money setObject:@"0" forKey:@"moneyid"];
    [money synchronize];
    
    NSUserDefaults *money2 = [NSUserDefaults standardUserDefaults];
    [money2 setObject:@"0.00" forKey:@"money2id"];
    [money2 synchronize];
    
    NSUserDefaults *payMoney = [NSUserDefaults standardUserDefaults];
    [payMoney setObject:@"1" forKey:@"payMoneyid"];
    [payMoney synchronize];
    
    //已登录
//    FirstViewController *vc = [[FirstViewController alloc]init];
    MoneyViewController *vc = [[MoneyViewController alloc]init];
    SecondViewController *sc = [[SecondViewController alloc]init];
    ThirdViewController *tc = [[ThirdViewController alloc]init];
    FourthViewController *fc = [[FourthViewController alloc]init];
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:tc];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:fc];
    
    //选中与未被选中图片的渲染
    nav1.tabBarItem.title = @"扫码";
    nav1.tabBarItem.image = [[UIImage imageNamed:@"sweep3"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"sweep3"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    nav2.tabBarItem.title = @"订单";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"order2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"order2"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    nav3.tabBarItem.title = @"付款";
    nav3.tabBarItem.image = [[UIImage imageNamed:@"payMoney1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"payMoney1"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    nav4.tabBarItem.title = @"我的";
    nav4.tabBarItem.image = [[UIImage imageNamed:@"mySelf1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.selectedImage = [[UIImage imageNamed:@"mySelf1"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    self.tabBar.viewControllers = @[nav3,nav2,nav1,nav4];
    
    self.tabBar.tabBar.tintColor = [UIColor colorWithRed:235/255.0 green:131/255.0 blue:50/255.0 alpha:1];
    
    //隐藏导航栏
    nav1.navigationBarHidden = YES;
    nav2.navigationBarHidden = YES;
    nav3.navigationBarHidden = YES;
    nav4.navigationBarHidden = YES;
    
    self.window.rootViewController = _tabBar;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [AgreePay AgreeOpenURL:url withCompletion:^(NSString *agreeResult) {
        NSLog(@"result = %@",agreeResult);
    }];
    return YES;
    
    //    return [AgreePay AgreeOpenURL:url withCompletion:nil];
}

// iOS 9 及以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"微信返回----" preferredStyle:UIAlertControllerStyleAlert];
    //    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    //    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:2.0];
    
    [AgreePay AgreeOpenURL:url withCompletion:^(NSString *agreeResult) {
        
        NSLog(@"我的sdk回调结果 = %@",agreeResult);
        
        NSUserDefaults *payMoney = [NSUserDefaults standardUserDefaults];
        NSString *pay = [payMoney objectForKey:@"payMoneyid"];
        
        if ([pay isEqualToString:[NSString stringWithFormat:@"8"]]) {
            if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8100"]]) {
                
                UITabBarController *tab = (UITabBarController *)_window.rootViewController;
                UINavigationController *nav = tab.viewControllers[tab.selectedIndex];
                [nav popViewControllerAnimated:YES];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
                
            }else if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8104"]]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付错误" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
                
            }else if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8101"]]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经退出支付！" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
            }else if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8111"]]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"异常错误" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
            }
        }else{
            
            if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8100"]]) {
                
                NSUserDefaults *money1 = [NSUserDefaults standardUserDefaults];
                NSString *moneyStr1 = [money1 objectForKey:@"moneyid1"];
                
                NSUserDefaults *money = [NSUserDefaults standardUserDefaults];
                [money setObject:moneyStr1 forKey:@"moneyid"];
                [money synchronize];
                NSLog(@"%@",moneyStr1);
                
                UITabBarController *tab = (UITabBarController *)_window.rootViewController;
                UINavigationController *nav = tab.viewControllers[tab.selectedIndex];
                [nav popViewControllerAnimated:YES];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"充值成功" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss1:) withObject:alert afterDelay:1.0];
                
            }else if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8104"]]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"充值错误" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.0];
                
            }else if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8101"]]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经退出充值！" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.0];
            }else if ([agreeResult isEqualToString:[NSString stringWithFormat:@"8111"]]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"异常错误" preferredStyle:UIAlertControllerStyleAlert];
                [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
                [self performSelector:@selector(dismiss:) withObject:alert afterDelay:1.0];
            }
        }
       
    }];
    
    return YES;
    //    return [AgreePay AgreeOpenURL:url withCompletion:nil];
}

- (void)dismiss:(UIAlertController *)alert{
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dismiss1:(UIAlertController *)alert{
    
    NSUserDefaults *payMoney = [NSUserDefaults standardUserDefaults];
    [payMoney setObject:@"1" forKey:@"payMoneyid"];
    [payMoney synchronize];
    
    [alert dismissViewControllerAnimated:YES completion:nil];
    
}

@end
