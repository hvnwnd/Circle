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
#define CircleMinSize       20
#define CircleMaxSize       100

// pixel unit
#define CircleMinVelociy    1
#define CircleMaxVelociy    5

#define CanvasFrame CGRectMake(0, 0, 1024, 768)

#define RandomBetween(from,to) ((int)from + arc4random() % (to-from+1))

#endif /* CircleConfig_h */
