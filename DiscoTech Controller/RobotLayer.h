//
//  RobotLayer.h
//  DiscoTech Controller
//
//  Created by D. Grayson Smith on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "SceneManager.h"

@class SneakyJoystick;
@class SneakyButton;

@interface RobotLayer : CCLayer
{
    SneakyJoystick *throttleJoystick;
    SneakyJoystick *steeringJoystick;
    SneakyJoystick *leftArmJoystick;
    SneakyJoystick *rightArmJoystick;
    
    SneakyButton *led;
    SneakyButton *eyesL;
    SneakyButton *eyesR;
    
    CCLabelTTF *check;
    
    unsigned char data[10];
}

-(void)back:(id)sender;

+(CCScene *) scene;

-(void) updateRobot;

@end

