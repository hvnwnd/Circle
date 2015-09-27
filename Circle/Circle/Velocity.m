//
//  Velocity.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Velocity.h"

@implementation Velocity

- (instancetype)initWithX:(float)x y:(float)y;
{
    self = [super init];
    
    if (self)
    {
        _vx = x;
        _vy = y;
    }
    
    return self;
}

- (float)angle{
    return atan2f(_vy, _vx);
}

- (float)scalarVelocity{
    return sqrtf(_vy*_vy+_vx*_vx);
}

- (void)moveBottom
{
    _vy = -fabsf(_vy);
}

- (void)moveTop
{
    _vy = fabsf(_vy);
}

- (void)moveRight
{
    _vx = fabsf(_vx);
}
- (void)moveLeft
{
    _vx = -fabsf(_vx);
}

@end
