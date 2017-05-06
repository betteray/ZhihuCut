//
//  ZhihuCut.m
//  ZhihuCut
//
//  Created by 罗红瑞 on 2017/5/7.
//  Copyright (c) 2017年 __MyCompanyName__. All rights reserved.
//

#import "CaptainHook.h"
#import "ShortMgr.h"

CHDeclareClass(ZHAnswerViewController);

// 参数个数，返回值类型，类的名称，selector 的名称，selector 的类型，selector 对应的参数的变量名。

CHMethod(2, void, ZHAnswerViewController, motionEnded, UIEventSubtype, motion, withEvent, UIEvent *, event)
{
    NSLog(@"CaptainHook HOOK motionEnded");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sure save screen short to album?"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
    
    [alertController addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Sure"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         [ShortMgr takeShortOf:[UIApplication sharedApplication].keyWindow];
                                                     }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    return CHSuper2(ZHAnswerViewController, motionEnded, motion, withEvent, event);
}

__attribute__((constructor)) static void entry()
{
    CHLoadLateClass(ZHAnswerViewController);
    CHHook2(ZHAnswerViewController, motionEnded, withEvent);
}
