//
//  ReusableHView.m
//  TaoOne
//
//  Created by xun on 16/10/25.
//  Copyright © 2016年 xun. All rights reserved.
//

#import "ReusableHView.h"
#import "UIView+YYAdd.h"
#import "UIGestureRecognizer+YYAdd.h"


@implementation ReusableCell
- (void)setImageView:(UIImageView *)imageView {
    _imageView = imageView;
    if (_imageView) {
        [self addSubview:_imageView];
    }
}
- (void)setTextLabel:(UILabel *)textLabel {
    _textLabel = textLabel;
    if (_textLabel) {
        [self addSubview:_textLabel];
    }
}
@end


@interface ReusableCellMain : UIView
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) ReusableCell *item;
@end
@implementation ReusableCellMain

- (instancetype)init {
    self = super.init;
    if (!self) return nil;
    return self;
}
- (void)setItem:(ReusableCell *)item {
    if ([_item isEqual:item]) return;
    _item = item;
    if (_item) {
        _item.userInteractionEnabled = YES;
        [self addSubview:item];
    }
}

@end



@interface ReusableHView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, assign) NSInteger totalPageCount;
@end
@implementation ReusableHView

- (instancetype)initWithFrame:(CGRect)aFrame
                     cellSize:(CGSize)aSize
                      padding:(UIEdgeInsets)aPadding
                      visible:(int)aNum {
    if (self=[super initWithFrame:aFrame]) {
        self.cellSize       = aSize;
        self.padding        = aPadding;
        self.visibleNumber  = aNum;
        [self setupView];
    }
    return self;
}

- (void)setupView {
    _cells = @[].mutableCopy;
    
    self.delegate = self;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
}

- (void)setReusableDelegate:(id<ReusableHDelegate>)reusableDelegate {
    _reusableDelegate = reusableDelegate;
    [self reloadData];
}

- (void)reloadData {
    _totalPageCount = 0;
    
    if (_reusableDelegate && [_reusableDelegate respondsToSelector:@selector(numberOfCellsInReusableHView:)]) {
        _totalPageCount = [_reusableDelegate numberOfCellsInReusableHView:self];
        //计算contentSize
        CGFloat contentW = _cellSize.width *_totalPageCount +_padding.left +_padding.right;
        self.contentSize = CGSizeMake(contentW, self.frame.size.height);
        //调用滚动初始化第一个值
        [self scrollViewDidScroll:self];
    }
    else {
        //
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //cell超出左右两边时移除它
    [self updateCellsForReuse];
    int cellw = _cellSize.width;
    
    NSInteger page = (self.contentOffset.x-_padding.left) /cellw +0.5; //拖动频幕时预加载
    
    for (NSInteger i = page - 1; i <= page + _visibleNumber; i++) {
        // preload left and right cell
        if (i >= 0 && i < _totalPageCount) {
            ReusableCellMain *cell = [self cellForPage:i];
            if (!cell) {
                //获取不到cell时，从复用中创建cell
                ReusableCellMain *cell = [self dequeueReusableCell];
                if (_reusableDelegate && [_reusableDelegate respondsToSelector:@selector(reusableHView:cellAtIndex:)]) {
                    cell.page = i;
                    cell.left = cellw *i + _padding.left;
                    cell.item = [_reusableDelegate reusableHView:self cellAtIndex:i];
                    [self addSubview:cell];

                    __weak typeof(self) wself = self;
                    __weak typeof(cell) wcell = cell;
                    //cell点击事件
                    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
                        //回调点击事件
                        if (wself.reusableDelegate && [_reusableDelegate respondsToSelector:@selector(reusableHView:didSelectAtIndex:)]) {
                            [wself.reusableDelegate reusableHView:wself didSelectAtIndex:wcell.page];
                        }
                    }];
                    [cell.item addGestureRecognizer:tgr];
                }
            }else {
                if (!cell.item) {
                    if (_reusableDelegate && [_reusableDelegate respondsToSelector:@selector(reusableHView:cellAtIndex:)]) {
                        cell.item = [_reusableDelegate reusableHView:self cellAtIndex:i];
                    }
                }
            }
        }//end_if
    }//end_for
}

/// enqueue invisible cells for reuse
- (void)updateCellsForReuse {
    for (ReusableCellMain *cell in _cells) {
        if (cell.superview) {
            //cell超出某个值时移除它
            if (cell.left  >
                self.contentOffset.x + self.width + _cellSize.width||
                cell.right <
                self.contentOffset.x - _cellSize.width) {
                //移除view
                [cell removeFromSuperview];
                [cell.item removeFromSuperview];
                cell.page = -1;
                cell.item = nil;
            }
        }
    }
}

/// dequeue a reusable cell
- (ReusableCellMain *)dequeueReusableCell {
    ReusableCellMain *cell = nil;
    //查找是否有空闲的cell，有就拿来用，无就创建
    for (cell in _cells) {
        if (!cell.superview) {
            return cell;
        }
    }
    //创建cell
    cell = [ReusableCellMain new];
    cell.frame = CGRectMake(_padding.left, _padding.top, _cellSize.width, _cellSize.height);
    cell.page = -1;
    cell.item = nil;
    [_cells addObject:cell];
    return cell;
}

- (ReusableCellMain *)cellForPage:(NSInteger)page {
    for (ReusableCellMain *cell in _cells) {
        if (cell.page == page) {
            return cell;
        }
    }
    return nil;
}

@end
