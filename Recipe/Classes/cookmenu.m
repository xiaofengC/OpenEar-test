//
//  cookmenu.m
//  cooktest
//
//  Created by xiaofeng chen on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cookmenu.h"
#import "MenuBar.h"
@implementation cookmenu

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	cookmenu *layer = [cookmenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init
{
	self = [super init];
	if (self)
	{
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		CCSprite *sp = [CCSprite spriteWithFile:@"bgmenu.png"];
		//		sp.anchorPoint = CGPointZero;
		//sp.rotation = 90;
		sp.position = ccp(s.width / 2, s.height / 2);
		
		
		[self addChild:sp z:0 tag:1];
		
		[CCMenuItemFont setFontName:@"Arial"];
		[CCMenuItemFont setFontSize:25];
		
		CCMenuItem *InsMn = [CCMenuItemFont itemFromString:@"超级菜鸟" target:self selector:@selector(menu1:)];
		CCMenuItem *InvMn = [CCMenuItemFont itemFromString:@"家常小食" target:self selector:@selector(menu2:)];
		CCMenuItem *ComMn = [CCMenuItemFont itemFromString:@"单一厨具" target:self selector:@selector(menu3:)];
		
		
		CCMenu *mn = [CCMenu menuWithItems:InsMn, InvMn, ComMn,  nil];
		[mn alignItemsVertically];
		
		[self addChild:mn z:1 tag:2];
		
	}
	
	return self;
}

-(void)menu1: (id)sender{
	
	[[GameState sharedGameState] setScenenum:0];
	CCScene *sc = [CCScene node];
	[sc addChild:[HelloWorld node]];
	
	[[CCDirector sharedDirector] replaceScene: [CCSlideInRTransition transitionWithDuration:1.2f scene:sc]];
}
-(void)menu2: (id)sender{
	
	[[GameState sharedGameState] setScenenum:1];
	CCScene *sc = [CCScene node];
	[sc addChild:[HelloWorld node]];
	
	[[CCDirector sharedDirector] replaceScene: [CCSlideInRTransition transitionWithDuration:1.2f scene:sc]];
}
-(void)menu3: (id)sender{
	
	[[GameState sharedGameState] setScenenum:2];
	CCScene *sc = [CCScene node];
	[sc addChild:[HelloWorld node]];
	
	[[CCDirector sharedDirector] replaceScene: [CCSlideInRTransition transitionWithDuration:1.2f scene:sc]];
}

- (void) dealloc
{
	[super dealloc];
}

@end
