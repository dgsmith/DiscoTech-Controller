//
//  RobotLayer.m
//  DiscoTech Controller
//
//  Created by D. Grayson Smith on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RobotLayer.h"

#import "SneakyButton.h"
#import "SneakyJoystick.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "ColoredCircleSprite.h"
#import "ColoredSquareSprite.h"

#import "SendUDP.h"

@implementation RobotLayer
int count = 0;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RobotLayer *layer = [RobotLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (id)init
{
    self = [super init];
    if (self) {        
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector:@selector(back:)];
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(size.width/2, 50);
        [self addChild:menu];
        
        check = [CCLabelTTF labelWithString:@"" 
                                   fontName:@"Helvetica" 
                                   fontSize:20];
        check.position =            ccp(size.width/2, 20);
        [self addChild:check];
        
        SneakyJoystickSkinnedBase *throttleJoy = [[SneakyJoystickSkinnedBase alloc] init];
        throttleJoy.position =          ccp(130,size.height/2);
        throttleJoy.backgroundSprite =  [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:100];
        throttleJoy.thumbSprite =       [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:40];
        throttleJoy.joystick =          [[[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,100,100)] autorelease];
        throttleJoystick = [throttleJoy.joystick retain];
        throttleJoystick.deadRadius = 10;
        throttleJoystick.hasDeadzone = YES;
        [self addChild:throttleJoy];
        [throttleJoy release];
        [throttleJoystick release];
        
        SneakyJoystickSkinnedBase *steeringJoy = [[SneakyJoystickSkinnedBase alloc] init];
        steeringJoy.position =         ccp(400, 80);
        steeringJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:50];
        steeringJoy.thumbSprite =      [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:25];
        steeringJoy.joystick =         [[[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,50,50)] autorelease];
        steeringJoystick.hasDeadzone = YES;
        steeringJoystick.deadRadius = 10;
        steeringJoystick = [steeringJoy.joystick retain];
        [self addChild:steeringJoy];
        [steeringJoy release];
        [steeringJoystick release];
        
        SneakyJoystickSkinnedBase *leftArmJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        leftArmJoy.position =           ccp(280, 270);
        leftArmJoy.backgroundSprite =   [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        leftArmJoy.thumbSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
        leftArmJoy.joystick =           [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 32, 32)] autorelease];
        leftArmJoystick = [leftArmJoy.joystick retain];
        [self addChild:leftArmJoy];
        
        SneakyJoystickSkinnedBase *rightArmJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        rightArmJoy.position =           ccp(380, 270);
        rightArmJoy.backgroundSprite =   [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        rightArmJoy.thumbSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
        rightArmJoy.joystick =           [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 32, 32)] autorelease];
        rightArmJoystick = [rightArmJoy.joystick retain];
        [self addChild:rightArmJoy];
        
        SneakyButtonSkinnedBase *ledBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        ledBut.position =           ccp(330, 190);
        ledBut.defaultSprite =      [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        //ledBut.activatedSprite =    [CCSprite spriteWithFile:@"p3.png"];
        ledBut.pressSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 255, 0, 128) radius:32];
        ledBut.button =             [[[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)] autorelease];
        led = [ledBut.button retain];
        led.isToggleable = NO;
        led.isHoldable = YES;
        [self addChild:ledBut];
        
		[self scheduleUpdate];
    }
    return self;
}

-(void) update: (ccTime) dt
{
    int t,s;
    float ttemp, stemp;
    ttemp = throttleJoystick.stickPosition.y;
    t = roundf(((ttemp + 100)*255)/200);
    stemp = throttleJoystick.stickPosition.x;
    s = roundf(((stemp+100)*255)/200);
    
    int h,v;
    float htemp, vtemp;
    htemp = steeringJoystick.stickPosition.x;
    h = roundf(((htemp+50)*255)/100);
    vtemp = steeringJoystick.stickPosition.y;
    v = roundf(((vtemp+50)*255)/100);
        
    int l,r;
    float ltemp,rtemp;
    ltemp = leftArmJoystick.stickPosition.y;
    l = roundf(((ltemp+32)*255)/64);
    rtemp = rightArmJoystick.stickPosition.y;
    r = roundf(((rtemp+32)*255)/64);
    
    int ledOn;
    if (led.active) {
        ledOn = 1;
    } else {
        ledOn = 0;
    }
    
    data[0] = 'b';
    data[1] = (unsigned char) t;
    data[2] = (unsigned char) s;
    data[3] = (unsigned char) h;
    data[4] = (unsigned char) v;
    data[5] = (unsigned char) l;
    data[6] = (unsigned char) r;
    data[7] = (unsigned char) 128;
    data[8] = (unsigned char) ledOn;
    data[9] = 'e';
    
    //check.string = [NSString stringWithCharacters:data length:10];
    
    SUDP_SendMsg(data, 10);
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


-(void)back:(id)sender
{
    [SceneManager goMenu];
}

@end
