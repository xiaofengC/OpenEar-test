//
//  Gamestate.h
//  cooktest
//
//  Created by xiaofeng chen on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface GameState : NSObject 
{
	NSMutableArray *backgroundlist;
	int size;
	int scenenum;
	
}
+(GameState *)sharedGameState;
-(void)LoadImage;
-(int)getScenenum;
-(void)setScenenum:(int) temp;
-(NSString*)PopScene;

@property(nonatomic,retain) NSMutableArray * backgroundlist;
@property(nonatomic,readwrite) int size;
@property(nonatomic,readwrite) int scenenum;

@end
