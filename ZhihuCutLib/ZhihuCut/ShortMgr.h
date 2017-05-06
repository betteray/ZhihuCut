//
//  ShortMgr.h
//  ZhihuShort
//
//  Created by 罗红瑞 on 2017/5/6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShortMgr : NSObject

+ (instancetype)sharedMgr;
+ (void)takeShortOf:(UIView *)view;

@end
