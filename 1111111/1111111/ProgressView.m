//
//  ProgressView.m
//  1111111
//
//  Created by 仝兴伟 on 2018/4/10.
//  Copyright © 2018年 仝兴伟. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self setWantsLayer:YES];
    self.layer.backgroundColor = [NSColor lightGrayColor].CGColor;
    self.layer.cornerRadius = 3.0;
}


@end
