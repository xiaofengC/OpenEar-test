//
//  Gamestate.m
//  cooktest
//
//  Created by xiaofeng chen on 11-8-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Gamestate.h"


@implementation GameState


static GameState * _shareGamestate=nil;

@synthesize backgroundlist,size,scenenum;

+(GameState *)sharedGameState
{
	@synchronized([GameState class])
	{
		if(!_shareGamestate)
			[[self alloc] init];
		return _shareGamestate;
	}
	return _shareGamestate;
	
}


+(id)alloc
{
	@synchronized([GameState class])
	{
		NSAssert(_shareGamestate==nil,@"Attempted to allocate a second instance of a singleton.");
		_shareGamestate=[super alloc];
		return _shareGamestate;
	}
	return _shareGamestate;
}

- (id)init {
	if((self = [super init])) {
		
		size=3;
		scenenum=0;
		
	}
	return self;
}

-(void)LoadImage
{
	for(int i=0;i<size;i++)
	{
        NSString* background=[NSString stringWithFormat:@"bg%d.jpg",i];
		NSLog(@"bg%d.jpg",i);
		[backgroundlist addObject:background];
	}
}
-(NSString*)PopScene
{
	return [backgroundlist objectAtIndex:scenenum];
}

-(int)getScenenum{
	return scenenum;
}

-(void)setScenenum:(int) temp{
	scenenum= temp;
}




@end
