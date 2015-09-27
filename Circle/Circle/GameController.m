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

@property (nonatomic, copy) void (^completionHandler)(BOOL);

@end

@implementation GameController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.circles = self.randomCircles;
    }
    return self;
}

- (NSSet *)sampleCircles
{
    if (!_sampleCircles){
        Circle *circle1= [[Circle alloc] initWithCenter:CGPointMake(200, 300) size:50 velocity:[[Velocity alloc] initWithX:2 y:0]];
        Circle *circle2 = [[Circle alloc] initWithCenter:CGPointMake(580, 250) size:80 velocity:[[Velocity alloc] initWithX:-3 y:0]];
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

- (void)startGameWithCompletionHandler:(void (^)(BOOL success))completionHandler{
    self.completionHandler = completionHandler;
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
                [circle changeVelocityAfterBumpToCircle:anotherCircle];
            }
        }
    }
}

- (void)stopGame{
    [self.timer invalidate];
    self.timer = nil;
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
        
        [bigCircle combineWithCircle:smallCircle animated:YES];
        if (self.circles.count ==1 )
        {
            [self stopGame];
            self.completionHandler(YES);
        }
    }else{
        // intersect circle
        NSMutableSet *set = [self.circles mutableCopy];
        [set addObject:smallCircle];
        self.circles = set;
    }

    
    
    // no intersect cirlce
    
//    }else{
//        [bigCircle combineWithCircle:smallCircle animated:YES];
//    }
}

@end
