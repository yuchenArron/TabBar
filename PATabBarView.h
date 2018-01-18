//
//  PATabBarView.h
//  zztjProject
//
//  Created by 张小超(外包) on 2018/1/18.
//  Copyright © 2018年 PA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PATabBarViewDelegate<NSObject>

@optional
- (void)didSelectViewControllerIndex:(NSInteger)index;

@end

@interface PATabBarView : UIView

@property (nonatomic, weak) id<PATabBarViewDelegate>delegate;

/**
 设置 title 和 按钮的图片 title 和 图片的个数需要与 controllers 个数一致

 @param titles
 @param unslectImgs
 @param selectImgs
 */
- (void)setItemsTitle:(NSArray*)titles unselectImg:(NSArray*)unslectImgs selectImg:(NSArray*)selectImgs;

/**
 获取item

 @return 按钮对象
 */
- (UIButton*)itemWithIndex:(NSInteger)index;

/**
 设置选中的item index

 @param index 第几个  从0开始
 */
- (void)setSelectItemWithIndex:(NSInteger)index;

@end
