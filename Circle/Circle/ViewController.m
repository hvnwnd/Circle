//
//  ViewController.m
//  Circle
//
//  Created by Titi on 9/23/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#import "ViewController.h"
#import "Circle.h" 

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUInteger count = 5;
    // show circles
    for (uint i = 0; i < count; i++) {
        [self.view addSubview:[Circle randomCircle]];
    }
    
    // move circles
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
