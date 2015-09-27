//
//  Canvas.m
//  Circle
//
//  Created by Bin CHEN on 9/26/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Canvas.h"

#import "CircleConfig.h"

#import "CircleView.h"
#import "Circle.h"
#import "GameController.h"

NSString *const ShouldStartGameNotification = @"ShouldStartGameNotification";

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
        circleView.circle.center = CGPointMake(touchLocation.x, CanvasHeight-touchLocation.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([[touch.view class] isSubclassOfClass:[CircleView class]]) {
        
        CircleView *circleView = (CircleView *)touch.view;
        if (circleView.circle.isFinal){
            [circleView removeFromSuperview];
            [[NSNotificationCenter defaultCenter] postNotificationName:ShouldStartGameNotification object:nil];
        }else{
            CircleView *biggerCircleView = [self findBiggerCircleViewThanCircleView:circleView];
            if (biggerCircleView){
                [self.controller dropCircle:circleView.circle inCircle:biggerCircleView.circle];
                [circleView removeFromSuperview];
            }else{
                [self.controller dropCircle:circleView.circle inCircle:nil];
            }
        }
    }
}
- (CircleView *)findBiggerCircleViewThanCircleView:(CircleView *)circleView{
    CircleView *biggerCircleView;
    for (CircleView *subview in self.subviews) {
        // find bigger circle
        if (subview != circleView && circleView.frame.size.width < subview.frame.size.width &&
            (CGRectContainsRect(subview.frame, circleView.frame) || CGRectIntersectsRect(subview.frame, circleView.frame)))
        {
            biggerCircleView = subview;
            break;
        }
    }
    return biggerCircleView;
    
    
}
@end
