//
//  Canvas.h
//  Circle
//
//  Created by Bin CHEN on 9/26/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ShouldStartGameNotification;

@class GameController;
@interface Canvas : UIView

@property (nonatomic, weak) GameController *controller;
- (void)prepareForGame;
@end
