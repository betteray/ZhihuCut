
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

#import "ShortMgr.h"
#import <UIKit/UIKit.h>
#import "ZHStatusBarHUD.h"

@interface ZHAnswerViewController : UIViewController <ShortMgrDelegate>

@end



%hook ZHAnswerViewController

- (void)motionEnded:(NSInteger)motion withEvent:(id)event
{
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

%new(v@:)
- (void)onSaveSuccess
{
    ZHStatusBarHUD * hud = [objc_getClass("ZHStatusBarHUD") sharedInstance];
    [hud postSuccessMessage:@"Success ^_^ "];
}

%new(v@:)
- (void)onSaveFailed
{
    ZHStatusBarHUD * hud = [objc_getClass("ZHStatusBarHUD") sharedInstance];
    [hud postSuccessMessage:@"Failed -_- "];
}

%end
