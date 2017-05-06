#line 1 "/Users/henray/Desktop/ZhihuCut/ZhihuCutTweak/ZhihuShort/ZhihuShort.xm"




#import "ShortMgr.h"
#import <UIKit/UIKit.h>
#import "ZHStatusBarHUD.h"

@interface ZHAnswerViewController : UIViewController <ShortMgrDelegate>

@end



#include <logos/logos.h>
#include <substrate.h>
@class ZHAnswerViewController; 
static void (*_logos_orig$_ungrouped$ZHAnswerViewController$motionEnded$withEvent$)(ZHAnswerViewController*, SEL, NSInteger, id); static void _logos_method$_ungrouped$ZHAnswerViewController$motionEnded$withEvent$(ZHAnswerViewController*, SEL, NSInteger, id); static void _logos_method$_ungrouped$ZHAnswerViewController$onSaveSuccess(ZHAnswerViewController*, SEL); static void _logos_method$_ungrouped$ZHAnswerViewController$onSaveFailed(ZHAnswerViewController*, SEL); 

#line 15 "/Users/henray/Desktop/ZhihuCut/ZhihuCutTweak/ZhihuShort/ZhihuShort.xm"



static void _logos_method$_ungrouped$ZHAnswerViewController$motionEnded$withEvent$(ZHAnswerViewController* self, SEL _cmd, NSInteger motion, id event) {
    NSLog(@"Henray Take Short!");
    
    [ShortMgr sharedMgr].delegate = self;
    
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
}



static void _logos_method$_ungrouped$ZHAnswerViewController$onSaveSuccess(ZHAnswerViewController* self, SEL _cmd) {
    ZHStatusBarHUD * hud = [objc_getClass("ZHStatusBarHUD") sharedInstance];
    [hud postSuccessMessage:@"Success ^_^ "];
}



static void _logos_method$_ungrouped$ZHAnswerViewController$onSaveFailed(ZHAnswerViewController* self, SEL _cmd) {
    ZHStatusBarHUD * hud = [objc_getClass("ZHStatusBarHUD") sharedInstance];
    [hud postSuccessMessage:@"Failed -_- "];
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$ZHAnswerViewController = objc_getClass("ZHAnswerViewController"); MSHookMessageEx(_logos_class$_ungrouped$ZHAnswerViewController, @selector(motionEnded:withEvent:), (IMP)&_logos_method$_ungrouped$ZHAnswerViewController$motionEnded$withEvent$, (IMP*)&_logos_orig$_ungrouped$ZHAnswerViewController$motionEnded$withEvent$);{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$ZHAnswerViewController, @selector(onSaveSuccess), (IMP)&_logos_method$_ungrouped$ZHAnswerViewController$onSaveSuccess, _typeEncoding); }{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$ZHAnswerViewController, @selector(onSaveFailed), (IMP)&_logos_method$_ungrouped$ZHAnswerViewController$onSaveFailed, _typeEncoding); }} }
#line 63 "/Users/henray/Desktop/ZhihuCut/ZhihuCutTweak/ZhihuShort/ZhihuShort.xm"
