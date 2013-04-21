//
//  HelloWorldLayer.h
//  Recipe
//
//  Created by xiaofeng chen on 11-9-1.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Gamestate.h"
//#import <UIKit/UIKit.h>
//#import "OpenEarController.h"
#import "AudioSessionManager.h"
#import "OpenEarsEventsObserver.h"
#import "PocketsphinxController.h"
#import "MenuBar.h"
//#import "FliteController.h"
//#import <Foundation/Foundation.h>
//#import "AudioServices.h"

//@class FliteController;

// HelloWorld Layer
@interface HelloWorld : CCLayer <OpenEarsEventsObserverDelegate> 
{
	
	OpenEarsEventsObserver *openEarsEventsObserver; // A class whose delegate methods which will allow us to stay informed of changes in the Audio Session, Flite and Pocketsphinx statuses.
	PocketsphinxController *pocketsphinxController; // The controller for Pocketsphinx (voice recognition).
	 // The controller for Flite (speech).
	SystemSoundID audioEffect;
	int soundcount;
	float screenWidth,screenHeight;
	CGPoint screenSize;
	float viewOrgX, viewOrgY, viewOrgZ;	
	CGPoint touchpoint,prevtouchpoint;
	CCSprite * background;
	ccTime	time;
	CCMenuItem *Von,*Voff,*timer;
	//MenuBar *Bar;
	
}


@property (nonatomic, retain) OpenEarsEventsObserver *openEarsEventsObserver;
@property (nonatomic, retain) PocketsphinxController *pocketsphinxController;

@property (nonatomic, readwrite) SystemSoundID audioEffect;

+(id) scene;
-(void)Playsound: (int)num;
-(void) SetCameraPosition;

//-(void) playSound : (NSString *) fName  : (NSString *) ext;

// returns a Scene that contains the HelloWorld as the only child

//@property (nonatomic, retain) FliteController *fliteController;

@end
