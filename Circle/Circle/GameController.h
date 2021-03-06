//
//  GameController.h
//  Circle
//
//  Created by Bin CHEN on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Circle;
@interface GameController : NSObject

@property (nonatomic) NSSet *circles;

- (instancetype)initWithCircles:(NSSet *)circles;
- (void)startGame;
- (void)stopGame;

- (void)liftCircle:(Circle *)circle;
- (void)dropCircle:(Circle *)smallCircle inCircle:(Circle *)bigCircle;

@end

