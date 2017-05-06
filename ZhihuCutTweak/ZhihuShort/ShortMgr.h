//
//  ShortMgr.h
//  ZhihuShort
//
//  Created by 罗红瑞 on 2017/5/6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ShortMgrDelegate <NSObject>

- (void)onSaveSuccess;
- (void)onSaveFailed;

@end

@interface ShortMgr : NSObject

@property(nonatomic, assign) id<ShortMgrDelegate> delegate;

+ (instancetype)sharedMgr;
+ (void)takeShortOf:(UIView *)view;

@end
