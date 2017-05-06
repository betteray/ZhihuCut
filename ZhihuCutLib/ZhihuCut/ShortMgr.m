//
//  ShortMgr.m
//  ZhihuShort
//
//  Created by 罗红瑞 on 2017/5/6.
//
//

#import "ShortMgr.h"

@implementation ShortMgr

+ (instancetype)sharedMgr
{
    static ShortMgr * mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[ShortMgr alloc] init];
    });
    return mgr;
}

+ (void)takeShortOf:(UIView *)view
{
    [[ShortMgr sharedMgr] take:view];
}

- (void)take:(UIView *)view
{
    UIView *webview = [self find:@"UIWebBrowserView" in:view];
    UIImage *image = [self captureCurrentView:webview];
    [self saveImageToPhotos:image];
}

- (UIImage *)captureCurrentView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:contextRef];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)saveImageToPhotos:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(
        image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image
    didFinishSavingWithError:(NSError *)error
                 contextInfo:(void *)contextInfo
{
    if (error == nil) {
        NSLog(@"保存成功");
        
        Class hudClass = NSClassFromString(@"ZHStatusBarHUD");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id hud = [hudClass performSelector:NSSelectorFromString(@"sharedInstance")];
        [hud performSelector:NSSelectorFromString(@"postSuccessMessage:") withObject:@"Success ^_^"];
#pragma clang diagnostic pop
        
    } else {
        NSLog(@"失败");
        Class hudClass = NSClassFromString(@"ZHStatusBarHUD");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id hud = [hudClass performSelector:NSSelectorFromString(@"sharedInstance")];
        [hud performSelector:NSSelectorFromString(@"postSuccessMessage:") withObject:@"Failed -_-"];
#pragma clang diagnostic pop
    }
}

- (UIView *)find:(NSString *)viewClassName in:(UIView *)containerView
{
    BOOL isFound = [containerView isKindOfClass:[NSClassFromString(viewClassName) class]];
    if (isFound) return containerView;
    
    __block UIView *result = nil;
    [[containerView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                           NSUInteger idx,
                                                           BOOL * _Nonnull stop) {
        UIView * view = [self find:viewClassName in:obj];
        
        if (view) {
            result  = view;
            *stop   = YES;
        }
    }];
    return result;
}

@end
