//
//  OpenEarController.m
//  Recipe
//
//  Created ‰by xiaofeng chen on 11-9-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpenEarController.h"


@implementation OpenEarController

@synthesize pocketsphinxController;
@synthesize openEarsEventsObserver;



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
- (id) init {
	if((self= [super init]));
	{
	//	[[SimpleAudioEngine sharedEngine] preloadEffect:@"sound1.caf"];
		//audioSessionManager = [[AudioSessionManager alloc] init];
		pocketsphinxController = [[PocketsphinxController alloc] init];
		
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
		

	NSLog(@"Welcome to the OpenEars sample project.  This project understands the following words");
	// This is how to use an available instance of FliteController.
	
	
	// This is how to start the continuous listening loop of an available instance of PocketsphinxController.
	[self.pocketsphinxController startListening];
	
	// This is how to sign up for status messages about Flite, Pocketsphinx and OpenEars when you have an 
	// available instance of OpenEarsEventsObserver and its delegate methods.
	[self.openEarsEventsObserver setDelegate:self];
	}
	return self;
}

- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {

	NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID); // Log it.
    NSLog(@"SAY:%2d,",hypothesis);
	//[[SimpleAudioEngine sharedEngine] playEffect:@"sound1.caf"];
	
	//	self.heardTextView.text = [NSString stringWithFormat:@"Heard: \"%@\"", hypothesis]; // Show it in the status box.
	
	if([hypothesis isEqualToString:@"LEFT"])
	{
		//[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	//[self.fliteController say:[NSString stringWithFormat:@"MUSIC STOP. FUCK YOU DAO. NAOO. Dai"]]; 	
}
		if([hypothesis isEqualToString:@"RIGHT" ])
		{
			//[[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
//	[self.fliteController say:[NSString stringWithFormat:@"MUSIC PLAY. FUCK YOU DAO. NAOO. Dai"]];
}
	if([hypothesis isEqualToString:@"TURN"])
	{
//		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	
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
	
	[self.pocketsphinxController stopListening]; // React to it by telling the Pocketsphinx loop to shut down and then
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


- (void)dealloc {
	
	[pocketsphinxController release];
	

	openEarsEventsObserver.delegate = nil; // This is a good idea so that OpenEarsEventsObserver will not attempt to message this class after it has been released
	[openEarsEventsObserver release];
	
    [super dealloc];
}

@end
