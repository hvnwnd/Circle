//
//  Circle.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Circle.h"
#import "Velocity.h"
#import "CircleConfig.h"

#define CanvasFrame CGRectMake(0, 0, 1024, 768)

@import CoreGraphics;

@implementation Circle

+(Circle *)circleWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v color:(UIColor *)color
{
    return [[self alloc] initWithCenter:center size:size velocity:v color:color];
}

+(Circle *)randomCircle
{
    NSUInteger size = [[self class] getRandomNumberBetween:CircleMinSize to:CircleMaxSize];
    
    CGFloat centerX = [[self class] getRandomNumberBetween:size to:(1024-size)];
    CGFloat centerY = [[self class] getRandomNumberBetween:size to:(768-size)];
    
    UIColor *color = [UIColor colorWithRed:[[self class] getRandomNumberBetween:0 to:255]/255.0
                                     green:[[self class] getRandomNumberBetween:0 to:255]/255.0
                                      blue:[[self class] getRandomNumberBetween:0 to:255]/255.0
                                     alpha:0.8];
    // Fixme: - velocity
    float vx = [[self class] getRandomNumberBetween:CircleMinVelociy to:CircleMaxVelociy];
    float vy = [[self class] getRandomNumberBetween:CircleMinVelociy to:CircleMaxVelociy];
    
    return [[self alloc] initWithCenter:CGPointMake(centerX, centerY) size:size velocity:[[Velocity alloc] initWithX:vx y:vy] color:color];

}

-(instancetype)initWithCenter:(CGPoint)center size:(NSUInteger)size velocity:(Velocity *)v color:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake((CGFloat)center.x-size, (CGFloat)center.y-size, (CGFloat)size*2,(CGFloat) size*2)];
    
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


- (BOOL)shouldBumpToCircle:(Circle *)circle{
    double distance = sqrt((self.center.x-circle.center.x)*(self.center.x-circle.center.x) + (self.center.y-circle.center.y)*(self.center.y-circle.center.y));
    
    return distance <= (self.size+circle.size);
}

- (void)changeVelocityAfterBumpToCircle:(Circle *)circle{
    // change velocity of each other
    
    float c1vx = [self bumpedVelocityWithM1:self.size m2:circle.size v1:self.v.vx v2:circle.v.vx];
    float c2vx = [self bumpedVelocityWithM1:circle.size m2:self.size v1:circle.v.vx v2:self.v.vx];
    float c1vy = [self bumpedVelocityWithM1:self.size m2:circle.size v1:self.v.vy v2:circle.v.vy];
    float c2vy = [self bumpedVelocityWithM1:circle.size m2:self.size v1:circle.v.vy v2:self.v.vy];
    
    self.v.vx = c1vx;
    self.v.vy = c1vy;
    circle.v.vx = c2vx;
    circle.v.vy = c2vy;
}

- (float)bumpedVelocityWithM1:(NSUInteger)m1
                                m2:(NSUInteger)m2
                                v1:(float)v1
                                v2:(float)v2{
    return ((NSInteger)(m1-m2)*v1+2*m2*v2)/(float)(m1+m2);
}

- (void)move
{
    self.center = CGPointMake(self.center.x+self.v.vx, self.center.y+self.v.vy);
    if ([self bumpToWall]){
        if ((self.center.x-self.size) <= 0 || self.center.x+self.size >= 1024){
            [self.v bumpToLeftOrRightWall];
        }
        if (self.center.y-self.size <= 0 || self.center.y+self.size >= 768){
            [self.v bumpToUpOrBottomWall];
        }
    }
}

- (BOOL)bumpToWall
{
    return !CGRectContainsRect(CanvasFrame, CGRectMake(self.center.x-self.size, self.center.y-self.size, 2*self.size, 2*self.size));
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

- (NSString *)description{
    return [NSString stringWithFormat:@"%p(%f %f) %d %f:%f", self, self.center.x, self.center.y, self.size, self.v.vx, self.v.vy];
}
@end
