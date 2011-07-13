//
//  MenuLayer.m
//  DiscoTech Controller
//
//  Created by D. Grayson Smith on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"

@implementation MenuLayer

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Menu" fontName:@"Helvetica" fontSize:48];
    
    CCMenuItemFont *robot = [CCMenuItemFont itemFromString:@"Start Robot Control" target:self selector:@selector(onRobotController:)];
    CCMenu *menu = [CCMenu menuWithItems:robot, nil];
    
    title.position = ccp(240, 220);
    [self addChild: title];
    
    menu.position = ccp(240, 120);
    [menu alignItemsVerticallyWithPadding:40.0f];
    [self addChild:menu z:2];
    
    return self;
}

-(void)onRobotController:(id)sender
{
    [SceneManager goRobot];
}

@end

