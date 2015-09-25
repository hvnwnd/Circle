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

@property (nonatomic) NSMutableSet *randomCircles;
@property (nonatomic) NSSet *sampleCircles;
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

- (NSSet *)sampleCircles
{
    if (!_sampleCircles){
        Circle *circle1= [[Circle alloc] initWithCenter:CGPointMake(200, 300) size:50 velocity:[[Velocity alloc] initWithX:15 y:0]];
        Circle *circle2 = [[Circle alloc] initWithCenter:CGPointMake(580, 290) size:200 velocity:[[Velocity alloc] initWithX:5 y:0]];
        _sampleCircles = [NSSet setWithObjects:circle1, circle2, nil];
    }
    return _sampleCircles;
}

- (NSSet *)randomCircles
{
    if (!_randomCircles)
    {
        _randomCircles = [NSMutableSet setWithCapacity:CircleCount];

        // show circles
        while (_randomCircles.count < CircleCount){
            Circle *circle =  [Circle randomCircle];
            
            NSSet *firstCircles = [_randomCircles copy];
            if (_randomCircles.count > 0)
            {
                BOOL shouldAddCircle = YES;
                for (Circle *anEarlierCircle in firstCircles) {
                    shouldAddCircle = shouldAddCircle && ![circle shouldBounceOffCircle:anEarlierCircle];
                    if (!shouldAddCircle)
                    {
                        continue;
                    }
                }
                
                if (shouldAddCircle)
                {
                    [_randomCircles addObject:circle];
                }
            }else{
                [_randomCircles addObject:circle];
            }

        }
    }
    
    return _randomCircles;
}

- (void)startGame{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:CircleMoveInterval target:self selector:@selector(moveCircles) userInfo:nil repeats:YES];
}

- (NSSet *)circles{
    return self.randomCircles;
}

- (void)moveCircles
{
    
    NSMutableSet *otherCircles = [self.circles mutableCopy];

    for (Circle *circle in self.circles) {
        [circle move];
        [otherCircles removeObject:circle];
        
        for (Circle *anotherCircle in otherCircles) {
            if ([circle shouldBounceOffCircle:anotherCircle]){
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
