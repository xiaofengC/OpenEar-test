//
//  MenuBar.h
//  Recipe
//
//  Created by xiaofeng chen on 11-9-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuBar : CCLayer {
	
CCMenuItem*Von,*Voff,*timer,*back;
	CGPoint Position;
}

-(id) init;
@end
