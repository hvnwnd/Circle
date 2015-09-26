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
    return [[CircleView alloc] initWithCircle:circle color:nil];
}

- (instancetype)initWithCircle:(Circle *)circle color:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake(circle.center.x-circle.size, circle.center.y-circle.size, circle.size*2, circle.size*2)];
    
    if (self)
    {
        _circle = circle;
        if (color){
            _color = color;
        }else{
            _color =    [UIColor colorWithRed:RandomBetween(0,255)/255.0
                                    green:RandomBetween(0,255)/255.0
                                     blue:RandomBetween(0,255)/255.0
                                    alpha:0.8];

        }
        self.backgroundColor = [UIColor clearColor];
        
        [self addObserver:self forKeyPath:@"circle.center" options:(NSKeyValueObservingOptionInitial
         | NSKeyValueObservingOptionNew) context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self.circle forKeyPath:@"center"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"circle.center"]) {
        self.center = CGPointMake(self.circle.center.x, 768 - self.circle.center.y) ;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([self.color CGColor]));
    
    CGContextFillPath(ctx);
    
    UIFont *font =[UIFont systemFontOfSize:16.0];
    CGFloat fontHeight = font.pointSize;
    CGFloat yOffset = (rect.size.height - fontHeight) / 2.0;
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;

//    NSString *sizeString = [NSString stringWithFormat:@"%ld", (unsigned long)self.circle.size];
//    [sizeString drawInRect:
//     CGRectMake(0, yOffset, rect.size.width, fontHeight)
//            withAttributes:@{NSFontAttributeName:font,
//                             NSForegroundColorAttributeName:[UIColor whiteColor],
//                             NSParagraphStyleAttributeName:paragraphStyle}];

}

@end
