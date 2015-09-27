//
//  Canvas.h
//  Circle
//
//  Created by Titi on 9/26/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;
@interface Canvas : UIView


@property (nonatomic, weak) GameController *controller;
- (void)prepareForGame;
@end
