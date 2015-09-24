//
//  Velocity.h
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Velocity : NSObject

@property (nonatomic) float vx;
@property (nonatomic) float vy;

- (instancetype)initWithX:(float)x y:(float)y;
- (void)bumpToTopWall;
- (void)bumpToBottomWall;
- (void)bumpToLeftWall;
- (void)bumpToRightWall;

@end
