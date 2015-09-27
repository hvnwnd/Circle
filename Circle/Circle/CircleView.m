//
//  Circle.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "CircleView.h"
#import "Velocity.h"
#import "CircleConfig.h"
#import "Circle.h"

@import CoreGraphics;

@implementation CircleView

+ (instancetype)randomColorCircleViewWithCircle:(Circle *)circle
{
    UIColor *color =    [UIColor colorWithRed:RandomBetween(0,255)/255.0
                                        green:RandomBetween(0,255)/255.0
                                         blue:RandomBetween(0,255)/255.0
                                        alpha:1.0f];
    
    return [[CircleView alloc] initWithCircle:circle color:color];
}

- (instancetype)initWithCircle:(Circle *)circle color:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake(circle.center.x-circle.size, circle.center.y-circle.size, circle.size*2, circle.size*2)];
    
    if (self)
    {
        _circle = circle;
        _color = color;
        self.backgroundColor = [UIColor clearColor];
        
        [self.circle addObserver:self forKeyPath:@"center" options:(NSKeyValueObservingOptionInitial
                                                                    | NSKeyValueObservingOptionNew) context:NULL];
        [self.circle addObserver:self forKeyPath:@"isLifted" options:(NSKeyValueObservingOptionInitial
                                                                      | NSKeyValueObservingOptionNew) context:NULL];
        [self.circle addObserver:self forKeyPath:@"size" options:(NSKeyValueObservingOptionInitial
                                                                  | NSKeyValueObservingOptionNew) context:NULL];
        
    }
    return self;
}

- (void)dealloc
{
    [self.circle removeObserver:self forKeyPath:@"center"];
    [self.circle removeObserver:self forKeyPath:@"isLifted"];
    [self.circle removeObserver:self forKeyPath:@"size"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"center"]) {
        self.center = CGPointMake(self.circle.center.x, CanvasHeight - self.circle.center.y) ;
    } else if ([keyPath isEqualToString:@"isLifted"]){
        self.alpha = self.circle.isLifted ? 0.5:1.0;
    }else  if ([keyPath isEqualToString:@"size"]){
        CGFloat oldSize = self.frame.size.width/2;
        CGFloat newSize = self.circle.size;
        CGFloat scale = newSize/oldSize;
        
        CGAffineTransform transform = CGAffineTransformScale(self.transform, scale, scale);
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = transform;
        } completion:^(BOOL finished) {
            self.frame = CGRectApplyAffineTransform(self.frame, transform);
            self.transform = CGAffineTransformIdentity;
            [self setNeedsDisplay];
        }];
        
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([self.color CGColor]));
    
    CGContextFillPath(ctx);
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;

    if (self.circle.isFinal){
        UIFont *font =[UIFont systemFontOfSize:50.0];
        CGFloat fontHeight = font.pointSize;

        UIImage *bravo = [UIImage imageNamed:@"bravo"];
        [bravo drawAtPoint:CGPointMake(CGRectGetMidX(rect)-bravo.size.width/2, CGRectGetMidY(rect)-bravo.size.height/2-5.0)];
        
        [@"Try Again ?" drawInRect:
         CGRectMake(0, CGRectGetMidY(rect)+bravo.size.height/2, rect.size.width, fontHeight+10.0)
                withAttributes:@{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSParagraphStyleAttributeName:paragraphStyle}];

    }else{
        UIFont *font =[UIFont systemFontOfSize:self.circle.size/2.0];
        CGFloat fontHeight = font.pointSize;
        CGFloat yOffset = (rect.size.height - fontHeight) / 2.0;

        NSString *sizeString = [NSString stringWithFormat:@"%ld", (unsigned long)self.circle.size];
        [sizeString drawInRect:
         CGRectMake(0, yOffset, rect.size.width, fontHeight)
                withAttributes:@{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSParagraphStyleAttributeName:paragraphStyle}];
    }
    
}


@end
