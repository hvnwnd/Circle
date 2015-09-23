//
//  ViewController.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "ViewController.h"
#import "Circle.h" 
#import "Velocity.h"

@interface ViewController ()
@property (nonatomic) NSMutableSet *set;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.set = [NSMutableSet set];
    NSUInteger count = 5;
    // show circles
    for (uint i = 0; i < count; i++) {
        Circle *circle =         [Circle randomCircle];
        [self.view addSubview:circle];
        [self.set addObject:circle];
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(moveCircles) userInfo:nil repeats:YES];
}
- (void) moveCircles
{
    for (Circle *circle in self.set) {
        circle.transform = CGAffineTransformTranslate(circle.transform, circle.v.vx, circle.v.vy);
        NSLog(@"%@", NSStringFromCGRect(circle.frame));
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end