//
//  Canvas.m
//  Circle
//
//  Created by Titi on 9/26/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Canvas.h"
#import "CircleView.h" 
#import "Circle.h" 
#import "GameController.h"
@interface Canvas ()

@property (nonatomic) UIView *draggingView;

@end

@implementation Canvas


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        CircleView *circleView = (CircleView *)touch.view;
        if (CGRectContainsPoint(circleView.frame, touchLocation)) {
            circleView.circle.isLifted = YES;
//            circleView.alpha = 0.5;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        CircleView *circleView = (CircleView *)touch.view;
        circleView.circle.center = CGPointMake(touchLocation.x, 768-touchLocation.y);
        [self.controller liftCircle:circleView.circle];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        CircleView *circleView = (CircleView *)touch.view;
        circleView.circle.center = CGPointMake(touchLocation.x, 768-touchLocation.y);
        [self.controller dropCircle:circleView.circle];


    }
}

@end
