//
//  AppDelegate.m
//  1111111
//
//  Created by 仝兴伟 on 2018/4/3.
//  Copyright © 2018年 仝兴伟. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) MainViewController *mainView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your applicatio
    NSWindow *loginWindow = [NSWindow windowWithContentViewController:self.mainView];
    self.mainWindowController = [[NSWindowController alloc]initWithWindow:loginWindow];
    self.mainView.view.window.windowController = self.mainWindowController;
    [self.mainWindowController.window makeKeyAndOrderFront:self];
    [self.mainWindowController.window center];
    [self.mainWindowController showWindow:nil];
    
}


-(MainViewController *)mainView {
    if (!_mainView) {
        _mainView = [[MainViewController alloc]init];
    }
    return _mainView;
}

@end
