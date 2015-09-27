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
#import "Velocity.h"

@interface GameController ()

@property (nonatomic) NSTimer *timer;

@end

@implementation GameController

- (instancetype)initWithCircles:(NSSet *)circles
{
    self = [super init];
    if (self) {
        _circles = circles;
    }
    return self;
}

- (void)startGame{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:CircleMoveInterval target:self selector:@selector(moveCircles) userInfo:nil repeats:YES];
}

- (void)moveCircles
{
    NSMutableSet *otherCircles = [self.circles mutableCopy];
    
    for (Circle *circle in self.circles) {
        [circle move];
        [otherCircles removeObject:circle];
        
        for (Circle *anotherCircle in otherCircles) {
            if ([circle shouldBounceOffCircle:anotherCircle]){
                [circle changeVelocityAfterBounceOffCircle:anotherCircle];
            }
        }
    }
}

- (void)stopGame{
    self.circles = nil;
    [self.timer invalidate];
    self.timer = nil;
    [self.delegate gameDidStop];
}

- (void)liftCircle:(Circle *)circle{
    circle.isLifted = YES;
    NSMutableSet *set = [self.circles mutableCopy];
    [set removeObject:circle];
    self.circles = set;
}

- (void)dropCircle:(Circle *)smallCircle inCircle:(Circle *)bigCircle{
    smallCircle.isLifted = NO;
    
    if (bigCircle){
        // big circle under
        
        [bigCircle combineWithCircle:smallCircle];
        if (self.circles.count == 1)
        {
            bigCircle.isFinal = YES;
            [self stopGame];
        }
    }else{
        NSMutableSet *set = [self.circles mutableCopy];
        [set addObject:smallCircle];
        self.circles = set;
    }
}

@end
