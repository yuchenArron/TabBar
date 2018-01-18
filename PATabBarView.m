

//
//  PATabBarView.m
//  zztjProject
//
//  Created by 张小超(外包) on 2018/1/18.
//  Copyright © 2018年 PA. All rights reserved.
//

#import "PATabBarView.h"

#define CircleDiameter  54
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define TabBar_Height   54

#define BarItemHeight  44
#define BarItemWidth   64


@interface PATabBarView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation PATabBarView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer addSublayer:self.shapeLayer];
        [self.layer addSublayer:self.lineLayer];
    }
    return self;
}

#pragma mark - layer

- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc]init];
        _shapeLayer.path = self.bezierPath.CGPath;
        _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    }
    return _shapeLayer;
}

- (CAShapeLayer *)lineLayer{
    if (!_lineLayer) {
        _lineLayer = [[CAShapeLayer alloc]init];
        _lineLayer.lineWidth = 1;
        _lineLayer.path = self.lineBezierPath.CGPath;
        _lineLayer.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1].CGColor;
        _lineLayer.fillColor = nil;
    }
    return _lineLayer;
}

- (UIBezierPath*)bezierPath{
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake((Screen_Width - CircleDiameter) / 2, 0)];
    [bezierPath addArcWithCenter:CGPointMake(Screen_Width / 2, (CircleDiameter / 2) * cos(M_PI / 3))
                          radius:CircleDiameter / 2
                      startAngle:M_PI * 7 / 6
                        endAngle:M_PI * 11 / 6
                       clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width, 0)];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width, TabBar_Height)];
    [bezierPath addLineToPoint:CGPointMake(0, TabBar_Height)];
    [bezierPath addLineToPoint:CGPointMake(0, 0)];
    return bezierPath;
}

- (UIBezierPath*)lineBezierPath{
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake((Screen_Width - CircleDiameter) / 2, 0)];
    [bezierPath addArcWithCenter:CGPointMake(Screen_Width / 2, (CircleDiameter / 2) * cos(M_PI / 3))
                          radius:CircleDiameter / 2
                      startAngle:M_PI * 7 / 6
                        endAngle:M_PI * 11 / 6
                       clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(Screen_Width, 0)];
    return bezierPath;
}

#pragma mark - button

- (void)setItemsTitle:(NSArray *)titles unselectImg:(NSArray *)unslectImgs selectImg:(NSArray *)selectImgs{
    if (titles.count != unslectImgs.count || titles.count != selectImgs.count) {
        NSLog(@"-----------------------title 和 图片不一致PATabBarView-------------------------");
        return;
    }
    NSInteger count = titles.count;
    self.itemCount = count;
    for (int i = 0;i < count;i++){
        [self setTitle:titles[i] unSelectImg:unslectImgs[i] selectImg:selectImgs[i] index:i + 100];
    }
    
}

- (void)setTitle:(NSString*)title unSelectImg:(NSString*)unselectImg selectImg:(NSString*)selectImg index:(NSInteger)indexTag{
    UIButton *but = [self viewWithTag:indexTag];
    if (!but) {
        but = [self createButtonWithIndex:indexTag];
    }
    [but setTitle:title forState:UIControlStateNormal];
    
    [self setBut:but imgStr:unselectImg state:UIControlStateNormal];
    [self setBut:but imgStr:selectImg state:UIControlStateSelected];
}

- (UIButton*)createButtonWithIndex:(NSInteger)indexTag{
    UIButton *but = [[UIButton alloc]init];
    but.tag = indexTag;
    NSInteger i = indexTag - 100;
    CGRect frame = [self rectForButtonWithIndex:i];
    but.frame = frame;
    [self addSubview:but];
    [but addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
//    [but setImageEdgeInsets:UIEdgeInsetsMake(-15, BarItemWidth / 2, 0, 0)];
//    [but setTitleEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    but.titleLabel.font = [UIFont systemFontOfSize:12];
    but.adjustsImageWhenHighlighted = NO;//取消点击效果
    
    return but;
}

- (void)setBut:(UIButton*)but imgStr:(NSString*)imgStr state:(UIControlState)state{
    
    NSString *imgPath = [[[NSBundle mainBundle] pathForResource:@"regular" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_pressed.png",imgStr]];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    [but setImage:image forState:state];

  
    NSString *str = but.currentTitle;
    CGSize size1 =  [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];//[str sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(MAXFLOAT, but.titleLabel.frame.size.height)];
    
    but.titleEdgeInsets =UIEdgeInsetsMake(0.5*image.size.height, -0.5*image.size.width, -0.5*image.size.height, 0.5*image.size.width);
    
    but.imageEdgeInsets =UIEdgeInsetsMake(-0.5*size1.height, 0.5*size1.width, 0.5*size1.height, -0.5*size1.width);
    
}

- (CGRect)rectForButtonWithIndex:(NSInteger)index{
    CGFloat x = SCREEN_WIDTH / self.itemCount * index + (SCREEN_WIDTH / self.itemCount - BarItemWidth) / 2;
    CGFloat y = 0;
    
    CGRect frame = CGRectMake(x, y, BarItemWidth, self.frame.size.height);
    return frame;
}

- (UIButton *)itemWithIndex:(NSInteger)index{
    return [self viewWithTag:index + 100];
}

- (void)setSelectItemWithIndex:(NSInteger)index{
    [self clickItemWithIndexTag:index + 100];
}

#pragma mark - click

- (void)clickItem:(UIButton*)sender{
    
    if (!sender.selected) {
        //
        [self clickItemWithIndexTag:sender.tag];
    }
}

- (void)clickItemWithIndexTag:(NSInteger)indexTag{
    NSArray *views = [self subviews];
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton*)view;
            if (but.tag == indexTag) {
                but.selected = YES;
                if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectViewControllerIndex:)]) {
                    [self.delegate didSelectViewControllerIndex:indexTag - 100];
                }
            }else{
                but.selected = NO;
            }
        }
    }
}


@end



