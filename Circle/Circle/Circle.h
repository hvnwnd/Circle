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
@property (nonatomic, readonly) CGRect frame;

- (Circle *)compineWithCircle:(Circle *)aCircle;

+(Circle *)circleWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v color:(UIColor *)color;
+(Circle *)randomCircle;

- (BOOL)shouldBumpToCircle:(Circle *)circle;
- (void)changeVelocityAfterBumpToCircle:(Circle *)circle;

- (BOOL)bumpToWall;
- (void)move;
@end
