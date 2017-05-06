//
//  MBProgressHUD.h
//  ZhihuShort
//
//  Created by 罗红瑞 on 2017/5/7.
//
//

#import <Foundation/Foundation.h>

@interface ZHStatusBarHUD : NSObject

+ (instancetype)sharedInstance;
- (void)postSuccessMessage:(NSString *)msg;

@end
