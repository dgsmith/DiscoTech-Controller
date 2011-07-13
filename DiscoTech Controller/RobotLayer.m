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
        
        NSString *ipAddress = @"192.168.1.102";
        SUDP_Init([ipAddress cStringUsingEncoding:NSASCIIStringEncoding]);
        
        CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector:@selector(back:)];
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(size.width/2, 50);
        [self addChild:menu];
        
        check = [CCLabelTTF labelWithString:@"" 
                                   fontName:@"Helvetica" 
                                   fontSize:20];
        check.position =            ccp(size.width/2, 20);
        [self addChild:check];
        
        SneakyJoystickSkinnedBase *throttleJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        throttleJoy.position =          ccp(130,size.height/2);
        throttleJoy.backgroundSprite =  [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:100];
        throttleJoy.thumbSprite =       [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:40];
        throttleJoy.joystick =          [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,100,100)];
        throttleJoystick = [throttleJoy.joystick retain];
        throttleJoystick.deadRadius = 10;
        throttleJoystick.hasDeadzone = YES;
        [self addChild:throttleJoy];
        
        
        SneakyJoystickSkinnedBase *steeringJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        steeringJoy.position =         ccp(400, 80);
        steeringJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:50];
        steeringJoy.thumbSprite =      [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:25];
        steeringJoy.joystick =         [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,50,50)];
        steeringJoystick.hasDeadzone = YES;
        steeringJoystick.deadRadius = 10;
        steeringJoystick = [steeringJoy.joystick retain];
        [self addChild:steeringJoy];
        
        SneakyJoystickSkinnedBase *leftArmJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        leftArmJoy.position =           ccp(280, 270);
        leftArmJoy.backgroundSprite =   [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        leftArmJoy.thumbSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
        leftArmJoy.joystick =           [[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 32, 32)];
        leftArmJoystick = [leftArmJoy.joystick retain];
        [self addChild:leftArmJoy];
        
        SneakyJoystickSkinnedBase *rightArmJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        rightArmJoy.position =           ccp(380, 270);
        rightArmJoy.backgroundSprite =   [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        rightArmJoy.thumbSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
        rightArmJoy.joystick =           [[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 32, 32)];
        rightArmJoystick = [rightArmJoy.joystick retain];
        [self addChild:rightArmJoy];
        
        /*
        SneakyButtonSkinnedBase *lArmUpBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        lArmUpBut.position =        ccp(280, 125);
        lArmUpBut.defaultSprite =   [CCSprite spriteWithFile:@"right2.png"];
        //lArmUpBut.activatedSprite = [CCSprite spriteWithFile:@"right3.png"];
        lArmUpBut.pressSprite =     [CCSprite spriteWithFile:@"right1.png"];
        lArmUpBut.button =          [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        lArmUp = [lArmUpBut.button retain];
        lArmUp.isToggleable = NO;
        lArmUp.isHoldable = YES;
        [self addChild:lArmUpBut];
        
        SneakyButtonSkinnedBase *lArmDnBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        lArmDnBut.position =        ccp(225, 125);
        lArmDnBut.defaultSprite =   [CCSprite spriteWithFile:@"left2.png"];
        //lArmDnBut.activatedSprite = [CCSprite spriteWithFile:@"left3.png"];
        lArmDnBut.pressSprite =     [CCSprite spriteWithFile:@"left1.png"];
        lArmDnBut.button =          [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        lArmDn = [lArmDnBut.button retain];
        lArmDn.isToggleable = NO;
        lArmDn.isHoldable = YES;
        [self addChild:lArmDnBut];
        
        SneakyButtonSkinnedBase *rArmUpBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        rArmUpBut.position =        ccp(280, 90);
        rArmUpBut.defaultSprite =   [CCSprite spriteWithFile:@"right2.png"];
        //rArmUpBut.activatedSprite = [CCSprite spriteWithFile:@"right3.png"];
        rArmUpBut.pressSprite =     [CCSprite spriteWithFile:@"right1.png"];
        rArmUpBut.button =          [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        rArmUp = [rArmUpBut.button retain];
        rArmUp.isToggleable = NO;
        rArmUp.isHoldable = YES;
        [self addChild:rArmUpBut];
        
        SneakyButtonSkinnedBase *rArmDnBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        rArmDnBut.position =        ccp(225, 90);
        rArmDnBut.defaultSprite =   [CCSprite spriteWithFile:@"left2.png"];
        //rArmDnBut.activatedSprite = [CCSprite spriteWithFile:@"left3.png"];
        rArmDnBut.pressSprite =     [CCSprite spriteWithFile:@"left1.png"];
        rArmDnBut.button =          [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        rArmDn = [rArmDnBut.button retain];
        rArmDn.isToggleable = NO;
        rArmDn.isHoldable = YES;
        [self addChild:rArmDnBut];
        */
        
        SneakyButtonSkinnedBase *ledBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        ledBut.position =           ccp(330, 190);
        ledBut.defaultSprite =      [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        //ledBut.activatedSprite =    [CCSprite spriteWithFile:@"p3.png"];
        ledBut.pressSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 255, 0, 128) radius:32];
        ledBut.button =             [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        led = [ledBut.button retain];
        led.isToggleable = NO;
        led.isHoldable = YES;
        [self addChild:ledBut];
        
        /*
        SneakyButtonSkinnedBase *eyesLBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        eyesLBut.position =         ccp(185,125);
        eyesLBut.defaultSprite =    [CCSprite spriteWithFile:@"up2.png"];
        //eyesLBut.activatedSprite =  [CCSprite spriteWithFile:@"up3.png"];
        eyesLBut.pressSprite =      [CCSprite spriteWithFile:@"up1.png"];
        eyesLBut.button =           [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        eyesL = [eyesLBut.button retain];
        eyesL.isToggleable = NO;
        eyesL.isHoldable = YES;
        [self addChild:eyesLBut];
        
        SneakyButtonSkinnedBase *eyesRBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        eyesRBut.position =         ccp(185,50);
        eyesRBut.defaultSprite =    [CCSprite spriteWithFile:@"down2.png"];
        //eyesRBut.activatedSprite =  [CCSprite spriteWithFile:@"down3.png"];
        eyesRBut.pressSprite =      [CCSprite spriteWithFile:@"down1.png"];
        eyesRBut.button =           [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)];
        eyesR = [eyesRBut.button retain];
        eyesR.isToggleable = NO;
        eyesR.isHoldable = YES;
        [self addChild:eyesRBut];
        */
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
    
    /*
    if ((lArmUp.active && lArmDn.active) || (!lArmUp.active && !lArmDn.active)) {
        leftArm = @"001";
    } else {
        if (lArmUp.active) {
            leftArm = @"002";
        } else {
            leftArm = @"000";
        }
    }
    
    if ((rArmUp.active && rArmDn.active) || (!rArmUp.active && !rArmDn.active)) {
        rightArm = @"001";
    } else {
        if (rArmUp.active) {
            rightArm = @"002";
        } else {
            rightArm = @"000";
        }
    }
    
    if ((eyesL.active && eyesR.active) || (!eyesL.active && !eyesR.active)) {
        eyes = @"001";
    } else {
        if (eyesR.active) {
            eyes = @"002";
        } else {
            eyes = @"000";
        }
    }
    
    if (led.active) {
        ledControl = @"001";
    } else {
        ledControl = @"000";
    }
    */
    
    [self schedule:@selector(updateRobot) interval:.3];
}

-(void) updateRobot
{
    //SUDP_SendMsg(data, 10);
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
