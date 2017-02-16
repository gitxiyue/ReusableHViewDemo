//
//  ReusableHView.h
//  TaoOne
//
//  Created by xun on 16/10/25.
//  Copyright © 2016年 xun. All rights reserved.
//  横向可以复用的小tableview

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
    可以继承ReusableCell建立自己的cellview
 */
@interface ReusableCell : UIView
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *textLabel;
@end



@class ReusableHView;
@protocol ReusableHDelegate <NSObject>

@required
- (NSInteger)numberOfCellsInReusableHView:(ReusableHView *)view;
- (ReusableCell *)reusableHView:(ReusableHView *)view cellAtIndex:(NSInteger)index;
@optional
- (void)reusableHView:(ReusableHView *)view didSelectAtIndex:(NSInteger)index;

@end



@interface ReusableHView : UIScrollView
@property (nonatomic, weak) id<ReusableHDelegate> reusableDelegate;
@property (nonatomic ,assign) CGSize cellSize;      ///cellMain大小
@property (nonatomic ,assign) UIEdgeInsets padding; ///边距
@property (nonatomic ,assign) int visibleNumber;    ///可见的个数


/**
 ////// 初始化方法

 @param aFrame   ReusableHView的frame
 @param aSize    ReusableCellMain的size
 @param aPadding 边距
 @param aNum     可见的个数

 @return ReusableHView
 */
- (instancetype)initWithFrame:(CGRect)aFrame
                     cellSize:(CGSize)aSize
                      padding:(UIEdgeInsets)aPadding
                      visible:(int)aNum;

- (void)reloadData;
@end
NS_ASSUME_NONNULL_END
