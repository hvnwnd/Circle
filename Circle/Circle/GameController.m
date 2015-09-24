//
//  GameController.m
//  Circle
//
//  Created by Titi on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "GameController.h"
#import "CircleConfig.h"
#import "Circle.h"

@interface GameController ()

@property (nonatomic, readwrite) NSMutableSet *randomCircles;
@property (nonatomic) NSTimer *timer;
@end

@implementation GameController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSSet *)randomCircles
{
    if (!_randomCircles)
    {
        _randomCircles = [NSMutableSet setWithCapacity:CircleCount];

        NSUInteger count = CircleCount;
        // show circles
        for (uint i = 0; i < count; i++) {
            Circle *circle =         [Circle randomCircle];
            [_randomCircles addObject:circle];
        }
    }
    
    return _randomCircles;
}

- (void)startGame{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:CircleMoveInterval target:self selector:@selector(moveCircles) userInfo:nil repeats:YES];
}

- (void) moveCircles
{
    for (Circle *circle in self.randomCircles) {
        [circle move];
        NSMutableSet *otherCircles = [self.randomCircles mutableCopy];
        [otherCircles removeObject:circle];
        
        for (Circle *anotherCircle in otherCircles) {
            if ([circle shouldBumpToCircle:anotherCircle]){
                [circle changeVelocityAfterBumpToCircle:anotherCircle];
            }
        }
    }
}

- (void)stopGame{
    [self.timer invalidate];
    self.timer = nil;
}
@end
