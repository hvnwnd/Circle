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

- (void)bumpToTopWall
{
    _vy = -fabsf(_vy);
}

- (void)bumpToBottomWall
{
    _vy = fabsf(_vy);
}

- (void)bumpToLeftWall
{
    _vx = fabsf(_vx);
}
- (void)bumpToRightWall
{
    _vx = -fabsf(_vx);
}

@end
