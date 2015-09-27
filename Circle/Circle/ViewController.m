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
#import "Canvas.h"

@interface ViewController () <GameControllerDelegate>
@property (nonatomic) UIView *maskView;
@property (nonatomic) GameController *gameController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameController = [GameController new];
    self.gameController.delegate = self;
    Canvas *canvas = (Canvas *) self.view;
    canvas.controller = self.gameController;
    
    [self startGame];
}

- (void)gameDidStop
{
    Canvas *canvas = (Canvas *) self.view;
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startGame)];
    
    CircleView *view = [[canvas subviews] lastObject];
    [view addGestureRecognizer:tgr];
    
}
- (void)startGame{
    for (Circle *circle in self.gameController.circles) {
        CircleView *circleView = [CircleView randomColorCircleViewWithCircle:circle];
        [self.view addSubview:circleView];
    }
    
    [self.gameController startGame];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
