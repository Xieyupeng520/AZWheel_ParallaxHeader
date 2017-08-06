//
//  JellyHeader.h
//  AZWheel_ParallaxHeader
//
//  Created by 阿曌 on 17/8/6.
//  Copyright © 2017年 阿曌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParallaxHeader.h"
@interface JellyHeader : UIView<ParallaxHeaderDelegate>

@property(nonatomic)UIColor* bottomColor; //果冻下方的颜色
@property(nonatomic,strong)UIImageView* avatarView;//头像

@end
