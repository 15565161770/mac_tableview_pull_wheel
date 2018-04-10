//
//  NSView+Extension.m
//  1111111
//
//  Created by 仝兴伟 on 2018/4/10.
//  Copyright © 2018年 仝兴伟. All rights reserved.
//

#import "NSView+Extension.h"

@implementation NSView (Extension)

+ (id) loadWithClass:(Class)loadClass owner:(id)owner {
    return  [NSView loadWithNibNamed:NSStringFromClass(loadClass) owner:owner class:loadClass];
}

+ (id)loadWithNibNamed:(NSString *)nibNamed owner:(id)owner class:(Class)loadClass {
    NSNib * nib = [[NSNib alloc] initWithNibNamed:nibNamed bundle:nil];
    NSArray * objects;
    if (![nib instantiateWithOwner:owner topLevelObjects:&objects]) {
        NSLog(@"Couldn't load nib named %@", nibNamed);
        return nil;
    }
    for (id object in objects) {
        if ([object isKindOfClass:loadClass]) {
            return object;
        }
    }
    return nil;

}

@end
