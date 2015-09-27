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
#import "CirclesProvider.h"

@interface ViewController ()
@property (nonatomic) UIView *maskView;
@property (nonatomic) GameController *gameController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startGame:) name:ShouldStartGameNotification object:nil];
    [self startGame:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startGame:(NSNotification *)notificaiton
{
    self.gameController = [[GameController alloc] initWithCircles:[CirclesProvider randomCircles]];
    Canvas *canvas = (Canvas *) self.view;
    canvas.controller = self.gameController;
    [canvas prepareForGame];
    [self.gameController startGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
