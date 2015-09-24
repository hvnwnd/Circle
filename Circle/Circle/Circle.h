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

@property (nonatomic) NSUInteger size;
@property (nonatomic) Velocity *v;
@property (nonatomic) CGPoint center;


-(instancetype)initWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v;
+ (instancetype)randomCircle;

- (Circle *)compineWithCircle:(Circle *)aCircle;

- (BOOL)shouldBumpToCircle:(Circle *)circle;
- (void)changeVelocityAfterBumpToCircle:(Circle *)circle;

- (BOOL)bumpToWall;
- (void)move;

@end
