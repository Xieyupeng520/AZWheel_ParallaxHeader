//
//  JellyHeader.m
//  AZWheel_ParallaxHeader
//
//  Created by 阿曌 on 17/8/6.
//  Copyright © 2017年 阿曌. All rights reserved.
//

#import "JellyHeader.h"

@interface JellyHeader () {
    UIBezierPath *_path; //自绘制线条
    CGFloat _controlH; //中心控制点高度
    CGFloat _bottomControlH; //底部控制点高度
}

@end
@implementation JellyHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _bottomColor = [UIColor blackColor];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        CGFloat y = self.bounds.origin.y;
        CGFloat h = self.bounds.size.height;
        _controlH = (y+h)/2;
        _bottomControlH = y+h;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    _path = [[UIBezierPath alloc] init];
    
    
    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    [self drawLineStartAt:CGPointMake(x, y) EndAt:CGPointMake(x, y + h)];
    [self drawBezierCurveStartAt:CGPointMake(x, _bottomControlH) EndAt:CGPointMake(x+w, _bottomControlH) controlPoint:CGPointMake((x+w)/2, _controlH)];
    [self drawLineStartAt:CGPointMake(x+w, y+h) EndAt:CGPointMake(x+w, y)];
    [self drawLineStartAt:CGPointMake(x+w, y) EndAt:CGPointMake(x, y)];
    
    [_bottomColor set];
    [_path fill];
}


- (void)drawLineStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint {
    [_path moveToPoint:startPoint]; //加了会对填充颜色造成反选
    [_path addLineToPoint:endPoint];
}

- (void)drawBezierCurveStartAt:(CGPoint)startPoint EndAt:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint {
    [_path moveToPoint:startPoint];
    [_path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
}

#pragma delegate 
- (void)parallaxHeaderDidScroll:(ParallaxHeader *)parallaxHeader progress:(CGFloat)progress {
    CGFloat pw = parallaxHeader.view.frame.size.width;
    CGFloat currentH = parallaxHeader.frame.size.height;
    parallaxHeader.view.frame = CGRectMake(0, 0, pw, currentH);
    
    if (progress < 0 || progress > 1) {
        return;
    }
    
    CGFloat y = self.bounds.origin.y;
    CGFloat h = self.bounds.size.height;
    
    _controlH = (progress)*((y+h)/2 - parallaxHeader.minimumHeight) + parallaxHeader.minimumHeight;
    _bottomControlH = currentH;
    
    [self setNeedsDisplay];
}

#pragma mark - setter & getter
- (UIImageView *)avatarView {
    if (!_avatarView) {
        CGFloat x = self.bounds.origin.x;
        CGFloat w = self.bounds.size.width;
        
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _avatarView.center = CGPointMake((x+w)/2, _controlH);
        _avatarView.layer.cornerRadius = 25;
    }
    return _avatarView;
}
@end
