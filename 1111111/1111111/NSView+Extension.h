//
//  NSView+Extension.h
//  1111111
//
//  Created by 仝兴伟 on 2018/4/10.
//  Copyright © 2018年 仝兴伟. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (Extension)
+ (id) loadWithClass:(Class)loadClass owner:(id)owner;
+ (id)loadWithNibNamed:(NSString *)nibNamed owner:(id)owner class:(Class)loadClass ;
@end
