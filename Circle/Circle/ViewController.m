//
//  ViewController.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h" 
#import "Velocity.h"
#import "CircleConfig.h"
#import "GameController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GameController *controller = [GameController new];
    // show circles
    
    for (Circle *circle in controller.circles) {
        CircleView *circleView = [CircleView randomColorCircleViewWithCircle:circle];
        [self.view addSubview:circleView];
    }
    
    [controller startGame];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
