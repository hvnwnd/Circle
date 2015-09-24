//
//  GameController.h
//  Circle
//
//  Created by Titi on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameController : NSObject

@property (nonatomic, readonly) NSMutableSet *randomCircles;

- (void)startGame;
- (void)stopGame;

@end

