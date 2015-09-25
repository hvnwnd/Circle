//
//  Circle.m
//  Circle
//
//  Created by Titi on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Circle.h"
#import "CircleConfig.h"
#import "Velocity.h"

@implementation Circle

+ (instancetype)randomCircle
{
    NSUInteger size = RandomBetween(CircleMinSize, CircleMaxSize);
    float sizef = 1.0*size;
    CGFloat centerX = RandomBetween(size, (1024-size));
    CGFloat centerY = RandomBetween(size, (768-size));

    // Fixme: - velocity
    float vx = RandomBetween(CircleMinVelociy, CircleMaxVelociy);
    float signedVx = vx*(arc4random()%2? 1:-1);
    float vy = RandomBetween(CircleMinVelociy, CircleMaxVelociy);
    float signedVy = vy*(arc4random()%2? 1:-1);

    Velocity *v = [[Velocity alloc] initWithX:signedVx y:signedVy];
    return [[Circle alloc] initWithCenter:CGPointMake(centerX, centerY) size:size velocity:v];
}

+(Circle *)circleWithCenter:(CGPoint)center size:(float)size velocity:(Velocity *)v
{
    return [[self alloc] initWithCenter:center size:size velocity:v];
}

-(instancetype)initWithCenter:(CGPoint)center size:(float)size velocity:(Velocity *)v
{
    self = [super init];
    
    if (self){
        _center = center;
        _size = size;
        _v = v;
    }
    return self;
}

#pragma mark Private

- (Circle *)compineWithCircle:(Circle *)aCircle
{
    return [Circle circleWithCenter:aCircle.center size:aCircle.size+self.size velocity:aCircle.v];
}


- (BOOL)shouldBounceOffCircle:(Circle *)circle{
    double distance = sqrt((self.center.x-circle.center.x)*(self.center.x-circle.center.x) + (self.center.y-circle.center.y)*(self.center.y-circle.center.y));
    BOOL result = (distance <= (self.size+circle.size));
    if (result){
        NSLog(@"toto");
    }
    return result;
}

- (void)changeVelocityAfterBumpToCircle:(Circle *)circle{
    // change velocity of each other
    
    float c1vx = [self bumpedVelocityWithM1:self.size m2:circle.size v1:self.v.vx v2:circle.v.vx];
    float c2vx = [self bumpedVelocityWithM1:circle.size m2:self.size v1:circle.v.vx v2:self.v.vx];
    float c1vy = [self bumpedVelocityWithM1:self.size m2:circle.size v1:self.v.vy v2:circle.v.vy];
    float c2vy = [self bumpedVelocityWithM1:circle.size m2:self.size v1:circle.v.vy v2:self.v.vy];
    
    self.v.vx = c1vx;
    self.v.vy = c1vy;
    circle.v.vx = c2vx;
    circle.v.vy = c2vy;
}

- (float)bumpedVelocityWithM1:(float)m1
                           m2:(float)m2
                           v1:(float)v1
                           v2:(float)v2{
    return ((NSInteger)(m1-m2)*v1+2*m2*v2)/(float)(m1+m2);
}

- (void)move
{
    self.center = CGPointMake(self.center.x+self.v.vx, self.center.y+self.v.vy);
    if ([self bumpToWall]){
        if ((self.center.x-self.size) <= 0){
            [self.v bumpToLeftWall];
        }
        if (self.center.x+self.size >= 1024)
        {
            [self.v bumpToRightWall];
        }
        if (self.center.y-self.size <= 0){
            [self.v bumpToBottomWall];
        }
        if (self.center.y+self.size >= 768){
            [self.v bumpToTopWall];
        }
    }
}

- (BOOL)bumpToWall
{
    return !CGRectContainsRect(CanvasFrame, CGRectMake(self.center.x-self.size, self.center.y-self.size, 2*self.size, 2*self.size));
}

#pragma mark Description

- (NSString *)description{
    return [NSString stringWithFormat:@"%p (%0.f %0.f) %f %0.f:%0.f", self, self.center.x, self.center.y, self.size, self.v.vx, self.v.vy];
}


@end
