//
//  Circle.m
//  Circle
//
//  Created by Titi on 9/24/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "Circle.h"
#import "CircleConfig.h"
#import "Velocity.h"

@implementation Circle

+ (instancetype)randomCircle
{
    NSUInteger size = RandomBetween(CircleMinSize, CircleMaxSize);
    
    CGFloat centerX = RandomBetween(size, ((int16_t)CanvasWidth-size));
    CGFloat centerY = RandomBetween(size, ((int16_t)CanvasHeight-size));
    
    // Fixme: - velocity
    float vx = RandomBetween(CircleMinVelociy, CircleMaxVelociy);
    float signedVx = vx*(arc4random()%2? 1:-1);
    float vy = RandomBetween(CircleMinVelociy, CircleMaxVelociy);
    float signedVy = vy*(arc4random()%2? 1:-1);
    
    Velocity *v = [[Velocity alloc] initWithX:signedVx y:signedVy];
    return [[Circle alloc] initWithCenter:CGPointMake(centerX, centerY) size:size velocity:v];
}

+(Circle *)circleWithCenter:(CGPoint)center size:(float)size velocity:(Velocity *)v
{
    return [[self alloc] initWithCenter:center size:size velocity:v];
}

-(instancetype)initWithCenter:(CGPoint)center size:(float)size velocity:(Velocity *)v
{
    self = [super init];
    
    if (self){
        _center = center;
        _size = size;
        _v = v;
        
        [self addObserver:self forKeyPath:@"isLifted" options:NSKeyValueObservingOptionInitial |NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isLifted"];
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isLifted"]) {
        if (self.isLifted){
            self.v = [Velocity new];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - Private

- (void)checkVelocity
{
    if ((self.center.x-self.size) <= 0){
        [self.v moveRight];
    }
    if (self.center.x+self.size >= CanvasWidth)
    {
        [self.v moveLeft];
    }
    if (self.center.y-self.size <= 0){
        [self.v moveTop];
    }
    if (self.center.y+self.size >= CanvasHeight){
        [self.v moveBottom];
    }
}

- (float)contactAngleWithCircle:(Circle *)aCircle
{
    return atan2f((aCircle.center.y - self.center.y), (aCircle.center.x - self.center.x));
}

- (float)bouncedVelocityAtXAxisWithM1:(float)m1
                                   m2:(float)m2
                                   v1:(Velocity *)v1
                                   v2:(Velocity *)v2
                         contactAngle:(float)contactAngle{
    return (v1.scalarVelocity*cosf(v1.angle-contactAngle)*(m1-m2) + 2*m2*v2.scalarVelocity*cosf(v2.angle-contactAngle))*cosf(contactAngle)/(m1+m2)
    +v1.scalarVelocity*sinf(v1.angle-contactAngle)*cosf(contactAngle+M_PI/2);
}

- (float)bouncedVelocityAtYAxisWithM1:(float)m1
                                   m2:(float)m2
                                   v1:(Velocity *)v1
                                   v2:(Velocity *)v2
                         contactAngle:(float)contactAngle{
    return (v1.scalarVelocity*cosf(v1.angle-contactAngle)*(m1-m2) + 2*m2*v2.scalarVelocity*cosf(v2.angle-contactAngle))*sinf(contactAngle)/(m1+m2)
    +v1.scalarVelocity*sinf(v1.angle-contactAngle)*sinf(contactAngle+M_PI_2);
    
}

#pragma mark Public

- (void)combineWithCircle:(Circle *)aCircle
{
    self.size += aCircle.size;
}

- (BOOL)shouldBounceOffCircle:(Circle *)circle{
    double distance = sqrt((self.center.x-circle.center.x)*(self.center.x-circle.center.x) + (self.center.y-circle.center.y)*(self.center.y-circle.center.y));
    BOOL result = (distance <= (self.size+circle.size));
    
    return result;
}

- (void)changeVelocityAfterBounceOffCircle:(Circle *)circle{
    
    float contactAngle = [self contactAngleWithCircle:circle];
    float c1vx = [self bouncedVelocityAtXAxisWithM1:self.size m2:circle.size v1:self.v v2:circle.v contactAngle:contactAngle];
    float c2vx = [self bouncedVelocityAtXAxisWithM1:circle.size m2:self.size v1:circle.v v2:self.v contactAngle:contactAngle];
    float c1vy = [self bouncedVelocityAtYAxisWithM1:self.size m2:circle.size v1:self.v v2:circle.v contactAngle:contactAngle];
    float c2vy = [self bouncedVelocityAtYAxisWithM1:circle.size m2:self.size v1:circle.v v2:self.v contactAngle:contactAngle];
    
    self.v.vx = c1vx;
    self.v.vy = c1vy;
    circle.v.vx = c2vx;
    circle.v.vy = c2vy;
}

- (void)move
{
    self.center = CGPointMake(self.center.x+self.v.vx, self.center.y+self.v.vy);
    
    [self checkVelocity];
}

@end
