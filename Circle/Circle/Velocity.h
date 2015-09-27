//
//  Velocity.h
//  Circle
//
//  Created by Bin CHEN on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Velocity : NSObject

@property (nonatomic) float vx;
@property (nonatomic) float vy;

- (instancetype)initWithX:(float)x y:(float)y;
- (float)angle;
- (float)scalarVelocity;
- (void)moveBottom;
- (void)moveTop;
- (void)moveRight;
- (void)moveLeft;

@end
