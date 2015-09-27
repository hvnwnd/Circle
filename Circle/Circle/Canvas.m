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

- (void)prepareForGame{
    
    for (Circle *circle in self.controller.circles) {
        CircleView *circleView = [CircleView randomColorCircleViewWithCircle:circle];
        [self addSubview:circleView];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        CircleView *circleView = (CircleView *)touch.view;
        if (!circleView.circle.isFinal && CGRectContainsPoint(circleView.frame, touchLocation)){
            circleView.circle.isLifted = YES;
            [self bringSubviewToFront:circleView];
            [self.controller liftCircle:circleView.circle];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        CircleView *circleView = (CircleView *)touch.view;
        circleView.circle.center = CGPointMake(touchLocation.x, 768-touchLocation.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        
        CircleView *circleView = (CircleView *)touch.view;
        if (circleView.circle.isFinal){
            [circleView removeFromSuperview];
            [self prepareForGame];
            [self.controller startGame];
        }else{
            CircleView *biggerCircleView;
            for (CircleView *subview in self.subviews) {
                // find bigger circle
                if (subview != circleView && CGRectContainsRect(subview.frame, circleView.frame))
                {
                    biggerCircleView = subview;
                    break;
                }
            }
            
            if (biggerCircleView){
                [self.controller dropCircle:circleView.circle inCircle:biggerCircleView.circle];
                [circleView removeFromSuperview];
            }else{
                [self.controller dropCircle:circleView.circle inCircle:nil];
            }
        }
    }
}

@end
