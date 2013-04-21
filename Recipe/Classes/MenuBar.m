//
//  MenuBar.m
//  Recipe
//
//  Created by xiaofeng chen on 11-9-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuBar.h"


@implementation MenuBar

-(id) init
{
	if( (self=[super init])) {
		CGSize s = [[CCDirector sharedDirector] winSize];
        self.position=ccp(0,s.height-40);
		CCSprite *background= [CCSprite spriteWithFile:@"menubar.png"];
		background.position=ccp(s.width/2,20);
		[self addChild:background z:0];
		//self.color=ccc4(255, 255, 255, 128);
       self.contentSize=CGSizeMake(s.width, 40);
		timer=[CCMenuItemImage itemFromNormalImage:@"clock.png" selectedImage:@"clock.png" target:nil selector:@selector(timerCount:)];
		back=[CCMenuItemImage itemFromNormalImage:@"return.png" selectedImage:@"return_onPress.png" target:nil selector:@selector(goback:)];
		CCMenu *Time=[CCMenu menuWithItems:timer,back,nil];
		Time.position=ccp(100,20);
		back.position=ccp(140,0);
   
		[self addChild:Time z:1];
		
	}
	return self;
}

-(void)timerCount:(id)sender
{
}

-(void)goback:(id)sender
{}




- (void) dealloc
{
	[super dealloc];
}

@end

