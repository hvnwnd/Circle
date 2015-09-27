//
//  Circle.h
//  Circle
//
//  Created by Titi on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@class Velocity;
@interface Circle : NSObject

@property (nonatomic) CGFloat size;
@property (nonatomic) Velocity *v;
@property (nonatomic) CGPoint center;

@property (nonatomic) BOOL isLifted;
@property (nonatomic) BOOL isFinal;

-(instancetype)initWithCenter:(CGPoint)center size:(float)size velocity:(Velocity *)v;
+ (instancetype)randomCircle;

- (float)contactAngleWithCircle:(Circle *)aCircle;
- (void)combineWithCircle:(Circle *)aCircle animated:(BOOL)animated;

- (BOOL)shouldBounceOffCircle:(Circle *)circle;
- (void)changeVelocityAfterBumpToCircle:(Circle *)circle;

- (BOOL)bumpToWall;
- (void)move;

@end
