//
//  MainViewController.m
//  1111111
//
//  Created by 仝兴伟 on 2018/4/3.
//  Copyright © 2018年 仝兴伟. All rights reserved.
//

#import "MainViewController.h"
#import "MyTableCell.h"
//#import "HXRefresh.h"
#import "ITPullToRefreshScrollView.h"

#define kMessageTableviewWidth 730
@interface MainViewController ()<NSTableViewDelegate, NSTableViewDataSource,ITPullToRefreshScrollViewDelegate>
@property (nonatomic, strong) NSTableView *tableview;
@property (nonatomic, strong) ITPullToRefreshScrollView *tableviewScrollView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSProgressIndicator *indicator;
@end
// 写一个加载控件
@implementation MainViewController


-(NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"1",@"2",@"3",@"1",@"2",@"3",nil];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self addTabelview];
    
    self.tableviewScrollView.refreshableEdges = ITPullToRefreshEdgeTop | ITPullToRefreshEdgeBottom;
    [self.tableview reloadData];
    
    self.indicator = [[NSProgressIndicator alloc]initWithFrame:CGRectMake((kMessageTableviewWidth -40) /2, 10, 40, 40)];
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    self.indicator.wantsLayer = YES;
    self.indicator.layer.backgroundColor = [NSColor clearColor].CGColor;
    self.indicator.controlSize = NSControlSizeRegular;
    [self.indicator sizeToFit];
    self.indicator = self.indicator;
    self.indicator.hidden = YES;
    [self.tableviewScrollView addSubview:self.indicator];
}


- (void)addTabelview {
    self.tableviewScrollView = [[ITPullToRefreshScrollView alloc]initWithFrame:CGRectMake(0,0, kMessageTableviewWidth, 482)];
    self.tableviewScrollView.delegate = self;
    [self.tableviewScrollView setHasVerticalScroller:YES];
    // 创建tableview
    self.tableview = [[NSTableView alloc]initWithFrame:CGRectMake(0, 0, kMessageTableviewWidth, 482)];
    [self.tableview setAutoresizesSubviews:YES];
    [self.tableview setFocusRingType:NSFocusRingTypeDefault];
    self.tableview.headerView = nil;
    //  创建单元格 这里单元格设置为1个
    NSTableColumn *column1 = [[NSTableColumn alloc]initWithIdentifier:@"name"];
    column1.title = @"";
    column1.width = kMessageTableviewWidth;
    [self.tableview addTableColumn:column1];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableviewScrollView setDocumentView:self.tableview];
    [self.view addSubview:self.tableviewScrollView];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
        return self.listArray.count;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return  58;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    MyTableCell *cellView = [tableView makeViewWithIdentifier:@"kCellIdentifier" owner:self];
    if (cellView == nil) {
        cellView = [[MyTableCell alloc] init];
        [cellView setIdentifier: @"kCellIdentifier"];
    }
    return cellView;
}


- (void)pullToRefreshView:(ITPullToRefreshScrollView *)scrollView didStartRefreshingEdge:(ITPullToRefreshEdge)edge {
    NSLog(@"下拉刷出");
    
    if (edge & ITPullToRefreshEdgeTop) {
        NSLog(@"获取最新数据");
    } else if (edge & ITPullToRefreshEdgeBottom) {
        NSLog(@"获取旧数据");
    }
    
    /*
     double delayInSeconds = ((arc4random() % 10) / 10.0) * 5.0;
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
     dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void){
     dispatch_sync(dispatch_get_main_queue(), ^{
     if (edge & ITPullToRefreshEdgeTop) {
     [data insertObject:@"Test 100" atIndex:0];
     [data insertObject:@"Test 200" atIndex:0];
     } else if (edge & ITPullToRefreshEdgeBottom) {
     for (int i = 0; i < 10; i++) {
     [data addObject:[NSString stringWithFormat:@"Test %d", i]];
     }
     }
     
     [scrollView stopRefreshingEdge:edge];
     });
     });
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [scrollView stopRefreshingEdge:edge];
    });
}

- (void)pullToRefreshView:(ITPullToRefreshScrollView *)scrollView didStopRefreshingEdge:(ITPullToRefreshEdge)edge {
    
    //    NSRange range;
    //    if (edge & ITPullToRefreshEdgeTop) {
    //        // 返回数组个数
    //        range = NSMakeRange(0, 2);
    //    } else {
    //        range = NSMakeRange(data.count - 10, 10);
    //    }
    
    [self.tableview beginUpdates];
    {
        sleep(2);
        //        [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]
        //                              withAnimation:NSTableViewAnimationSlideDown];
    }
    [self.tableview endUpdates];
    NSLog(@"上拉加载");
    
}


-(void)scrollViewDidContentOffsetChange:(ITPullToRefreshScrollView *)scrollViews contentOffSet:(NSPoint)newOffset{
    NSLog(@"----= %f", newOffset.y);
//    if (NSEqualPoints(self.tableviewScrollView.bounds.origin, self.tableviewScrollView.documentVisibleRect.origin) == NO) {
//        [self reflectScrolledClipView:self.contentView];
//        NSLog(@"开始加载");
//    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.indicator.hidden = NO;
        [self.indicator startAnimation:nil];
    });
    
    if (newOffset.y > 0) {
        [self.listArray insertObject:@"2" atIndex:0];
        NSLog(@"插入头部");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.indicator.hidden = YES;
                [self.indicator stopAnimation:nil];
            });
        });
        
    } else {
        NSLog(@"插入尾部");
        [self.listArray addObject:@"2"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.indicator.hidden = YES;
                [self.indicator stopAnimation:nil];
            });
        });
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableview reloadData];
    });
}

@end
