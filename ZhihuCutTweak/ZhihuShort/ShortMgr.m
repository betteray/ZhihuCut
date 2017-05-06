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
        if (self.delegate && [self.delegate respondsToSelector:@selector(onSaveSuccess)]) [self.delegate onSaveSuccess];
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onSaveFailed)]) [self.delegate onSaveFailed];
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
