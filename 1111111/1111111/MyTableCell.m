//
//  MyTableCell.m
//  cloudscreen
//
//  Created by 仝兴伟 on 2017/10/21.
//  Copyright © 2017年 仝兴伟. All rights reserved.
//

#import "MyTableCell.h"
@interface MyTableCell ()
@property (nonatomic, strong) NSTextField *titleLabel;
@property (nonatomic, strong) NSTextField *emailLabel;
@property (nonatomic, strong) NSTextField *detailedLabel;
@property (nonatomic, strong) NSTextField *dateLabel;
@property (nonatomic, strong) NSTextField *lineLabl;
@end

@implementation MyTableCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self setWantsLayer:YES];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
//    self.layer.backgroundColor = [NSColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1].CGColor;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    if ([super initWithFrame:frameRect]) {
        [self addLayout];
    }
    return self;
}

-(NSImageView *)imageViews {
    if (!_imageViews) {
        _imageViews = [[NSImageView alloc]initWithFrame:CGRectMake(32, 5, 50, 50)];
        [_imageViews setWantsLayer:YES];
        _imageViews.layer.cornerRadius = 25;
    }
    return _imageViews;
}

-(NSTextField *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self CreateTextField:CGRectMake(95, 30, 65, 20) title:@"重要通知"];
        self.titleLabel.backgroundColor = [NSColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.01];
    }
    return _titleLabel;
}

- (void)addLayout {
    
    // 创建图片
    [self addSubview:self.imageViews];
    
    // 姓名
    [self addSubview:self.titleLabel];
    
    // 邮箱
    self.emailLabel = [self CreateTextField:CGRectMake(165, 30, 200, 20) title:@"xingwei.tong@cloudscreen.com"];
    self.emailLabel.font = [NSFont systemFontOfSize:11.0];
    [self.emailLabel setTextColor:[NSColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:147 / 255.0 alpha:1.0]];
    self.emailLabel.backgroundColor = [NSColor clearColor];
    [self addSubview:self.emailLabel];
    
    // 创建详细信息
    self.detailedLabel = [self CreateTextField:CGRectMake(95, 5, 580, 20) title:@"今晚上山打老虎,啪不啪,晚上山打老虎,啪不啪1234567xingwei.tong@cloudscreen.com"];
    self.detailedLabel.font = [NSFont systemFontOfSize:12.0];
    [self.detailedLabel setTextColor:[NSColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:147 / 255.0 alpha:1.0]];
    self.detailedLabel.backgroundColor = [NSColor clearColor];
    [self addSubview:self.detailedLabel];
    
        // 创建日期
    self.dateLabel = [self CreateTextField:CGRectMake(580, 30, 150, 20) title:@"2017-9-11"];
    [self.dateLabel setTextColor:[NSColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:147 / 255.0 alpha:1.0]];
    self.dateLabel.backgroundColor = [NSColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.01];
    [self addSubview:self.dateLabel];
    
    // line
    self.lineLabl = [self CreateTextField:CGRectMake(20, 0, 700, 1.0) title:@""];
    self.lineLabl.backgroundColor = [NSColor lightGrayColor];
    [self addSubview:self.lineLabl];
}


- (NSTextField *)CreateTextField:(CGRect)rect title:(NSString *)title{
    NSTextField *textField = [[NSTextField alloc]initWithFrame:rect];
    [textField setBordered:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    textField.stringValue = title;
    [textField setLineBreakMode:(NSLineBreakByTruncatingMiddle)];
    return textField;
}


@end
