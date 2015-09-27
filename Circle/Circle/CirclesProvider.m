//
//  CirclesProvider.m
//  Circle
//
//  Created by Titi on 9/27/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "CirclesProvider.h"
#import "Circle.h"
#import "Velocity.h"
#import "CircleConfig.h"


@implementation CirclesProvider

+ (NSSet *)sampleCircles
{
    NSSet *sampleCircles;
    Circle *circle1= [[Circle alloc] initWithCenter:CGPointMake(200, 300) size:50 velocity:[[Velocity alloc] initWithX:2 y:0]];
    Circle *circle2 = [[Circle alloc] initWithCenter:CGPointMake(580, 250) size:80 velocity:[[Velocity alloc] initWithX:-3 y:0]];
    sampleCircles = [NSSet setWithObjects:circle1, circle2, nil];
    
    return sampleCircles;
}

+ (NSSet *)randomCircles
{
    NSMutableSet *randomCircles = [NSMutableSet setWithCapacity:CircleCount];
    
    // show circles
    while (randomCircles.count < CircleCount){
        Circle *circle =  [Circle randomCircle];
        
        NSSet *firstCircles = [randomCircles copy];
        if (randomCircles.count > 0)
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
                [randomCircles addObject:circle];
            }
        }else{
            [randomCircles addObject:circle];
        }
        
    }
    
    return randomCircles;
}


@end
