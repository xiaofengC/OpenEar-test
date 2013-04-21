//
//  RecipeAppDelegate.h
//  Recipe
//
//  Created by xiaofeng chen on 11-9-1.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioSessionManager.h"
#import "cookmenu.h"

@interface RecipeAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	AudioSessionManager *audioSessionManager;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) AudioSessionManager *audioSessionManager;
@end
