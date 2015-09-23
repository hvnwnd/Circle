//
//  Circle.h
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Velocity;
@interface Circle : UIView

@property (nonatomic) NSUInteger size;
@property (nonatomic) Velocity *v;
@property (nonatomic) UIColor *color;

- (Circle *)compineWithCircle:(Circle *)aCircle;

+(Circle *)circleWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v color:(UIColor *)color;
+(Circle *)randomCircle;

@end
