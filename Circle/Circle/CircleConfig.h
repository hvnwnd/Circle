//
//  CircleConfig.h
//  Circle
//
//  Created by CHEN Bin on 24/09/15.
//  Copyright © 2015 Fantestech. All rights reserved.
//

#ifndef CircleConfig_h
#define CircleConfig_h

#define CircleCount         5

#define CircleMoveInterval 0.02
#define CircleMinSize       30
#define CircleMaxSize       60

// pixel unit
#define CircleMinVelociy    1
#define CircleMaxVelociy    3

#define CanvasWidth 1024.0f
#define CanvasHeight 768.0f
#define CanvasFrame CGRectMake(0, 0, CanvasWidth, CanvasHeight)

#define RandomBetween(from,to) ((int)from + arc4random() % (to-from+1))

#endif /* CircleConfig_h */
