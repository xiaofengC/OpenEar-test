//
//  HelloWorldLayer.m
//  Recipe
//
//  Created by xiaofeng chen on 11-9-1.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"


BOOL soundstop;

void endSound()
{
	soundstop=YES;
	NSLog(@"sound end!");

}


// HelloWorld implementation
@implementation HelloWorld

@synthesize pocketsphinxController;
@synthesize openEarsEventsObserver;

@synthesize audioEffect;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	MenuBar *bar=[MenuBar node];
	[scene addChild:bar];
	
	// return the scene
	return scene;
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		isTouchEnabled=YES;
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		[[self camera] eyeX:&viewOrgX eyeY:&viewOrgY eyeZ:&viewOrgZ];
		
		
		screenWidth = s.width;
		screenHeight = 0;
		//NSLog([[GameState sharedGameState]PopScene]);
		int thescene=[[GameState sharedGameState]getScenenum];
		background=[CCSprite spriteWithFile:[NSString stringWithFormat:@"bg%d.jpg",thescene]];
		NSLog(@"bg%d.jpg",thescene);
		background.anchorPoint=ccp(0.5,1);
		[background setPosition:ccp(s.width/2,s.height)];
		[self addChild:background z:0]; 
		screenSize=ccp(s.width,background.textureRect.size.height);

		
		
		[CCMenuItemFont setFontName:@"Arial"];
		[CCMenuItemFont setFontSize:25];
		
		CCMenuItem *InsMn = [CCMenuItemFont itemFromString:@"超级菜鸟" target:self selector:@selector(menu1:)];
		//CCMenuItem *InvMn = [CCMenuItemFont itemFromString:@"家常小食" target:self selector:@selector(menu2:)];
		//CCMenuItem *ComMn = [CCMenuItemFont itemFromString:@"单一厨具" target:self selector:@selector(menu3:)];
		
		
		CCMenu *mn = [CCMenu menuWithItems:InsMn, nil];
		//[mn alignItemsVertically];
		
		[self addChild:mn z:3 tag:2];
		//[[SimpleAudioEngine sharedEngine] preloadEffect:@"sound1.caf"];

		pocketsphinxController = [[PocketsphinxController alloc] init];
		
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
		
		
		NSLog(@"Welcome to the OpenEars sample project.  This project understands the following words");
		// This is how to use an available instance of FliteController.
		
		
		// This is how to start the continuous listening loop of an available instance of PocketsphinxController.
		[self.pocketsphinxController startListening];
		
		// This is how to sign up for status messages about Flite, Pocketsphinx and OpenEars when you have an 
		// available instance of OpenEarsEventsObserver and its delegate methods.
		[self.openEarsEventsObserver setDelegate:self];
		
		soundcount=1;
		soundstop=YES;
	//	[self.EarController init];
		
	}
	return self;
}


- (PocketsphinxController *)pocketsphinxController { 
	if (pocketsphinxController == nil) {
		pocketsphinxController = [[PocketsphinxController alloc] init];
	}
	return pocketsphinxController;
}

// Lazily allocated FliteController.


// Lazily allocated OpenEarsEventsObserver.
- (OpenEarsEventsObserver *)openEarsEventsObserver {
	if (openEarsEventsObserver == nil) {
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
	}
	return openEarsEventsObserver;
}




- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
	
	NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID); // Log it.
    NSLog(@"SAY:%2d,",hypothesis);
	//[[SimpleAudioEngine sharedEngine] playEffect:@"sound1.caf"];
	
	//	self.heardTextView.text = [NSString stringWithFormat:@"Heard: \"%@\"", hypothesis]; // Show it in the status box.
	
	if([hypothesis isEqualToString:@"REPEAT"])
		
	{
		[self Playsound:soundcount];
		//[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
		//[self.fliteController say:[NSString stringWithFormat:@"MUSIC STOP. FUCK YOU DAO. NAOO. Dai"]]; 	
	}
	if([hypothesis isEqualToString:@"BACK" ])
	{
		if(soundcount>1)
		{
			soundcount--;
		[self Playsound:soundcount];
		}
			//[[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
		//[self.fliteController say:[NSString stringWithFormat:@"MUSIC PLAY. FUCK YOU DAO. NAOO. Dai"]];
	}
	if([hypothesis isEqualToString:@"NEXT"]||[hypothesis isEqualToString:@"NEXT STEP"])
	{
		if(soundcount<3)
		{
			soundcount++;

			[self Playsound:soundcount];
		
		}//[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		
	
	}
	//[self.fliteController say:[NSString stringWithFormat:@"You said %@",hypothesis]]; // React to it by telling our FliteController to say the heard phrase.
}
- (void) audioSessionInterruptionDidBegin {
	NSLog(@"AudioSession interruption began."); // Log it.
	//self.statusTextView.text = @"Status: AudioSession interruption began."; // Show it in the status box.
	[self.pocketsphinxController stopListening]; // React to it by telling Pocketsphinx to stop listening since it will need to restart its loop after an interruption.
}

// An optional delegate method of OpenEarsEventsObserver which informs that the interruption to the audio session ended.
- (void) audioSessionInterruptionDidEnd {
	NSLog(@"AudioSession interruption ended."); // Log it.
	//self.statusTextView.text = @"Status: AudioSession interruption ended."; // Show it in the status box.
	[self.pocketsphinxController startListening]; // React to it by telling Pocketsphinx to start listening again now that the interruption is over.
}

// An optional delegate method of OpenEarsEventsObserver which informs that the audio input became unavailable.
- (void) audioInputDidBecomeUnavailable {
	NSLog(@"The audio input has become unavailable"); // Log it.
	//self.statusTextView.text = @"Status: The audio input has become unavailable"; // Show it in the status box.
	[self.pocketsphinxController stopListening]; // React to it by telling Pocketsphinx to stop listening since there is no available input
}

// An optional delegate method of OpenEarsEventsObserver which informs that the unavailable audio input became available again.
- (void) audioInputDidBecomeAvailable {
	NSLog(@"The audio input is available"); // Log it.
	//self.statusTextView.text = @"Status: The audio input is available"; // Show it in the status box.
	[self.pocketsphinxController startListening]; // React to it by telling Pocketsphinx to start listening so it can recalibrate to the new sound source.
}

// An optional delegate method of OpenEarsEventsObserver which informs that there was a change to the audio route (e.g. headphones were plugged in or unplugged).
- (void) audioRouteDidChangeToRoute:(NSString *)newRoute {
	NSLog(@"Audio route change. The new audio route is %@", newRoute); // Log it.
	//self.statusTextView.text = [NSString stringWithFormat:@"Status: Audio route change. The new audio route is %@",newRoute]; // Show it in the status box.
	
	[self.pocketsphinxController stopListening];
	
	
	// React to it by telling the Pocketsphinx loop to shut down and then
	[self.pocketsphinxController startListening]; // restart so that it can recalibrate to the new sound source.
}


- (void) pocketsphinxDidStartCalibration {
	NSLog(@"Pocketsphinx calibration has started."); // Log it.
	//self.statusTextView.text = @"Status: Pocketsphinx calibration has started."; // Show it in the status box.
}

// An optional delegate method of OpenEarsEventsObserver which informs that the Pocketsphinx recognition loop completed the calibration stage in its startup.
// This might be useful in debugging a conflict between another sound class and Pocketsphinx.
- (void) pocketsphinxDidCompleteCalibration {
	NSLog(@"Pocketsphinx calibration is complete."); // Log it.
	//self.statusTextView.text = @"Status: Pocketsphinx calibration is complete."; // Show it in the status box.
}

// An optional delegate method of OpenEarsEventsObserver which informs that the Pocketsphinx recognition loop has entered its actual loop.
// This might be useful in debugging a conflict between another sound class and Pocketsphinx.
- (void) pocketsphinxRecognitionLoopDidStart {
	NSLog(@"Pocketsphinx is starting up."); // Log it.
	//self.statusTextView.text = @"Status: Pocketsphinx is starting up."; // Show it in the status box.
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx is now listening for speech.
- (void) pocketsphinxDidStartListening {
	
	NSLog(@"Pocketsphinx is now listening."); // Log it.
	//self.statusTextView.text = @"Status: Pocketsphinx is now listening."; // Show it in the status box.
	
	
}

// An optional delegate method of OpenEarsEventsObserver which informs that Pocketsphinx detected speech and is starting to process it.
- (void) pocketsphinxDidDetectSpeech {
	NSLog(@"Pocketsphinx has detected speech."); // Log it.
	//self.statusTextView.text = @"Status: Pocketsphinx has detected speech."; // Show it in the status box.
}

					  
					  
					  
-(void)menu1: (id)sender{
	
	
    
	[self Playsound:soundcount];
	
	
	
}

-(void)Playsound: (int)num
{
	if(soundstop)
	{
		soundstop=NO;
    CFBundleRef mainBundle = CFBundleGetMainBundle ();
	CFURLRef soundFileURLRef;
	SystemSoundID soundFileObject;
	
    // Get the URL to the sound file to play. The file in this case
    // is "tap.aif"
	NSString *filename= [NSString stringWithFormat:@"sound%d",num];
	CFStringRef file=(CFStringRef)filename;
	
    soundFileURLRef  = CFBundleCopyResourceURL (
												mainBundle,
												file,
												CFSTR ("wav"),
												NULL
												);


    // Create a system sound object representing the sound file
    AudioServicesCreateSystemSoundID (
									  soundFileURLRef,
									  &soundFileObject
									  );
	AudioServicesPlaySystemSound (soundFileObject);
	AudioServicesAddSystemSoundCompletion(soundFileObject, NULL, NULL,endSound,NULL);
	
	NSLog(@"play!");
	}
}



-(void) onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit {
	
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self]; 
	[super onExit];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [touch locationInView: [touch view]]; 
	
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	return YES;
	
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	
	//NSAssert(state == kStateGrabbed, @"Unexpected state!");
	
	CGPoint location = [touch locationInView: [touch view]]; 
	CGPoint prevLocation = [touch previousLocationInView: [touch view]];	
	
	prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
	
	location = [[CCDirector sharedDirector] convertToGL: location];
	touchpoint=location;
	prevtouchpoint=prevLocation;
	//if(location.y<s.width/2)
	[self SetCameraPosition];
	
	
}

-(void) SetCameraPosition
{
	
	float x,y;
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	x=0;
	y=screenHeight;
	if(touchpoint.y<prevtouchpoint.y)
		screenHeight-=15;
	else screenHeight+=15;
	if(screenHeight>0)
		screenHeight=0;
	if(screenHeight-(s.height-screenSize.y)<0)
		screenHeight=s.height-screenSize.y;
	
	
	[[self camera] setEyeX:x eyeY:y eyeZ:viewOrgZ];
	[[self camera] setCenterX:x centerY:y centerZ:0];	
	
	
	
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
@end
