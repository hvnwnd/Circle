//
//  Circle.h
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Velocity;
@class Circle;

@interface CircleView : UIView

@property (nonatomic) UIColor *color;
@property (nonatomic) Circle *circle;

+ (instancetype)randomColorCircleViewWithCircle:(Circle *)circle;

@end
