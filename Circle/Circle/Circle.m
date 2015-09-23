//
//  Circle.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Circle.h"
#import "Velocity.h"

@import CoreGraphics;

@implementation Circle

+(Circle *)circleWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v color:(UIColor *)color
{
    return [[self alloc] initWithCenter:center size:size velocity:v color:color];
}

+(Circle *)randomCircle
{
    NSUInteger size = [[self class] getRandomNumberBetween:20 to:100];
    
    CGFloat centerX = [[self class] getRandomNumberBetween:size to:(1024-size)];
    CGFloat centerY = [[self class] getRandomNumberBetween:size to:(768-size)];
    
    UIColor *color = [UIColor colorWithRed:[[self class] getRandomNumberBetween:0 to:255]/255.0
                                     green:[[self class] getRandomNumberBetween:0 to:255]/255.0
                                      blue:[[self class] getRandomNumberBetween:0 to:255]/255.0
                                     alpha:0.8];
    
    float vx = [[self class] getRandomNumberBetween:1 to:10];
    float vy = [[self class] getRandomNumberBetween:1 to:10];
    return [[self alloc] initWithCenter:CGPointMake(centerX, centerY) size:size velocity:[[Velocity alloc] initWithX:vx y:vy] color:color];

}

-(instancetype)initWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v color:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake(center.x-size, center.y-size, size*2, size*2)];
    
    if (self){
        _size = size;
        _v = v;
        _color = color;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (Circle *)compineWithCircle:(Circle *)aCircle
{
    return [Circle circleWithCenter:aCircle.center size:aCircle.size+self.size velocity:aCircle.v color:aCircle.color];
}

- (void)bumpToCircle:(Circle *)circle{
    // change velocity of each other
}

- (void)bumpToWall
{
    // change velocity
    
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

    NSString *sizeString = [NSString stringWithFormat:@"%ld", (unsigned long)self.size];
    [sizeString drawInRect:
     CGRectMake(0, yOffset, rect.size.width, fontHeight)
            withAttributes:@{NSFontAttributeName:font,
                             NSForegroundColorAttributeName:[UIColor whiteColor],
                             NSParagraphStyleAttributeName:paragraphStyle}];

}

+(int)getRandomNumberBetween:(NSUInteger)from to:(NSUInteger)to {
    
    return (int)from + arc4random() % (to-from+1);
}


@end
