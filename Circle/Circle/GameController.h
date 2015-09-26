//
//  GameController.h
//  Circle
//
//  Created by Titi on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Circle;
@interface GameController : NSObject

@property (nonatomic) NSSet *circles;
- (void)startGameWithCompletionHandler:(void (^)(BOOL success))completionHandler;
- (void)stopGame;

- (void)liftCircle:(Circle *)circle;
- (void)dropCircle:(Circle *)smallCircle inCircle:(Circle *)bigCircle;
@end

