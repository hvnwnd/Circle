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

- (void)bumpToUpOrBottomWall
{
    _vy = -_vy;
}

- (void)bumpToLeftOrRightWall
{
    _vx = -_vx;
}

@end
