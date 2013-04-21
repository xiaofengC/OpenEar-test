//
//  OpenEarController.h
//  Recipe
//
//  Created by xiaofeng chen on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "AudioSessionManager.h"
#import "OpenEarsEventsObserver.h"
#import "PocketsphinxController.h"
#import "FliteController.h"
//#import "SimpleAudioEngine.h"

@interface OpenEarController : NSObject <OpenEarsEventsObserverDelegate>  {
	
	OpenEarsEventsObserver *openEarsEventsObserver; // A class whose delegate methods which will allow us to stay informed of changes in the Audio Session, Flite and Pocketsphinx statuses.
	PocketsphinxController *pocketsphinxController; // The controller for Pocketsphinx (voice recognition).
//	FliteController *fliteController; // The controller for Flite (speech).
	

}

@property (nonatomic, retain) OpenEarsEventsObserver *openEarsEventsObserver;
@property (nonatomic, retain) PocketsphinxController *pocketsphinxController;


- (id) init ;

@end
