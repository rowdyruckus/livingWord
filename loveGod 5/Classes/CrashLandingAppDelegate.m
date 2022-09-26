/*

File: CrashLandingAppDelegate.m
Abstract: The UIApplication delegate class, which is the central controller of
the application.

Version: 1.8
 
 christruckus unicersal
 
 ipad vers is called --- christpaid
 
 christfon
 christphone
 
 
 christ
 
 test out text
 then autorotate
 then timers galore
 then ??.... need cable 
 
 admob files?
 
 ipad resolution

*/
#import <CommonCrypto/CommonDigest.h>
#import "TwitterAgent.h"
//#import "AdMobView.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#include<Security/Security.h>
#import <UIKit/UIKit.h>
#import <mach/mach_time.h>
#import "CrashLandingAppDelegate.h"  // starteffect
#import "MyEAGLView.h"
//#import "SoundEngine.h"

// CONSTANTS
#define kUserNameDefaultKey			@"userName"   // NSString active
#define kHighScoresDefaultKey		@"highScores" // NSArray of NSStrings handleTap

#define kAccelerometerFrequency		10// Hz
#define kFilteringFactor			0.1 // For filtering out gravitational effects

#define kRenderingFPS				30.0 // Hz

#define kListenerDistance			1.0  // Used for creating a realistic sound field

// MACROS
// Converts degrees to radians for calculating the orientation of the rocket.
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)

// Used to randomize the starting conditions of the game
#define RANDOM_SEED() srandom((unsigned)(mach_absolute_time() & 0xFFFFFFFF))

// Used to randomize the position of the base the rocket must land on.
#define RANDOM_FLOAT() ((float)random() / (float)INT32_MAX)

// CLASS INTERFACE
@interface CrashLandingAppDelegate ()

//- (void) renderScene;
//- (void) renderScene2;
- (void) resetGame;
- (void) success;
- (void) instructionScreen;
- (void) gospelScreen;
- (void) loadNewVerseToPraise;
- (void) refreshSetupForPlay;
- (void) optionScreen;
- (void) resourcesScreen;
- (void) timerHolder;
- (void) autoRotate;
- (void) drawBackground;
- (void) internetScreen;
- (void) justVerseToPraise;
- (void) saveScore;
- (void) menuScene;
- (void) gameup;
- (void) setupAnimation;
- (void) evangel;
- (void) animateToWeb;
- (void) facebookAgent;
@end

// CLASS IMPLEMENTATIONS
@implementation CrashLandingAppDelegate

@synthesize sound1;
@synthesize sound2;
@synthesize sound3;
@synthesize sound4;
@synthesize sound5;
@synthesize sound6;
@synthesize sound7;
@synthesize sound8;

//-(void) facebookAgent:(FacebookAgent*)agent loginStatus:(BOOL) loggedIn{
//}
//- (void) facebookAgent:(FacebookAgent*)agent requestFaild:(NSString*) message{
//}
//- (void) facebookAgent:(FacebookAgent*)agent statusChanged:(BOOL) success{
//}

+ (void) initialize {
	if(self == [CrashLandingAppDelegate class]) {
		RANDOM_SEED();
		//Make sure we have a default set of high-scores in the preferences destroy
	//	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:[NSArray array] forKey:kHighScoresDefaultKey]];
	}
}
//(void) facebookAgent:(FacebookAgent*)agent loginStatus:(BOOL) loggedIn{  
//}  

void uncaughtExceptionHandler(NSException *exception) {
 //   [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
}

//HostBass1
- (void) applicationDidFinishLaunching:(UIApplication*)application {
//    fbAgent = [[FacebookAgent alloc] initWithApiKey:@"0b64bb768d566c3abd2673b4802273e2"
//                                          ApiSecret:@"ce158bbeb405e337b51de2ffaf1a3a5b"
//                                           ApiProxy:nil];
//    fbAgent.delegate = self;
	

    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
//    [FlurryAnalytics startSession:@"CSAJ5Q529Q7MB5IZUBJX"];
    
    
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		// The device is an iPad running iPhone 3.2 or later.
		device=0;
	}
	else
	{
		// The device is an iPhone or iPod touch.
		device=1;
	}
	//device=1;
	
	fontSizePad=0; if (device==0) fontSizePad=30;
	
	
	//device=0; fontSizePad=0; if (device==0) fontSizePad=30;
	
	_textures[titleText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Living Word"]dimensions:CGSizeMake(322+fontSizePad*8, 122+fontSizePad*3) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:33+fontSizePad];
	
	_textures[instrucTitleText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Instructions"]dimensions:CGSizeMake(322+fontSizePad*6, 122+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:33+fontSizePad];
	
		
	_textures[instrucText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Touch and drag the words\n until they make the verse,\n GREEN words are in the right place,\n RED words still need rearrangement"]dimensions:CGSizeMake(452+fontSizePad*16, 212+fontSizePad*6) alignment:UITextAlignmentCenter fontName: @"Verdana"  fontSize:21+fontSizePad*.7];   ///  score
	
	_textures[endWebOnBorderText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Touch the border\n to return to game"]dimensions:CGSizeMake(452+fontSizePad*16, 212+fontSizePad*6) alignment:UITextAlignmentCenter fontName: @"Verdana"  fontSize:21+fontSizePad*.7];   ///  score
	
	_textures[tapToGoOnText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Tap to\ncontinue"]dimensions:CGSizeMake(452+fontSizePad*16, 212+fontSizePad*6) alignment:UITextAlignmentCenter fontName: @"Verdana"  fontSize:11+fontSizePad*.6];   ///  score
	
	_textures[menuText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@" menu", (seconds)]dimensions:CGSizeMake(222+fontSizePad, 102) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:19+fontSizePad/2];

	_textures[gameText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@" game", (seconds)]dimensions:CGSizeMake(222+fontSizePad, 102) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:19+fontSizePad/2];

	_textures[startText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"start game"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[instructionsText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"instructions"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[gameModeText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"beginner"]dimensions:CGSizeMake(322+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad];
	
	_textures[altgameModeText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"expert"]dimensions:CGSizeMake(322+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad];
	
	_textures[alt2gameModeText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"timeless"]dimensions:CGSizeMake(322+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad];
	
	_textures[gospelText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"verses"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad];
	
	_textures[optionsText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"options"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad];
	
	if (device==0) {
		_textures[kTexture_border] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"border77.png"]];
		_textures[kTexture_Blueinv] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"Default-haha.png"]];
	//	_textures[kTexture_Blueinv] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"clouds-1.png"]];
	}
	else{
		_textures[kTexture_border] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"border320480.png"]];
		_textures[kTexture_Blueinv] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"Default.png"]];
	}
	
	
	
	rect = [[UIScreen mainScreen] bounds];	
	rectSideways.size.width= rect.size.height;
	rectSideways.size.height =rect.size.width;
	//NSBundle *mainBundle= [NSBundle mainBundle];
//	CGRect  rect = [[UIScreen mainScreen] bounds];
    [window setFrame:rect];
	//  set inits
	
	//if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
     /*   controller = [[MyController alloc] initWithNibName:@"MyiPadNib" bundle:nil];
    else
        controller = [[MyController alloc] initWithNibName:@"MyiPodNib" bundle:nil];
	
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];*/
	
	counter=-30;
	lite= NO;//YES;
    kk=50;
	youFail=0;			randomNess=2;
	toggleSound=YES;	gameModeSelection=0;
	adReceived=NO;
	
	menuState=NO; optionsState=NO;
	seconds=51;
	_firstTap=YES; firstGame=YES;
	scroll=NO; verseCount=54;
	verse=arc4random()%verseCount+1;
	
	toggleSound=YES;
	fresh=YES;
	//score=0; 
	fadeIn=.01;
	animationState=NO;
	
	
	//NSDictionary *initDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
	//							  [NSNumber numberWithBool:NO], kPKey, @"Z", kFKey, [NSNumber numberWithBool:YES], kMKey, [NSNumber numberWithBool:NO], kCKey, [NSNumber numberWithBool:YES], kVKey, nil];
	
	//[myDefaults registerDefaults:initDefaults];
	
	//  location
	firstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"ran?"];
	
    if(firstLaunch == NO)  //  no = no it hasnt ran before
    {
		//score=500; 
		NSDate *date;
		lite=NO; hiScore=0;toggleSound=YES;historicVerses=0;
		instrucState=YES; menuState=NO;
		[[NSUserDefaults standardUserDefaults] setBool: YES forKey:@"ran?"];
		[[NSUserDefaults standardUserDefaults] setBool: toggleSound forKey:@"sound"];
		[[NSUserDefaults standardUserDefaults] setInteger: gameModeSelection forKey:@"mode"];
    }
	
	else{
		gameModeSelection =     [[NSUserDefaults standardUserDefaults] integerForKey:@"mode"];
		hiScore =     [[NSUserDefaults standardUserDefaults] integerForKey:@"hiScore"];
		historicVerses =     [[NSUserDefaults standardUserDefaults] integerForKey:@"history"];
		toggleSound = [[NSUserDefaults standardUserDefaults] boolForKey:@"sound"];
		//[[NSUserDefaults standardUserDefaults] setInteger: score forKey:@"score"];
	}
	
	if (firstLaunch==NO) {
	//[self performSelectorInBackground:@selector(reportAppOpenToAdMob) withObject:nil];	
		gameModeSelection=1;
	
	}
	//Set up OpenGL projection matrix
	glMatrixMode(GL_PROJECTION);
	glOrthof(0, rect.size.width, 0, rect.size.height, -1, 1);
	glMatrixMode(GL_MODELVIEW);
	
	//Initialize OpenGL states
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_TEXTURE_2D);
	glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glEnable(GL_BLEND);
	
    // draw to screen everything else below this line
	//firstLaunch=NO;
	
	if ( firstLaunch==YES){
		menuState=YES;_firstTap=YES;
		[self menuScene];
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(menuScene) userInfo:nil repeats:YES];
	}
	else {
        NSLog(@"a called again");

		[self loadNewVerseToPraise];
		[self instructionScreen];
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(instructionScreen) userInfo:nil repeats:YES];	
	}
	
	
	///////////////////////// draw to screen everything else below this line
	
	
	NSString *myExamplePath = [[NSBundle mainBundle] pathForResource:@"Ethereal Accents" ofType:@"caf"];
	
	sound1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath] error:NULL];
	
	sound1.delegate = self;
	[sound1 prepareToPlay];
//	[sound1 play];
	
	NSString *myExamplePath2 = [[NSBundle mainBundle] pathForResource:@"Basketball Net Swish" ofType:@"caf"];
	sound2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath2] error:NULL];
	sound2.delegate = self;
	
 //	NSString *myExamplePath3 = [[NSBundle mainBundle] pathForResource:@"Soft Pulsing Accent" ofType:@"caf"];
 	NSString *myExamplePath3 = [[NSBundle mainBundle] pathForResource:@"vb" ofType:@"caf"];

	sound3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath3] error:NULL];
	sound3.delegate = self;
	
	NSString *myExamplePath4 = [[NSBundle mainBundle] pathForResource:@"Kids Booing" ofType:@"caf"];
	sound4 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath4] error:NULL];
	sound4.delegate = self;
	
    NSString *myExamplePath5 = [[NSBundle mainBundle] pathForResource:@"vb" ofType:@"caf"];
  //  NSString *myExamplePath5 = [[NSBundle mainBundle] pathForResource:@"Suspense Accents 05" ofType:@"caf"];
	sound5 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath5] error:NULL];
	sound5.delegate = self;
	
	//NSString *myExamplePath6 = [[NSBundle mainBundle] pathForResource:@"ding3" ofType:@"caf"];
	NSString *myExamplePath6 = [[NSBundle mainBundle] pathForResource:@"dingTwice2" ofType:@"caf"];
	sound6 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath6] error:NULL];
	sound6.delegate = self;
	
	NSString *myExamplePath7 = [[NSBundle mainBundle] pathForResource:@"bellSet" ofType:@"caf"];

	sound7 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath7] error:NULL];
	sound7.delegate = self;
	sound7.volume=.7;
	
	NSString *myExamplePath8 = [[NSBundle mainBundle] pathForResource:@"flute" ofType:@"mp3"];
//	NSString *myExamplePath8 = [[NSBundle mainBundle] pathForResource:@"ding3" ofType:@"caf"];
	sound8 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath8] error:NULL];
	sound8.delegate = self;
	
    sound8.numberOfLoops=-1;
    [sound8 play];
	//sound1.numberOfLoops=5;
	if (toggleSound==YES) [sound1 play];
//
	
	_textures[timeUpText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Time up!"]dimensions:CGSizeMake(322+fontSizePad*6, 222+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:33+fontSizePad]; //Verdana"  fontSize:63];
	
	
	_textures[YouFailText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\n\n\n\n\nReturn, faithless people;\n I will cure you of backsliding.\n -Yes, we will come to you,\n for you are the LORD our God\nJeremiah 3:22"]dimensions:CGSizeMake(462+fontSizePad*15, 292+fontSizePad*10) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:22+fontSizePad*.7]; //Verdana"  fontSize:63];
	
	_textures[supportText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Developer Support"]dimensions:CGSizeMake(472+fontSizePad*25, 160+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName2 fontSize:(28+fontSizePad)];
	
	//_textures[supportText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Support Developer"]dimensions:CGSizeMake(322+fontSizePad*6, 122+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:33+fontSizePad];

	_textures[mosaicText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"audio bible"]dimensions:CGSizeMake(182+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[piperText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"top charities"]dimensions:CGSizeMake(182+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentRight fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[marsText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"dev support"]dimensions:CGSizeMake(442+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[tellFriendText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"tell a friend"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[reviewText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"give review"]dimensions:CGSizeMake(242+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[fbText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"post to facebook"]dimensions:CGSizeMake(342+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	// me\n bug report\n feature request...
	_textures[emailText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"email"]dimensions:CGSizeMake(242+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	_textures[siteText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"visit website"]dimensions:CGSizeMake(242+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
	
	
	
	
	//_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Praise the Lord!!"]dimensions:CGSizeMake(422, 222) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:27]; //Verdana"  fontSize:63];
	
	//_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nWell done good and faithful servant!!\n\n"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad]; //Verdana"  fontSize:63];
	_textures[evangelText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"God's word is powerful!\nTell others:"]dimensions:CGSizeMake(472+fontSizePad*25, 160+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName fontSize:(23+fontSizePad)];
	
	_textures[twitText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"tweet"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentLeft fontName: kFontName  fontSize:(24+fontSizePad)];
	
//	_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nWell done!"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
//	_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nCheers!!"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
//	_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nJolly good"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
//	_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nGood job!"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
//	_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nYou did it!!"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
	_textures[kTexture_praiseGod] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nWell done good and faithful servant\n\nMatthew 25:21"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
	
		_textures[kTexture_praiseGod2] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nYou can do all things through Christ who strengthens.."]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];
	
		_textures[kTexture_praiseGod3] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"\nThe LORD is my light and my salvation- whom shall I fear?\n\nPsalm 27:1"]dimensions:CGSizeMake(422+fontSizePad*6, 222+fontSizePad*7) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:23+fontSizePad*.7]; //Verdana"  fontSize:63];

	_textures[resourcesTitleText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Links"]dimensions:CGSizeMake(322+fontSizePad*8, 122+fontSizePad*3) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:33+fontSizePad];

	_textures[resourcesText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"links"]dimensions:CGSizeMake(142+fontSizePad*6, 42+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad];

	
	
	_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Alleluia!!"]dimensions:CGSizeMake(822, 122) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:14+fontSizePad/2];
	//  God is Good!!
	

	/*
	
	win =[[Sound alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Soft Pulsing Accent" ofType:@"caf"]] ;  // Soft Pulsing Accent.caf   kidscheer
	lose =[[Sound alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Kids Booing" ofType:@"caf"]] ;  // Kids Booing.caf  losepiano
	
	pick =[[Sound alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Basketball Net Swish" ofType:@"caf"]] ;  //pop
	*/
	
	//glBindTexture(GL_TEXTURE_2D, [_textures[kTexture_Title] name]);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	
	_textures[kTexture_Star] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"circy3.png"]];
	_textures[kTexture_Facebook] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"facebook.png"]];
	_textures[kTexture_BibleIcon] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"bibleIcon3.png"]];

	_textures[sparks] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"circy3.png"]];

	_textures[kTexture_Arrow] = [[Texture2D alloc] initWithImage: [UIImage imageNamed:@"StreetViewLinkArrow.png"]];
	
	
	//Configure and start accelerometer

	christ=YES;
	
	[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;

	
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	_timer2 = [NSTimer scheduledTimerWithTimeInterval:(1.5) target:self selector:@selector(timerHolder) userInfo:nil repeats:YES];
	//[UIApplication sharedApplication].idleTimerDisabled = YES;
	
	
	
	
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	
	// GOES WHERE FOR ERROR?
    
    //2017-11-27 20:51:36.902950-0500 Bible Verses[57185:9739621] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Application windows are expected to have a root view controller at the end of application launch'
	/*
	
	//lite=YES;
	if(lite==YES){	
		adMobAd.frame = CGRectMake(0, 160, 320, 48); // set the frame, in this case at the bottom of the screen
		
		//adMobAd.frame = CGRectMake(0, 432, 320, 48); // set the frame, in this case at the bottom of the screen
		
		adMobAd = [AdMobView requestAdWithDelegate:self]; // a new ad request
		
		[adMobAd retain]; // this will be released when it loads (or fails to load)
	}  //  facebook
	*/
	needToRunInternetCheck=YES;
	
    double delayInSeconds = 200.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Do some work");
    });
    
    
    [window setRootViewController:[[UIViewController alloc] init]];
    
}

// This method requires adding #import <CommonCrypto/CommonDigest.h> to your source file.
//- (NSString *)hashedISU {
//    NSString *result = nil;
//    NSString *isu = [UIDevice currentDevice].uniqueIdentifier;
//
//    if(isu) {
//        unsigned char digest[16];
//        NSData *data = [isu dataUsingEncoding:NSASCIIStringEncoding];
//        CC_MD5([data bytes], [data length], digest);
//
//        result = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//                  digest[0], digest[1],
//                  digest[2], digest[3],
//                  digest[4], digest[5],
//                  digest[6], digest[7],
//                  digest[8], digest[9],
//                  digest[10], digest[11],
//                  digest[12], digest[13],
//                  digest[14], digest[15]];
//        result = [result uppercaseString];
//    }
//    return result;
//}

- (void)reportAppOpenToAdMob {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // we're in a new thread here, so we need our own autorelease pool
	// Have we already reported an app open?
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																		NSUserDomainMask, YES) objectAtIndex:0];
	NSString *appOpenPath = [documentsDirectory stringByAppendingPathComponent:@"admob_app_open"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager fileExistsAtPath:appOpenPath]) {
		// Not yet reported -- report now
		NSString *appOpenEndpoint = [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&md5=1&app_id=%@",
									 [self hashedISU], @"368884363"];
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appOpenEndpoint]];
		NSURLResponse *response;
		NSError *error;
		NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		if((!error) && ([(NSHTTPURLResponse *)response statusCode] == 200) && ([responseData length] > 0)) {
			[fileManager createFileAtPath:appOpenPath contents:nil attributes:nil]; // successful report, mark it as such
		}
	}
	[pool release];
}


// Release resources when they are no longer needed
- (void) dealloc {
	//unsigned			i;  alloc
	
	[_statusTexture release];	
	//SoundEngine_Teardown();	
	for(i = 0; i < kNumTextures; ++i)
		[_textures[i] release];	
	[_textField release];
	[glView release];
	[window release];
//	[sound1 release];
	[super dealloc];
}


/*
- (NSString *)publisherId {
	christ=YES;
	if (christ==YES) return @"a14bcd41a37d414";  //livingWord
	if (christ==NO) return @"a149cd768689272"; // this should be prefilled; if not, get it from www.admob.com // a1498fd37029328 test  // rel a149cd768689272  bb  
}

- (UIColor *)adBackgroundColor {
	//if (themecolor==2) return [UIColor purpleColor];
	//else if (themecolor==1) return [UIColor blueColor];
	//else  (themecolor==0)
	//else	
	return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)adTextColor {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (BOOL)mayAskForLocation {
	return NO;//YES; // this should be prefilled; if not, see AdMobProtocolDelegate.h for instructions
}

// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did receive ad");
	//self.view.hidden = NO;
	
	//adMobAd.frame = CGRectMake(80, 0, 48, 320);   
	
	
	
//	/*if (device==1)
	adMobAd.frame =CGRectMake(-144, 222, 320, 38);   //centre
	else 
	adMobAd.frame =CGRectMake(-144, 492, 320, 38);   //centre
//  /
	
	
	
	
	adMobAd.transform =CGAffineTransformMakeRotation(-M_PI / 2 +0+0*fmod(0,arc4random()));
	
	
	
	
//else		adMobAd.transform = CGAffineTransformMakeRotation(M_PI / 2);
	
	//AdMobView *ad = [AdMobView requestAdWithDelegate:<your delegate>]; // start a new ad request
	//ad.frame = CGRectMake(0, 432, 320, 48); // set the frame, in this case at the bottom of the screen
	//[window addSubview:ad]; 
	
	//[window addSubview:adMobAd];  // webvie
	
	adContainer = [[UIView alloc] initWithFrame:CGRectMake(-144, 492, 320, 38)];
	//score+=1;
	[adContainer addSubview: adMobAd];
	[window addSubview: adContainer];

	adReceived=YES;
	
	//	myButton2.enabled=NO;myButton2.hidden=YES;  youfa
	
	//[self.view addSubview:[[UIImage imageNamed:@"laserad.png"]drawAtPoint:CGPointZero]];//drawInRect:bounds];
	//[_textures[kTexture_Background]
	
	autoslider = [NSTimer scheduledTimerWithTimeInterval:AD_REFRESH_PERIOD target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];//}
}

// Request a new ad. If a new ad is successfully loaded, it will be animated into location.
- (void)refreshAd:(NSTimer *)timer {
	//if (orientmenus==UIDeviceOrientationPortrait) 
	[adMobAd requestFreshAd];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did fail to receive ad");
	[adMobAd release];
	adMobAd = nil;
	//	myButton2.enabled=YES;myButton2.hidden=NO;
	// we could start a new ad request here, but it is unlikely that anything has changed in the last few seconds,
	// so in the interests of the user's battery life, let's not
}
*/


// Implement this method to get the lastest data from the accelerometer 

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
	//Use a basic low-pass filter to only keep the gravity in the accelerometer values
	_accelerometer[0] =(acceleration.x * kFilteringFactor + _accelerometer[0] * (1.0 - kFilteringFactor));
//	_accelerometer[1] = (acceleration.y * kFilteringFactor + _accelerometer[1] * (1.0 - kFilteringFactor));
//	_accelerometer[2] = acceleration.z * kFilteringFactor + _accelerometer[2] * (1.0 - kFilteringFactor);
	//_accelerometer[0] = acceleration.x- (acceleration.x * kFilteringFactor + _accelerometer[0] * (1.0 - kFilteringFactor));
	//_accelerometer[1] = acceleration.y- (acceleration.y * kFilteringFactor + _accelerometer[1] * (1.0 - kFilteringFactor));
	//_accelerometer[2] = acceleration.z * kFilteringFactor + _accelerometer[2] * (1.0 - kFilteringFactor);
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
	//Configure and start accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
[[UIAccelerometer sharedAccelerometer] setDelegate:self];
}



// Saves the user name and score after the user enters it in the provided text field. 
- (void)textFieldDidEndEditing:(UITextField*)textField {
	//Save name
	[[NSUserDefaults standardUserDefaults] setObject:[textField text] forKey:kUserNameDefaultKey];
	
	//Save the score
	[self saveScore];
}

// Terminates the editing session reset
- (BOOL)textFieldShouldReturn:(UITextField*)textField {
	//Terminate editing
	[textField resignFirstResponder];
	
	return YES;
}
#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark


//application receivememorywarning  nextrnd


- (void)handlebegan:(CGPoint)point withEvent:(UIEvent *)event
{
	
	startTouch=point;
	startTouch.y=rect.size.height-startTouch.y;
	
	if((menuState==NO)&&(instrucState==NO)&&(webViewState==NO)&&(optionsState==NO)&&(_firstTap==NO)&&(animationState==NO)){	

	for(ii = 0; ii<stringLength; ii++){
		if (((fabs(startTouch.x-words[ii].x))<(25+fontSizePad))&&((fabs(startTouch.y-words[ii].y))<(35+fontSizePad))&&(pickedup==NO)) {
			action[ii]=7; pickedup=YES; 
			holding=wordsHomeFull[ii];
			if (swapReady==-1) {
				swapReady=holding;
				swapReadyIndex=5;//ii;//holding;
			//	score=holding;
			}
			empty=ii; //wordsHomeFull[ii]=-1;
			
		/// obedience out of a heart that loves Jesus
	
		}
	}
	}
	
	
	/// menu code      fb.x  menuscene
	if (resourcesState==YES)
	{
		if ((fabs(startTouch.x-mosaic.x)<30+fontSizePad)&&
			(fabs(startTouch.y-mosaic.y)<90+fontSizePad)) linkOptions=1; //dab
		if ((fabs(startTouch.x-twit.x)<30+fontSizePad)&&
			(fabs(startTouch.y-twit.y)<90+fontSizePad)) linkOptions=2; // twit
		if ((fabs(startTouch.x-review.x)<30+fontSizePad)&&
			(fabs(startTouch.y-review.y)<90+fontSizePad))linkOptions=3; // rev
		
		if ((fabs(startTouch.x-mars.x)<30+fontSizePad)&&
			(fabs(startTouch.y-mars.y)<90+fontSizePad))linkOptions=4; //dev supp
		
		if ((fabs(startTouch.x-tellFriend.x)<30+fontSizePad)&&
			(fabs(startTouch.y-tellFriend.y)<90+fontSizePad))linkOptions=5; //friend
		if ((fabs(startTouch.x-piper.x)<30+fontSizePad)&&
			(fabs(startTouch.y-piper.y)<90+fontSizePad))linkOptions=6; //charity
		
	}
	
	if(startTouch.x<40+fontSizePad*2){//
		if(startTouch.y<80+fontSizePad*3) {
			menuHighlighted=YES;
		}}
	
	if (gospelState==YES){
	if ((startTouch.y<80+fontSizePad)) arrowHighlightRight=YES;
	if ((startTouch.y>rect.size.height-80-fontSizePad)) arrowHighlightLeft=YES;	
	}
	
	if(_firstTap==YES){
		if ((fabs(startTouch.x-menuStart.x)<30+fontSizePad)&&
		    (fabs(startTouch.y-menuStart.y)<50+fontSizePad*4))  menuoption=1;
		if ((fabs(startTouch.x-menuInstruc.x)<30+fontSizePad)&&
		    (fabs(startTouch.y-menuInstruc.y)<90+fontSizePad*3))  menuoption=2;
		if ((fabs(startTouch.x-menuOptions.x)<30+fontSizePad)&&
		    (fabs(startTouch.y-menuOptions.y)<50+fontSizePad*3))  menuoption=3;
		if (((fabs(startTouch.x-gameModeXy.x))<40+fontSizePad)&&
			((fabs(startTouch.y-gameModeXy.y))<110+fontSizePad))  menuoption=4;
		if ((fabs(startTouch.x-  gospelXy.x)<30+fontSizePad)&&
			(fabs(startTouch.y-  gospelXy.y)<90+fontSizePad))  menuoption=5;
		if ((fabs(startTouch.x- resources.x)<30+fontSizePad)&&
			(fabs(startTouch.y- resources.y)<90+fontSizePad))  menuoption=6;
			}
	
	else {
		userTouchedScreenToContinue=YES;

		if((startTouch.x<40+fontSizePad*2)&&(fabs(startTouch.y-rect.size.height*.35)<40+fontSizePad*3)) {
				touchDownInBibleIcon=YES;
			userTouchedScreenToContinue=NO;

			}
			else touchDownInBibleIcon=NO;
		
		if((startTouch.x<40+fontSizePad*2)&&(fabs(startTouch.y-rect.size.height*.65)<40+fontSizePad*3)) {
			touchDownInFB=YES;
			userTouchedScreenToContinue=NO;

		}
		else touchDownInFB=NO;
		
		/// make a now that variable for pressed on youwin is pressed if fb and web werent pressed
		if(startTouch.x<40+fontSizePad*2){//
			if(startTouch.y<80+fontSizePad*3) {

				userTouchedScreenToContinue=NO;
				touchDownInMenu=YES;
			}
		}
		else touchDownInMenu=NO;
	}
	
	}
	

-(void)handleMoved:(CGPoint)currentT{
	
	currentTouch = currentT; currentTouch.y=rect.size.height-currentTouch.y;
	
	
	if(currentTouch.x<40+fontSizePad*2){//
		if(currentTouch.y<80+fontSizePad*3) {
			if (menuHighlighted==YES){
			menuHighlighted=NO;
			}}}
	 
	
	if((menuState==NO)&&(instrucState==NO)&&(optionsState==NO)&&(_firstTap==NO)){	
		
		for(ii = 0; ii<stringLength; ii++){
			if (action[ii]==7) { 
				words[ii].x=currentTouch.x; words[ii].y=currentTouch.y; 
				
				for(j = 0; j< stringLength; j++){
					if ((fabs(words[ii].x-wordsHome[j].x)<28+fontSizePad)&&(fabs(words[ii].y-wordsHome[j].y)<30+fontSizePad)) {
						hover=j;
						swapReady=holding;
						if (j!=empty) dragged=YES; 
					}}
			}
		}
		wordSwap= YES;
		if (wordSwap==NO){
		for(l = 0; l<stringLength; l++){
			
			if((hover>empty)) {
				wordsHomeFull[empty]=wordsHomeFull[empty+1];
				wordsHomeFull[empty+1]=-1;
				words[empty+1].x=words[empty].x;
				words[empty+1].y=words[empty].y;
				words[empty].x=wordsHome[empty].x;
				words[empty].y=wordsHome[empty].y;
				action[empty]=5; if(wordsHomeFull[empty]==empty) action[empty]=6;
				action[empty+1]=7;
				empty=empty+1;
			}
			if((hover<empty)) {
				wordsHomeFull[empty]=wordsHomeFull[empty-1];
				wordsHomeFull[empty-1]=-1;
				words[empty-1].x=words[empty].x;
				words[empty-1].y=words[empty].y;
				words[empty].x=wordsHome[empty].x;
				words[empty].y=wordsHome[empty].y;
				action[empty]=5; if(wordsHomeFull[empty]==empty) action[empty]=6;
				action[empty-1]=7;
				empty=empty-1;
			}
		}
		}
	}
	
	for(ii = start; ii<group; ii++){  //  
		
		if ((wordsHomeFull[set[ii][0]])==(set[ii][1]))		 
			action[set[ii][0]]=6;	
		
		if ((wordsHomeFull[set[ii][1]])==(set[ii][0]))		 
			action[set[ii][1]]=6;
	}
	
	if (resourcesState==YES)
	{
		if (linkOptions==1){
			if ((fabs(currentTouch.x-mosaic.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-mosaic.y)<90+fontSizePad)) linkOptions=1; //dab
				else linkOptions=0;}

		if (linkOptions==2){
		if ((fabs(currentTouch.x-twit.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-twit.y)<90+fontSizePad)) linkOptions=2; // twit
		else linkOptions=0;}

		if (linkOptions==3){

		if ((fabs(currentTouch.x-review.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-review.y)<90+fontSizePad))linkOptions=3; // rev
	else linkOptions=0;}

		if (linkOptions==4){

		if ((fabs(currentTouch.x-mars.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-mars.y)<90+fontSizePad))linkOptions=4; //dev supp
else linkOptions=0;}

		if (linkOptions==5){

		if ((fabs(currentTouch.x-tellFriend.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-tellFriend.y)<90+fontSizePad))linkOptions=5; //friend
else linkOptions=0;}

		if (linkOptions==6){

		if ((fabs(currentTouch.x-piper.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-piper.y)<90+fontSizePad))linkOptions=6; //charity
else linkOptions=0;}

		
	}
	
	if (gospelState==YES){
		if (arrowHighlightRight==YES){
		if ((currentTouch.y<80+fontSizePad)) arrowHighlightRight=YES; else arrowHighlightRight=NO;
		}
		if (arrowHighlightLeft==YES){
		if ((currentTouch.y>rect.size.height-80-fontSizePad)) arrowHighlightLeft=YES;		else arrowHighlightLeft=NO;
		}
	}
	
	if((_firstTap==YES)){
		
		if (menuoption==1){
		if ((fabs(currentTouch.x-menuStart.x)<30+fontSizePad)&&
		    (fabs(currentTouch.y-menuStart.y)<90+fontSizePad*4))  menuoption=1;
		else menuoption=0;}

		if (menuoption==2){
		if ((fabs(currentTouch.x-menuInstruc.x)<30+fontSizePad)&&
		    (fabs(currentTouch.y-menuInstruc.y)<90+fontSizePad*3))  menuoption=2;
		else menuoption=0;}
		
		if (menuoption==3){
		if ((fabs(currentTouch.x-menuOptions.x)<30+fontSizePad)&&
		    (fabs(currentTouch.y-menuOptions.y)<90+fontSizePad*3))  menuoption=3;
		else menuoption=0;}
		if (menuoption==4){

		if (((fabs(currentTouch.x-gameModeXy.x))<40+fontSizePad)&&
			((fabs(currentTouch.y-gameModeXy.y))<160+fontSizePad))  menuoption=4;
		else menuoption=0;}
		if (menuoption==5){

if ((fabs(currentTouch.x-gospelXy.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-gospelXy.y)<90+fontSizePad))  menuoption=5;
else menuoption=0;}
		if (menuoption==6){
if ((fabs(currentTouch.x-resources.x)<30+fontSizePad)&&
			(fabs(currentTouch.y-resources.y)<90+fontSizePad))  menuoption=6;
		else menuoption=0;}
		
	}
	
}


// Called by touchesEnded:withEvent: when the user taps the screen

- (void)handleTap:(CGPoint)touchpt{

	
	//  youwin
	if (webViewState==YES){
		
		[webView removeFromSuperview];
		//[UIApplication sharedApplication].idleTimerDisabled = NO; giles73
		if (fresh==YES) [self refreshSetupForPlay];
		fresh=NO;
		animationState=YES;
		[_timer invalidate];
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		
		
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
		//_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(saveScore) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
		webViewState=NO;}

	else{
		
	touchpt.y= rect.size.height-touchpt.y;
		
		if (menuHighlighted==YES){{
//		if(touchpt.x<40+fontSizePad*2){//
//			if(touchpt.y<80+fontSizePad*3) {
				menuHighlighted=NO;
				if((menuState==NO)&&(instrucState==NO)&&(optionsState==NO)&&(_firstTap==NO)&&(pickedup==YES)&&(animationState==NO)){	
					/// put word where it goes b4 menu code
					//	if (pickedup==YES){  fbfb
					if (wordSwap==NO){
						words[empty].x=wordsHome[empty].x;
						
						words[empty].y=wordsHome[empty].y;
						
						wordsHomeFull[empty]=holding;
					}
					
					else if ((pickedup==YES)&&(swapReady!=-1)){
						
						holder =   holding;
						if ((dragged==YES)&&(wordsHomeFull[hover]!=holding)){
							holder = swapReady;
							wordsHomeFull[empty]=wordsHomeFull[hover];
							wordsHomeFull[hover]=holder;// wordsHomeFull[empty];
							dragged=NO;
						}
						else {   
							swapReady=-1;
						}
						words[empty].x=wordsHome[empty].x;
						words[empty].y=wordsHome[empty].y;
						pickedup=NO;
					}
				}
				
				
		//		score=1111;
				menuState=YES;_firstTap=YES;
				resourcesState=NO;
				if (toggleSound==YES) [sound2 play];
				//	if ((youWin>0)||(youFail>0)) {
				if ((youFail>0)) {
				//	verse+=1;if (verse>verseCount) verse=1;
					fresh=YES;youWin=0;youFail=0;seconds=51;
				}
				[_timer invalidate];
				_timer = nil;
				_firstTap=YES;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(menuScene) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES; 
				//	return;    /// THIS IS WHAT RUINED EVRYTHING!!!!!
			}
		}
		
		if(supportDevState==YES){

			if ((fabs(touchpt.x-site.x)<30+fontSizePad)&&
				(fabs(touchpt.y-site.y)<90+fontSizePad)){
				
				
				///  alertView no internet
				
				struct sockaddr_in zeroAddress;
				bzero(&zeroAddress, sizeof(zeroAddress));
				zeroAddress.sin_len = sizeof(zeroAddress);
				zeroAddress.sin_family = AF_INET;
				
				// Recover reachability flags
				SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
				SCNetworkReachabilityFlags flags;
				
				BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
				CFRelease(defaultRouteReachability);
				
				if (!didRetrieveFlags)
				{
					printf("Error. Could not recover network reachability flags\n");
					// return 0;
				}
				
				BOOL isReachable = flags & kSCNetworkFlagsReachable;
				BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
				if (isReachable&&!needsConnection) {
					
					//					webView or safari
					NSURL *url = [NSURL URLWithString:@"https://sites.google.com/site/ernestgames/"];
					[[UIApplication sharedApplication] openURL:url];
					
					
				} 
				else{
					
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Connection"  delegate:self cancelButtonTitle:nil  otherButtonTitles: @"Ok", nil];       
					
					if (flippedView==YES)  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
					else  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
					
					[alert show];
					[alert release];
					
				}
				
				
				
				
			}
			if ((fabs(touchpt.x-email.x)<30+fontSizePad)&&
				(fabs(touchpt.y-email.y)<90+fontSizePad)){  
				if (toggleSound==YES)[sound2 play];
				
				NSString *mailString = [NSString stringWithFormat: @"mailto:giles73@gmail.com?subject=Feedback&body=Hello,"]; 
				//	http://itunes.apple.com/us/app/living-word/id368884363?mt=8
				NSURL *urlString = [NSURL URLWithString:mailString];
				[[UIApplication sharedApplication] openURL: urlString];
				
				//  371901054  !! fat    lion lamb 
			}
			
//			supportDevState=NO;
			if (supportDevState==YES){
			if(touchpt.x<40+fontSizePad*2){//
				if(touchpt.y<80+fontSizePad*3) {
					
					[_timer invalidate];
					_timer = nil;
					[UIApplication sharedApplication].idleTimerDisabled = NO;
					supportDevState=NO;
				//	if (fresh==YES) [self refreshSetupForPlay];
				//	fresh=NO;
					resourcesState=YES;
					_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(resourcesScreen) userInfo:nil repeats:YES];
					[UIApplication sharedApplication].idleTimerDisabled = YES;
					return;
				}}
			}}	
		
	if(evangelState==YES){
		if ((fabs(touchpt.x-fb.x)<30+fontSizePad)&&
			(fabs(touchpt.y-fb.y)<90+fontSizePad)){
			
				
				///  alertView no internet
				
				struct sockaddr_in zeroAddress;
				bzero(&zeroAddress, sizeof(zeroAddress));
				zeroAddress.sin_len = sizeof(zeroAddress);
				zeroAddress.sin_family = AF_INET;
				
				// Recover reachability flags
				SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
				SCNetworkReachabilityFlags flags;
				
				BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
				CFRelease(defaultRouteReachability);
				
				if (!didRetrieveFlags)
				{
					printf("Error. Could not recover network reachability flags\n");
					// return 0;
				}
				
				BOOL isReachable = flags & kSCNetworkFlagsReachable;
				BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
				if (isReachable&&!needsConnection) {
					
					
					
					seconds+=40;
                    
                    if (translation==0)
                        [self justVerseToPraiseNIV];
                    else  if (translation==1)
                        [self justVerseToPraise];
                    else  if (translation==2)
                        [self justVerseToPraiseKJV];					
					//			setApartVerse=[NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
					
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.facebook.com/pages/Piano/294515390563390"]];

                    
//[fbAgent publishFeedWithName:[NSMutableString stringWithFormat:@"%@",setApartVerse]
	
//[fbAgent publishFeedWithName:[NSMutableString stringWithFormat:@""]  
	//			 captionText:@" is a Bible verse in the Living Word iPhone game. It's free! -click icon to check it out!"
 
			//		           captionText:@" is a Bible verse in the Living Word iPhone game. The Lord's words are Spirit, and they are life. Have fun getting the words of your favorite verses back in order... All free! -click icon to see"   
					//				 captionText:[NSMutableString stringWithFormat:@"%@...  is a Bible verse in the Living Word iPhone game. The Lord's words are Spirit, and they are life. Have fun getting the words of your favorite verses back in order!",setApartVerse]  
					 // Anyone who abides in His word is truly His disciple"  
					 //						 captionText:@"Have fun learning Bible verses in this iPhone game!"  
//                     imageurl:@"https://192873264224837399-a-1802744773732722657-s-sites.googlegroups.com/site/getyoursiteitsownapp/picture/crossIcon57.png?attachauth=ANoY7cqBfGS1u4__3eHDxpOqpzaGEjOY9BGavk6i8jxdMZx8zrMe2oQfdFupFuT1ecypv2f1i9ZRSARccqYBFZ5DcYZh8uz1tji990tKKaBNVY2sE8UHulQw_FZKc4Hjvi3NWBNHaBurL2uNXeL9y_-6s_xkuRO-OvwDFF6-1cPYQJ2OCkih3JIh65U1CXVNcXcnePtBSUkka7M_kNS7RzgbyoXOjkLdrRiIs2YZcX6qeENwPc5Vpko%3D&attredirects=0"
					 
					//		bigger 72			imageurl:@"http://8720053892903338511-a-1802744773732722657-s-sites.googlegroups.com/site/ernestgames/Home/crossIcon72.png?attachauth=ANoY7cr5Cb4NxKuT8zY-C8nyV0oPF0JbmxjQZqHU0ULdUNpNqgJx6EnvHTCn4e_m4rfpFgB1sFgvE0ASvk3YobGcvvrEkdfo8B5lcvWuFKo_62NrsTUUu-SFeMCgQkWy_zslZ7XkGRv_EAZ0gn7-x95zrce6Vn5O9KAFNUITtt-ygt6z2GOYFoMlKwaIudaq_0saC6Baa1w4GGcTeMv_hibogKi6h228KA%3D%3D&attredirects=0"  
					 //	 linkurl:@"http://sites.google.com/site/ernestgames"  
					 //		 linkurl:@"http://www.google.com/" 
					 //		 linkurl:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8"
					 
//                                         linkurl:@"http://itunes.apple.com/us/app/living-word/id371901054?mt=8"
					 
					 //http://itunes.apple.com/us/app/living-word/id368868565?mt=8
					 //linkurl:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8"
					 
//                               userMessagePrompt:@"What do you say?"];  
					
					
					
				} // rotate=YES;// NSLog(@"yay");
				else{
					
					
					//		[webView removeFromSuperview];  whitecolor
					
					if (fresh==YES) [self refreshSetupForPlay];
					fresh=NO;
					animationState=YES;
					[_timer invalidate];
					_timer = nil;
					[UIApplication sharedApplication].idleTimerDisabled = NO;
					
					
					_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
					
					[UIApplication sharedApplication].idleTimerDisabled = YES;
					webViewState=NO;
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Connection"  delegate:self cancelButtonTitle:nil  otherButtonTitles: @"Ok", nil];       
					
					//		if (_accelerometer[0]>0)  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
					//		else  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
					
					if (flippedView==YES)  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
					else  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
					
					[alert show];
					[alert release];
					
				}
				
				
			
			
		}
		if ((fabs(touchpt.x-review.x)<30+fontSizePad)&&
			(fabs(touchpt.y-review.y)<90+fontSizePad)){  
			if (toggleSound==YES)[sound2 play];
			
			UIApplication * application=[UIApplication sharedApplication];
			[application openURL:
			 //	 [NSURL URLWithString:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8"]];
			 [NSURL URLWithString:@"http://itunes.apple.com/us/app/living-word/id371901054?mt=8"]];
			//  371901054  !! fat    lion lamb 
		}
		
		
		// to game from evangel state
 if(touchpt.x<40+fontSizePad*2){//
 if(touchpt.y<80+fontSizePad*3) {
 
		[_timer invalidate];
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		evangelState=NO;
		if (fresh==YES) [self refreshSetupForPlay];
		fresh=NO;
		animationState=YES;
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
 }}
	}		
	else{
		
	if(resourcesState==YES){
		if (linkOptions==1){
//		if ((fabs(touchpt.x-mosaic.x)<30+fontSizePad)&&
//			(fabs(touchpt.y-mosaic.y)<90+fontSizePad)){  
			if (toggleSound==YES)[sound2 play];
			linkOptions=0;

			
			UIApplication* application=[UIApplication sharedApplication];
		[application openURL:
		 [NSURL URLWithString:@"http://itunes.apple.com/us/podcast/1-year-daily-audio-bible/id111065122"]];
			
		}
		if (linkOptions==2){

//		if ((fabs(touchpt.x-twit.x)<30+fontSizePad)&&
//			(fabs(touchpt.y-twit.y)<90+fontSizePad)){  
			if (toggleSound==YES)[sound2 play];
			linkOptions=0;

			//	[[TwitterAgent defaultAgent] twit ];  
			
			//	[[TwitterAgent defaultAgent] twit:@"Search with google!" ];  
			
			//	[[TwitterAgent defaultAgent] twit:@"Search with google!" withLink:@"http://www.google.com" makeTiny:NO];  
			//vv
		//	[[TwitterAgent defaultAgent] twit:@"Play Bible verse game on iPhone and iPad - Living Word" withLink:@"" makeTiny:YES];  
			//	[[TwitterAgent defaultAgent] twit:@"Play Bible game on iPhone/iPad - Living Word - Reorder words of verses!" withLink:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8" makeTiny:NO];  
			[[TwitterAgent defaultAgent] twit:@"Play a Bible game on the iPhone/iPad - Living Word - Word Scramble" withLink:@"http://itunes.apple.com/us/app/living-word/id371901054?mt=8" makeTiny:NO];  
			//	 [NSURL URLWithString:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8"]];
			return;
			
		}
		if (linkOptions==3){

//		if ((fabs(touchpt.x-review.x)<30+fontSizePad)&&
//			(fabs(touchpt.y-review.y)<90+fontSizePad)){  
			if (toggleSound==YES)[sound2 play];
			
			UIApplication * application=[UIApplication sharedApplication];
			[application openURL:
		//	 [NSURL URLWithString:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8"]];
			[NSURL URLWithString:@"http://itunes.apple.com/us/app/living-word/id371901054?mt=8"]];
			//  371901054  !! fat    lion lamb  Default-haha.png
		}
		if (linkOptions==4){

//		if ((fabs(touchpt.x-mars.x)<30+fontSizePad)&&
//			(fabs(touchpt.y-mars.y)<90+fontSizePad)){  
			
	//		{
				if (toggleSound == YES) [sound2 play];
				gospelState = YES;//menuState=YES;
				_firstTap = YES;
				linkOptions=0;

				[_timer invalidate]; 
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
			supportDevState=YES;

				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(supportDev) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES;
			return;
		//	}
		/*	
			if (toggleSound==YES)[sound2 play];
			
			NSString *mailString = [NSString stringWithFormat: @"mailto:giles73@gmail.com?subject=Feedback&body=Hello,"]; 
			//	http://itunes.apple.com/us/app/living-word/id368884363?mt=8
			NSURL *urlString = [NSURL URLWithString:mailString];
			[[UIApplication sharedApplication] openURL: urlString];*/
		}
		if (linkOptions==5){

//		if ((fabs(touchpt.x-tellFriend.x)<30+fontSizePad)&&
//			(fabs(touchpt.y-tellFriend.y)<90+fontSizePad)){  
			if (toggleSound==YES)[sound2 play];

	//		http://itunes.apple.com/us/app/living-word/id368868565?mt=8
		//	NSString *mailString = [NSString stringWithFormat: @"mailto:giles73@gmail.com?subject=LivingWordSupport&body="];  // works **
			
		//	NSString *mailString = [NSString stringWithFormat: @"mailto:friend?subject=CheckOutBibleGameApp&body=http://itunes.apple.com/us/app/living-word/id368868565?mt=8"]; 

			NSString *mailString = [NSString stringWithFormat: @"mailto:friend?subject=CheckOutBibleGameApp&body=http://itunes.apple.com/us/app/living-word/id371901054?mt=8"]; 

	//	http://itunes.apple.com/us/app/living-word/id368884363?mt=8
			NSURL *urlString = [NSURL URLWithString:mailString];
			[[UIApplication sharedApplication] openURL: urlString];

			
			//NSString *url = [NSString stringWithString: @"mailto:foo@example.com?cc=bar@example.com&subject=Greetings%20from%20Cupertino!&body=Wish%20you%20were%20here!"];

			/*
			NSString *mailString = [NSString stringWithFormat: @"mailto:?subject=LivingWord&body=Hey, check out this app!!: http://itunes.apple.com/us/app/living-word/id368868565?mt=8"];   //  
			NSURL *urlString = [NSURL URLWithString:mailString];
			[[UIApplication sharedApplication] openURL: urlString];
			*/
		}
		//  upgrade -  donate-- feature requests bug
		if (linkOptions==6){

//		if ((fabs(touchpt.x-piper.x)<30+fontSizePad)&&
//			(fabs(touchpt.y-piper.y)<90+fontSizePad)){  
			if (toggleSound==YES)[sound2 play];
			
			UIApplication * application=[UIApplication sharedApplication];
			[application openURL:
			 [NSURL URLWithString:@"http://www.ministrywatch.com/pdf/2009shininglightministries.pdf"]];
			
		}
		
	}
	
	if ((instrucState==YES)||(optionsState==YES)||(gospelState==YES)){	
		if (instrucState==YES)  if (toggleSound==YES) [sound2 play];

		
		if ((optionsState==YES)){
			if((fabs(rect.size.width*.5-touchpt.x)<30+fontSizePad)&&(fabs(rect.size.height/2-touchpt.y)<99+fontSizePad*3)){
			toggleSound=!toggleSound;
				[[NSUserDefaults standardUserDefaults] setBool: toggleSound forKey:@"sound"];
				stayOptions=YES;
				if (toggleSound==YES)[sound2 play];

			}
           else if((fabs(rect.size.width*.35-touchpt.x)<30+fontSizePad)&&(fabs(rect.size.height/2-touchpt.y)<99+fontSizePad*93)){
                translation++;if (translation>2) translation=0;
               
               
               [self loadNewVerseToPraise];      
               NSLog(@"loadNewVerseToPraise");

               [[NSUserDefaults standardUserDefaults] setInteger: translation forKey:@"translation"];
				stayOptions=YES;
				if (toggleSound==YES)[sound2 play];
                
			}
            
            
            
            
			if ((touchpt.x>80+fontSizePad*2)||(touchpt.y>80+fontSizePad*3)) stayOptions=YES;
		}
		if (gospelState==YES){
			if ((touchpt.x>80+fontSizePad*2)||(touchpt.y>80+fontSizePad*3)) {
				
				stayGospel=YES;
			//	if ((touchpt.y<80+fontSizePad)) verse++; if (verse>verseCount-1) verse=1;
			//	if ((touchpt.y>rect.size.height-80-fontSizePad)) verse--;if (verse<1) verse=verseCount-1; 
				
				if (arrowHighlightRight) verse++; if (verse>verseCount-1) verse=1;
				if (arrowHighlightLeft) verse--;if (verse<1) verse=verseCount-1; 
				//praise be to God   -- AMEN!!!
				arrowHighlightLeft=NO; arrowHighlightRight=NO;
			}
			
			else [self refreshSetupForPlay];
			
		}
		
		if (optionsState==NO){
		if ((gospelState==NO)||(touchpt.y>rect.size.height-80-fontSizePad)||(touchpt.y<80+fontSizePad)) {
			if (toggleSound==YES)[sound2 play];}
		}
		_firstTap=YES;
		instrucState=NO;optionsState=NO;gospelState=NO;resourcesState=NO;
		menuState=YES;
		holding=hover;
		
		[_timer invalidate]; 
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(menuScene) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
		
	}
	
	else{
		
		/// code for bible text
		if (internetIsAvailable==YES){
		if((touchpt.x<(40+fontSizePad*2))&&(touchDownInBibleIcon==YES)){//
			if(fabs(touchpt.y-rect.size.height*.35)<(40+fontSizePad*.7)) {
					
					if (webViewState==NO){
						
						///  alertView no internet
						
						struct sockaddr_in zeroAddress;
						bzero(&zeroAddress, sizeof(zeroAddress));
						zeroAddress.sin_len = sizeof(zeroAddress);
						zeroAddress.sin_family = AF_INET;
						
						// Recover reachability flags
						SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
						SCNetworkReachabilityFlags flags;
						
						BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
						CFRelease(defaultRouteReachability);
						
						if (!didRetrieveFlags)
						{
							printf("Error. Could not recover network reachability flags\n");
							// return 0;
						}
						
						BOOL isReachable = flags & kSCNetworkFlagsReachable;
						BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
						if (isReachable&&!needsConnection) {
					//	kk=0;
					//	if(kk==0){
							kk=0;
							 //	[self internetScreen];
							 internetState=YES;  //_firstTap=YES;
							 webViewState=YES;
							 if (toggleSound==YES) [sound2 play];
							 if ((youWin>0)||(youFail>0)) {
							 verse+=1;if (verse>verseCount) verse=1;
							 fresh=YES;
							 youWin=0;youFail=0;}
							
						} // rotate=YES;// NSLog(@"yay");
						else{
							
							
							//		[webView removeFromSuperview];  whitecolor
							
							if (fresh==YES) [self refreshSetupForPlay];
							fresh=NO;
							animationState=YES;
							[_timer invalidate];
							_timer = nil;
							[UIApplication sharedApplication].idleTimerDisabled = NO;
							
							
							_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
							
							[UIApplication sharedApplication].idleTimerDisabled = YES;
							webViewState=NO;
							
							UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Connection"  delegate:self cancelButtonTitle:nil  otherButtonTitles: @"Ok", nil];       
							
							if (_accelerometer[0]>0)  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
							else  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
							
							[alert show];
							[alert release];
							
						}
						
						
					}
						return;
				}}
				
				/// code for FB FB FBF BFBFBFB
				if((touchpt.x<40+fontSizePad*2)&&(touchDownInFB==YES)){//
					if(fabs(touchpt.y-rect.size.height*.65)<40+fontSizePad*3) {		

				if (webViewState==NO){
			
					///  alertView no internet
					
					struct sockaddr_in zeroAddress;
					bzero(&zeroAddress, sizeof(zeroAddress));
					zeroAddress.sin_len = sizeof(zeroAddress);
					zeroAddress.sin_family = AF_INET;
					
					// Recover reachability flags
					SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
					SCNetworkReachabilityFlags flags;
					
					BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
					CFRelease(defaultRouteReachability);
					
					if (!didRetrieveFlags)
					{
						printf("Error. Could not recover network reachability flags\n");
						// return 0;
					}
					
					BOOL isReachable = flags & kSCNetworkFlagsReachable;
					BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
					if (isReachable&&!needsConnection) {
					
						//	[fbAgent setStatus:@"I love cookies"];  
						//
		//			[fbAgent publishFeedWithName:@"God's Word is powerful God's Word is powerful God's Word is powerful God's Word is powerful God's Word is powerful"  
					
					
				//		praise=[NSString stringWithFormat:@"johnIn the beginning was the Word, and the Word was with God, and the Word was God"];
				//		praise=[NSString stringWithFormat:@"John 14:15 If you love me, keep my commands"];
		//				setApartVerse=[NSString stringWithFormat:@"John 14:15 If you love me, keep my commands"];
						//		setApartVerse=[NSString stringWithFormat:@"%@",praiseFormatted];
//						setApartVerse=[NSString stringWithFormat:@"%@ %@",book,chapVerse];
//						[self justVerseToPraise];

                        if (translation==0)
                            [self justVerseToPraiseNIV];
                        else  if (translation==1)
                            [self justVerseToPraise];
                        else  if (translation==2)
                            [self justVerseToPraiseKJV];
			//			setApartVerse=[NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
						
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.facebook.com/pages/Piano/294515390563390"]];

                        
//        [fbAgent publishFeedWithName:[NSMutableString stringWithFormat:@"%@",setApartVerse]
				
		 //              
			//			 captionText:@" is a Bible verse in the Living Word iPhone game. The Lord's words are Spirit, and they are life. Anyone who abides in His word is truly His disciple"
//						 captionText:@"Have fun learning Bible verses in this iPhone game!"  
		//									imageurl:@"http://8720053892903338511-a-1802744773732722657-s-sites.googlegroups.com/site/ernestgames/Home/crossIcon72.png?attachauth=ANoY7cr5Cb4NxKuT8zY-C8nyV0oPF0JbmxjQZqHU0ULdUNpNqgJx6EnvHTCn4e_m4rfpFgB1sFgvE0ASvk3YobGcvvrEkdfo8B5lcvWuFKo_62NrsTUUu-SFeMCgQkWy_zslZ7XkGRv_EAZ0gn7-x95zrce6Vn5O9KAFNUITtt-ygt6z2GOYFoMlKwaIudaq_0saC6Baa1w4GGcTeMv_hibogKi6h228KA%3D%3D&attredirects=0"
						//	 linkurl:@"http://sites.google.com/site/ernestgames"  
					//		 linkurl:@"http://www.google.com/" 
					//		 linkurl:@"http://itunes.apple.com/us/app/living-word/id368884363?mt=8"
		 
//                             linkurl:@"http://itunes.apple.com/us/app/living-word/id371901054?mt=8"

//http://itunes.apple.com/us/app/living-word/id368868565?mt=8
//		 http://itunes.apple.com/us/app/living-word/id368884363?mt=8

//                   userMessagePrompt:@"What do you think?"];
						
						
						/*
						
						// counter
						kk=0;
						//	[self internetScreen];
						internetState=YES;  //_firstTap=YES;
						webViewState=YES;
						//resourcesState=NO;
						if (toggleSound==YES) [sound2 play];
						if ((youWin>0)||(youFail>0)) {
						verse+=1;if (verse>verseCount) verse=1;
						fresh=YES;
						youWin=0;youFail=0;}
					*/
					
					} // rotate=YES;// NSLog(@"yay");
					else{
						
						
					//		[webView removeFromSuperview];  whitecolor

						if (fresh==YES) [self refreshSetupForPlay];
							fresh=NO;
							animationState=YES;
							[_timer invalidate];
							_timer = nil;
							[UIApplication sharedApplication].idleTimerDisabled = NO;
							
							
							_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
					
							[UIApplication sharedApplication].idleTimerDisabled = YES;
							webViewState=NO;
						
						UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No Connection"  delegate:self cancelButtonTitle:nil  otherButtonTitles: @"Ok", nil];       
						
				//		if (_accelerometer[0]>0)  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
				//		else  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
					
						if (flippedView==YES)  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
						else  [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;

						[alert show];
						[alert release];
						
					}
					
					
				}
			
			}
					return;//  now menu and webview
				}
		}
		
		if(touchpt.x<40+fontSizePad*2){//
			if(touchpt.y<80+fontSizePad*3) {
				
				if((menuState==NO)&&(instrucState==NO)&&(optionsState==NO)&&(_firstTap==NO)&&(pickedup==YES)&&(animationState==NO)){	
					/// put word where it goes b4 menu code
				//	if (pickedup==YES){
					if (wordSwap==NO){
						words[empty].x=wordsHome[empty].x;
						
						words[empty].y=wordsHome[empty].y;
						
						wordsHomeFull[empty]=holding;
					}
					
					else if ((pickedup==YES)&&(swapReady!=-1)){
					
						holder =   holding;
						if ((dragged==YES)&&(wordsHomeFull[hover]!=holding)){
							holder = swapReady;
							wordsHomeFull[empty]=wordsHomeFull[hover];
							wordsHomeFull[hover]=holder;// wordsHomeFull[empty];
							dragged=NO;
						}
						else {   
							swapReady=-1;
						}
						words[empty].x=wordsHome[empty].x;
						words[empty].y=wordsHome[empty].y;
						pickedup=NO;
					}
				}
				
				
		//		score=1111;
				menuState=YES;_firstTap=YES;
				resourcesState=NO;
				if (toggleSound==YES) [sound2 play];
			//	if ((youWin>0)||(youFail>0)) {
					if ((youFail>0)) {
					verse+=1;if (verse>verseCount) verse=1;
					fresh=YES;youWin=0;youFail=0;
				}
				_firstTap=YES;
				[_timer invalidate];
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(menuScene) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES; 
				//	return;
			}
		}
		
		
		//  seconds==
		////  end of menu code ...  set words   youwin
		if((menuState==NO)&&(instrucState==NO)&&(optionsState==NO)&&(_firstTap==NO)&&(pickedup==YES)&&(animationState==NO)&&(evangelState==NO)){	
			
			
			if (wordSwap==NO){
			
				words[empty].x=wordsHome[empty].x;
	
				words[empty].y=wordsHome[empty].y;
		
				wordsHomeFull[empty]=holding;
			}
			
			else if ((pickedup==YES)&&(swapReady!=-1)){
				holder =   holding;//          wordsHomeFull[empty];
				//dragged=YES;
				//dragged  not working for non dragging
				//if ((dragged==YES)){
					if ((dragged==YES)&&(wordsHomeFull[hover]!=holding)){
				holder = swapReady;
				wordsHomeFull[empty]=wordsHomeFull[hover];
				wordsHomeFull[hover]=holder;// wordsHomeFull[empty];
					dragged=NO;
						//score+=100;
				}
				
				else {   /// works only when words are right
					/*
					if (swapReady!=wordsHomeFull[holding]){
					holder = swapReady;//wordsHomeFull[swapReady];
					wordsHomeFull[swapReadyIndex]=wordsHomeFull[holding];
					wordsHomeFull[holding]=holder;   */ // good??
					swapReady=-1;
				//	}
				}
				
				//swapReady=-1;
				//if (pickedup==NO) swapReady=-1;

//				score=wordsHomeFull[hover];
//				seconds=wordsHomeFull[empty];
			//	score+=100;
				
				words[empty].x=wordsHome[empty].x;
				words[empty].y=wordsHome[empty].y;
				pickedup=NO;
			}
		
		
		
		///   are they all in order???	  savesco
				
		for(ii = 0; ii<stringLength; ii++){
			if(wordsHomeFull[ii]==ii)
				action[ii]=6;
			else {
				action[ii]=5;
			}}
		
		for(ii = start; ii<group; ii++){  //  
			
			if ((wordsHomeFull[set[ii][0]])==(set[ii][1]))		 
				action[set[ii][0]]=6;	
			
			if ((wordsHomeFull[set[ii][1]])==(set[ii][0]))		 
				action[set[ii][1]]=6;
		}
		
		
		allInOrder=YES;	howManyOutOfOrder=0;
		
		for(ii = 0; ii<stringLength; ii++){
			if(action[ii]!=6) {allInOrder=NO; howManyOutOfOrder++;}
		}
		
		if (toggleSound==YES) {
			if (howManyOutOfOrder>=howManyOutOfOrderLastTime) [sound3 play];
			else [sound7 play];
		}
		
		howManyOutOfOrderLastTime=howManyOutOfOrder;
		
		
		
		if ((allInOrder==YES)&&(youWin<1)) {
			youWin=1;userTouchedScreenToContinue=NO;
		}
		
			return;
		}
		
		//counter=202;
		blockdown=NO;
		first=5;
		//touched=touchpt;
		touched.y=touchpt.y;
		//touched.y-=100;
		
		touched.x=touchpt.x;
		
		
		//if(touchpt.y<40) scroll=!scroll;
		
		/*
		if (_state!=kState_StandBy){
			if ((first==10)&&(pressed==YES)&&(_firstTap==NO)){
				
				//	stopturn=0;		
				//if (toggleSound==YES) [stung play];
				[sound1 play];
			}
		}
		*/
		 //  font score
		
		if (_firstTap==YES){
			
			
			if ((menuoption==1)) {
				
				if (toggleSound==YES) [sound2 play];
				
				_firstTap=NO;
				instrucState=NO;optionsState=NO;menuState=NO;
				holding=hover;
				swapReady=-1;
				menuoption=0;
				
				/*
				/// mail to me  **works
				NSString *mailString = [NSString stringWithFormat: @"mailto:giles73@gmail.com?subject=LivingWordSupport&body="];
				NSURL *urlString = [NSURL URLWithString:mailString];
				[[UIApplication sharedApplication] openURL: urlString];
				
				
				// point to upgrade  -- feedback
				UIApplication * application=[UIApplication sharedApplication];
				[application openURL:
				 [NSURL URLWithString:@"http://phobos.apple.com/us/app/living-word/id368868565?mt=8"]];

				// point to piper **
				UIApplication * application=[UIApplication sharedApplication];
				[application openURL:
				 [NSURL URLWithString:@"http://itunes.apple.com/us/podcast/desiring-god-sermon-audio/id196050704"]];
			//	*/
				
				[_timer invalidate];
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				
		//		[self loadNewVerseToPraise];
				if (fresh==YES) [self refreshSetupForPlay];
				fresh=NO;
				//[self refreshSetupForPlay];
				animationState=YES;
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
				
		//		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(saveScore) userInfo:nil repeats:YES];

				
				[UIApplication sharedApplication].idleTimerDisabled = YES;
				
				//[self resetGame];
			} 
			// stringlength
			if (menuoption==2){
				if (toggleSound==YES) [sound2 play];
				instrucState=YES;//menuState=YES;
			//	_firstTap=YES;
				
				[_timer invalidate]; // score:
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(instructionScreen) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES;
				menuoption=0;

				
			}
			
			if ((menuoption==3)||(stayOptions==YES)){	//themechanged=YES;
				if (toggleSound==YES) [sound2 play];
				stayOptions=NO;
				_firstTap=YES;
				optionsState=YES;
				menuoption=0;

				[_timer invalidate]; // score:
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(optionScreen) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES;
			}
			if ((menuoption==4)){	//themechanged=YES;
				if (toggleSound==YES) [sound2 play];
				gameModeSelection++; if(gameModeSelection>2)gameModeSelection=0;
				[[NSUserDefaults standardUserDefaults] setInteger: gameModeSelection forKey:@"mode"];
				menuoption=0;

				_firstTap=YES;
				[self refreshSetupForPlay]; // randomness
			}
			
			
			if (menuoption==5){
				if (toggleSound == YES) [sound2 play];
				gospelState = YES;//menuState=YES;
				_firstTap = YES;
				arrowHighlightLeft=NO;arrowHighlightRight=NO;
				menuoption=0;

				[_timer invalidate]; 
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(gospelScreen) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES;
			}
			
			if (menuoption==6){
				if (toggleSound == YES) [sound2 play];
				resourcesState = YES;//menuState=YES;
				_firstTap = YES;
				menuoption=0;

				[_timer invalidate]; 
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(resourcesScreen) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES;
			}
			
			menuoption=0;}
		
			}
	
	if ((stayOptions==YES)){	//themechanged=YES;
		//if (toggleSound==YES) [pick play]; // win play
		stayOptions=NO;
		_firstTap=YES;
		optionsState=YES;
		
		[_timer invalidate]; // score:
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(optionScreen) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
	}
	
	if ((stayGospel==YES)){	//themechanged=YES;
	//	if (toggleSound==YES) [pick play]; // win play
		stayGospel=NO;
		_firstTap=YES;
		gospelState=YES;
		arrowHighlightLeft=NO;arrowHighlightRight=NO;
		menuoption=0;
		[_timer invalidate]; // score:
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(gospelScreen) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
	}
	
//	if (pickedup==NO) swapReady=-1;
	pickedup=NO;
}
}
	linkOptions=0;
	menuoption=0; // dev support
	userTouchedScreenToContinue=YES;
}

- (void) resourcesScreen {
		
		[self drawBackground];
	fadeIn=1;
	
		glPushMatrix();
		if (device==1) glTranslatef(251,251, 1);
		else glTranslatef(rect.size.width*.78, rect.size.height*.52,1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
		glColor4f(1, 1, .5, fadeIn);
		glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
		[_textures[resourcesTitleText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		
	
	mosaic.x=.57*rect.size.width;
	mosaic.y=.75*rect.size.height;
	
	piper.x=.57*rect.size.width;
	piper.y=.26*rect.size.height;
	
	if (device==1){
		mosaic.x=.57*rect.size.width;
		mosaic.y=.72*rect.size.height;
		
		piper.x=.57*rect.size.width;
		piper.y=.29*rect.size.height;
	}

/*
	mosaic.x=.45*rect.size.width;
	mosaic.y=.71*rect.size.height;
	
	piper.x=.45*rect.size.width;
	piper.y=.29*rect.size.height;
	*/
		mars.x=.40*rect.size.width;
		mars.y=.27*rect.size.height;
		
	//tellFriend.x=.23*rect.size.width;
	//tellFriend.y=.5*rect.size.height;

	tellFriend.x=.23*rect.size.width;
	tellFriend.y=.74*rect.size.height;
	
	twit.x=.23*rect.size.width;
	twit.y=.25*rect.size.height;
		
	review.x=.40*rect.size.width; 		
	review.y=.71*rect.size.height;  ////   //
	
	if (device==1){
	review.x=.40*rect.size.width;  
	review.y=.64*rect.size.height; 	
	}
	
		glPushMatrix();
		glTranslatef(mosaic.x+1,mosaic.y+1, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
//		glColor4f(1, 1, .5, fadeIn);   // resourcessta
	if (linkOptions==1) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
		glRotatef(-90, 0, 0, 1);	
		[_textures[mosaicText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		
	
		glPushMatrix();
		glTranslatef(piper.x+1,piper.y+1, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (linkOptions==6) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
//glColor4f(1, 1, .5, fadeIn);
		glRotatef(-90, 0, 0, 1);//	if (flipped==YES)glRotatef(180, 0, 0, 1);
		
		[_textures[piperText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		
		glPopMatrix();
		//[_textures[tex] release];
		
		
		
		
		glPushMatrix();
		glTranslatef(mars.x+1,mars.y+1, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (linkOptions==4) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
//glColor4f(1, 1, .5, fadeIn);
		glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
		
		[_textures[marsText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		
		glPopMatrix();
		
		
	glPushMatrix();
	glTranslatef(twit.x+1,twit.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (linkOptions==2) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
//glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
	
	[_textures[twitText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	glPopMatrix();
	
		
		
		glPushMatrix();
		glTranslatef(tellFriend.x+1,tellFriend.y+1, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (linkOptions==5) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
//glColor4f(1, 1, .5, fadeIn);
		glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
	//	if (gameModeSelection==1)[_textures[gameModeText] drawAtPoint:CGPointZero];
	//	else if(gameModeSelection==2)[_textures[altgameModeText] drawAtPoint:CGPointZero];
	//	else if (gameModeSelection==0)
			
			[_textures[tellFriendText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		
		glPopMatrix();
		
		
		
		
		glPushMatrix();
		glTranslatef(review.x+1,review.y+1, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (linkOptions==3) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
//glColor4f(1, 1, .5, fadeIn);
		glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
		
		[_textures[reviewText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		
		glPopMatrix();
		
		[self autoRotate];
		
		
	
	
}
- (void) setupAnimation {
	
	[self drawBackground ];
	amplitude=-2;

	for(ii = 0; ii<stringLength; ii++){
	//	for(ii = 0; ii<5; ii++){   youWin

	glPushMatrix();

		//if (action[ii]!=7)	
		glTranslatef(words[ii].x-8+amplitude*counter*sin(counter/7+ii),words[ii].y+amplitude*counter*cos(counter/7+ii), 1);
//	else glTranslatef(words[ii].x-18,words[ii].y, 1);
	
//	if (action[ii]!=7)	
		glScalef(.5, .5, 1);
	
		
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	
	if(action[ii]<6) {red= 1;green=.3;blue=.3;}
	else if (action[ii]==6)  {red= .3;green=1;blue=.3;}
	else if (action[ii]==7) {red= .1;green=.5;blue=.7;}

	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	
	glColor4f(red, green, blue,  .5);
	
	glRotatef(90, 0, 0, 1);
	
	xStretch=.27;
	
	
	
	//if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
		//if (action[ii]!=7)
	//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
			//if (action[ii]!=7)
	//		makeShadowsLonger= [[array objectAtIndex:wordsHomeFull[ii]]length];
		
		
	//	makeShadowsLonger= [[array objectAtIndex:wordsHomeFull[ii]]length];
	
		makeShadowsLonger=	wordsHomeFull[ makeLettersSmaller[ii]];

		makeShadowsLonger=shadowLength[ii];
		
	if (makeShadowsLonger>6) makeShadowsLonger=6+2*(makeShadowsLonger-6)/3;
	
	if (device==0) {
		glScalef( 2, 2, 1);//
		glTranslatef(0, 10, 0);
	}
	
	glScalef((.4+makeShadowsLonger/4),xStretch, 1);
	
		if (counterForRedBig>0){
			if (action[ii]!=6)
				glScalef(1+1.1*sin(counterForRedBig*3.14/12), 
						 1+1.1*sin(counterForRedBig*3.14/12), 1);}
		
		
		pickedup=NO; //hover=-1;
	//if ((pickedup==NO)||(ii!=hover)) 
	
	
//	glPushMatrix();
///	glTranslatef(200, 200, 1);
	[_textures[kTexture_Star] drawAtPoint:CGPointZero];
	
	glPopMatrix();
	
	
		
		glPushMatrix();
		//glTranslatef(words[ii].x,words[ii].y, 1);
		glTranslatef(words[ii].x+amplitude*counter*sin(counter/7+ii),words[ii].y+amplitude*counter*cos(counter/7+ii), 1);

	//	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	//	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	//	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
		
		//glColor4f(1-red, 1-green, 1-blue, 1);
		
		//if (youWin>0) glColor4f(1, 1, 0, 1);
		//else glColor4f(1, 1, 1, .5);
		
		if (youWin>0) glColor4f(1, 1, 0, 1);
		else //glColor4f(red, green, blue,  .9);
			glColor4f(0,0,0,  .9);
		//if (youWin>0) glColor4f(1, 1, 0, 1);
		//else glColor4f(1, 1, 1, .5);
		
		glRotatef(-90, 0, 0, 1);
		//glTranslatef(0 , 10, 0);
		
		if (action[ii]!=7)	glScalef(.5, .5, 1);
		
	//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
			[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
	//	else
	//		[verseWords[holding] drawAtPoint:CGPointZero];
		
		if (youWin>0) glColor4f(1, 1, 0, 1);
		else glColor4f(1,1,.5, 1);
		//glTranslatef(-1 , 1, 0);
		
		
		
	//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
			[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
	//	else
	//		[verseWords[holding] drawAtPoint:CGPointZero];
		
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
	
	}
	
	
	
	
	
	[self autoRotate];
	
	
	counter+=2;
	if (counter>-2){counter=0;counterForRedBig+=2;}
	
//	if (counter>-2) {
	if ((counterForRedBig>=2)&&(counterForRedBig<4)&&(toggleSound==YES)) [sound7 play];
		if (counterForRedBig>12) {
			counterForRedBig=0;
		counter=-20;  // ---20
		animationState=NO;
			/// is reachy?
		[_timer invalidate];
		_timer = nil;    
			//evangelState=NO;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(saveScore) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
	}
	
	
}
- (void) animateToWeb {


	
	[self drawBackground ];
	
	if(counterInvert<-50){
	
	glPushMatrix();
	if (device==1) glTranslatef(.25*rect.size.width,rect.size.height/2, 1);
    else glTranslatef(.35*rect.size.width,rect.size.height/2, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );	
		if (counterInvert>-80)
	glColor4f(1, 1, .5, ((counterInvert*-1)-50)/30);
		
		if (counterInvert<-100)
			glColor4f(1, 1, .5, (6-((counterInvert*-1)-100))/6);
	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
	
	[_textures[endWebOnBorderText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	
	glPopMatrix();
	}
	
	amplitude=-2;
	
	for(ii = 0; ii<stringLength; ii++){
		//	for(ii = 0; ii<5; ii++){   youWin
		
		glPushMatrix();
		
//		glTranslatef(words[ii].x-8+amplitude*counterInvert*sin(counterInvert/7+ii),words[ii].y+amplitude*counterInvert*cos(counterInvert/7+ii), 1);
		
		//moveOut.x=words[ii].x-8+-counterInvert/10*((words[ii].x-rect.size.width/2))*sin(-counterInvert/40);
		//moveOut.y=words[ii].y-8+-counterInvert/10*((words[ii].y-rect.size.height/2))*sin(-counterInvert/40);
		if (counterInvert<-60) bigOut=10; else bigOut=1;
		moveOut.x=words[ii].x-8+-bigOut*counterInvert/10*((words[ii].x-rect.size.width/2))*-.1*sin(counterInvert/20+3.14);
		moveOut.y=words[ii].y-8+-bigOut*counterInvert/10*((words[ii].y-rect.size.height/2))*-.1*sin(counterInvert/20+3.14);

		glTranslatef(moveOut.x,moveOut.y, 1);

		//glTranslatef(words[ii].x-8+-counterInvert/10*((words[ii].x-rect.size.width/2)),words[ii].y+				   -counterInvert/10*((words[ii].y-rect.size.height/2)), 1);
		
		//	if (action[ii]!=7)	
		glScalef(.5, .5, 1);
		
		
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		
		if(action[ii]<6) {red= 1;green=.3;blue=.3;}
		else if (action[ii]==6)  {red= .3;green=1;blue=.3;}
		else if (action[ii]==7) {red= .1;green=.5;blue=.7;}
		
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
		
		glColor4f(red, green, blue,  .5);
		
		glRotatef(90, 0, 0, 1);
		
		xStretch=.27;
		
		
		
		//if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
		//if (action[ii]!=7)
		//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
		//if (action[ii]!=7)
		//		makeShadowsLonger= [[array objectAtIndex:wordsHomeFull[ii]]length];
		
		
		//	makeShadowsLonger= [[array objectAtIndex:wordsHomeFull[ii]]length];
		
		makeShadowsLonger=	wordsHomeFull[ makeLettersSmaller[ii]];
		
		makeShadowsLonger=shadowLength[ii];
		
		if (makeShadowsLonger>6) makeShadowsLonger=6+2*(makeShadowsLonger-6)/3;
		
		if (device==0) {
			glScalef( 2, 2, 1);//
			glTranslatef(0, 10, 0);
		}
		
		glScalef((.4+makeShadowsLonger/4),xStretch, 1);
		
		
		
		pickedup=NO; //hover=-1;
		//if ((pickedup==NO)||(ii!=hover)) 
		
		
		//	glPushMatrix();
		///	glTranslatef(200, 200, 1);
		[_textures[kTexture_Star] drawAtPoint:CGPointZero];
		
		glPopMatrix();
		
		
		
		glPushMatrix();
		//glTranslatef(words[ii].x,words[ii].y, 1);
		//glTranslatef(words[ii].x+amplitude*counterInvert*sin(counterInvert/7+ii),words[ii].y+amplitude*counterInvert*cos(counterInvert/7+ii), 1);
		
//		glTranslatef(words[ii].x-8+-counterInvert/10*((words[ii].x-rect.size.width/2)),words[ii].y+				   -counterInvert/10*((words[ii].y-rect.size.height/2)), 1);
		glTranslatef(moveOut.x,moveOut.y, 1);


		//	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		//	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		//	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
		
		//glColor4f(1-red, 1-green, 1-blue, 1);
		
		//if (youWin>0) glColor4f(1, 1, 0, 1);
		//else glColor4f(1, 1, 1, .5);
		
		if (youWin>0) glColor4f(1, 1, 0, 1);
		else //glColor4f(red, green, blue,  .9);
			glColor4f(0,0,0,  .9);
		//if (youWin>0) glColor4f(1, 1, 0, 1);
		//else glColor4f(1, 1, 1, .5);
		
		glRotatef(-90, 0, 0, 1);
		//glTranslatef(0 , 10, 0);
		
		if (action[ii]!=7)	glScalef(.5, .5, 1);
		
		//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
		[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
		//	else
		//		[verseWords[holding] drawAtPoint:CGPointZero];
		
		if (youWin>0) glColor4f(1, 1, 0, 1);
		else glColor4f(1,1,.5, 1);
		//glTranslatef(-1 , 1, 0);
		
		
		
		//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
		[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
		//	else
		//		[verseWords[holding] drawAtPoint:CGPointZero];
		
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		
	}
	
	
	
	
	
	[self autoRotate];
	
	if (counterInvert==-20)	[self drawBackground];

	counterInvert-=4;
	//	if (counter>0)counter=-30;
	if (counterInvert<-110) {
		counterInvert=  -4;  // ---20
		animationState=NO;
		[_timer invalidate];
		_timer = nil;      
		[UIApplication sharedApplication].idleTimerDisabled = NO;

	//	[self drawBackground];
	//	[self drawBackground];
	//	[self drawBackground];
	//	[self drawBackground];
		[self drawBackground];
		///webView
		//webView.
		[window addSubview:webView];  //  animated:YES]; 
	//	window addSubview:
		[self drawBackground];

	}
	
	
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[sound1 play];
    [sound2 play];
	[sound3 play];
	[sound4 play];
}
- (void) evangel {
	_firstTap=NO;
	menuoption=0;
	// 
//	youWin
	//copy links?? 
	//handleTap ---back to game
	
	
	//go make disciples???
	[self drawBackground];
	
//	_textures[evangelText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Thanks for playing,\nGod's word is powerful!\nHelp others get more with this app:"]dimensions:CGSizeMake(472+fontSizePad*25, 320+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:(16+fontSizePad)];

	// review 
	glPushMatrix();
	glTranslatef(.58*rect.size.width,.5*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glRotatef(-90, 0, 0, 1);
//	if(device==0) glScalef(.5, .5, 1);
	//	else glScalef(.37, .37, 1);
//	else glScalef(.23, .23, 1);
	[_textures[evangelText] drawAtPoint:CGPointZero];
//	[_textures[mosaicText] drawAtPoint:CGPointZero];

	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	/*
	mars.x=.39*rect.size.width;
	mars.y=.27*rect.size.height;
	
	tellFriend.x=.23*rect.size.width;
	tellFriend.y=.68*rect.size.height;
	
	review.x=.39*rect.size.width;  //// 
	review.y=.68*rect.size.height;  ////   //
	
	fb.x=.23*rect.size.width;  //// 
	fb.y=.27*rect.size.height;  ////   //
	*/
	
	fb.x=.37*rect.size.width;
	fb.y=.27*rect.size.height;
	
	tellFriend.x=-.26*rect.size.width;
	tellFriend.y=.5*rect.size.height;
	
	review.x=.37*rect.size.width;  //// 
	review.y=.68*rect.size.height;  ////   //
	
	if (device==1){
		fb.x=.44*rect.size.width;
		fb.y=.17*rect.size.height;
		
		review.x=.44*rect.size.width;  //// 
		review.y=.62*rect.size.height; 
	}
	
	glPushMatrix();
	glTranslatef(fb.x+1,fb.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	
	glScalef(.9, .9, 1);
	[_textures[fbText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	/*
	glPushMatrix();
	glTranslatef(tellFriend.x+1,tellFriend.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	
	glScalef(.9, .9, 1);

	[_textures[tellFriendText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	*/
		
	glPushMatrix();
	glTranslatef(review.x+1,review.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	
	glScalef(.9, .9, 1);

	[_textures[reviewText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	[self autoRotate];
	
}
- (void) supportDev {
	/*
    [MKStoreManager sharedManager];

    [[MKStoreManager sharedManager] buyFeature:<strong>@"com.mycompany.myapp.feature1"</strong> 
                                    onComplete:^(NSString* purchasedFeature)
     {
         NSLog(@"Purchased: %@", purchasedFeature);
         // provide your product to the user here.
         // if it's a subscription, allow user to use now.
         // remembering this purchase is taken care of by MKStoreKit.
     }
                                   onCancelled:^
     {
         // User cancels the transaction, you can log this using any analytics software like Flurry.
     }];
    */
	[self drawBackground];
	glPushMatrix();
	if (device==1) ///  menuscen
	glTranslatef(.63 *rect.size.width,.5*rect.size.height, 1);
	else   
	glTranslatef(.78*rect.size.width,.5*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glRotatef(-90, 0, 0, 1);
	[_textures[supportText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();

	
	email.x=.47*rect.size.width;
	email.y=.57*rect.size.height;
	
	//tellFriend.x=-.26*rect.size.width;  ebview
	//tellFriend.y=.5*rect.size.height;
	
	site.x=.47*rect.size.width;  //// 
	site.y=.32*rect.size.height;  ////   //
	
	if (device==1){
		email.x=.44*rect.size.width;
		email.y=.12*rect.size.height;
		
		site.x=.44*rect.size.width;  //// 
		site.y=.57*rect.size.height; 
	}
	
	glPushMatrix();
	glTranslatef(email.x+1,email.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	
	glScalef(.9, .9, 1);
	[_textures[emailText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	glPushMatrix();
	glTranslatef(site.x+1,site.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	
	glScalef(.9, .9, 1);
	
	[_textures[siteText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	[self autoRotate];
	
}
	//  nstimer
- (void) refreshSetupForPlay {

	{	
		//   new cross icon Black for itunes connct
		//   TOUCHDOWN INDICATOR in menus not working!!!   ?
		//   hidef bckgrnd for iphn4? lookup Default-haha.png
		//   set ads behind nsdate
		//   well done
		//   new pick sound  wooden knock?... soft place sound
		//   backLSIDE AND TOUCHUP FOR ICONS fb
		// * timer snd at 10 secs and red txt
		//   more win verses
		//   fix swap view on intro
		// * red words blip bigger at start
		// * fix verse to youLose bug
		// * fix unfit verses 13 30
		// * 1111
		// * touch screen to continue thru youwin youlose
		//   make sure they know they can share the WORD
		//   sounds ... dings for score and right switch / wrong
		// * instruc for webview esc ... and bible fb icon?

		// * verse quote marks
		// * 444 555
		//   resume session for fb  -- need globals
		//   animate instruc ?
		// * support dev
		// * fix animate after youWin
		// * fix hyperlink from fb
		
		//   spanish
		
		//   fave verses?
		//   look into ads on bible iphone apps thru admob
		//   don't reload if same?
		//   mobile bible.cc?
		
		// * alertView in right place
		// * FB!!    twit?
		
		
		
		// * fix webview.. bookVerse and retry and animateToStart*
		//   more win verses... more verses
		//   1st game starts on certain verse???
	
		// * harder expert mode... new score+=50 structure

		// * universal binary
		// * separate 1John  if length [0]==1 then 
		// * shadows right??
		
		// * twitter
		// * links add fb?
		// * after 10/7? historic verses - review now!! - evangelism verse
		// * no timer for FB,, and resume,* pass praise to FB!!!!
		
		// * BOLD instruc
		
		
		/*
		 21. Mark 16:15
		 NIV | AMP | KJV | All
		 He said to them, "Go into all the world and preach the gospel to all creation." (NIV)
		 22. John 10:10
		 NIV | AMP | KJV | All
		 The thief comes only to steal and kill and destroy; I have come that they may have life, and have it to the full. (NIV)
		 23. John 1:14
		 NIV | AMP | KJV | All
		 The Word became flesh and made his dwelling among us. We have seen his glory, the glory of the one and only Son, who came from the Father, full of grace and truth. (NIV)
		 24. Acts 4:12
		 NIV | AMP | KJV | All
		 "Salvation is found in no one else, for there is no other name given under heaven by which we must be saved." (NIV)
		 25. Acts 2:42
		 NIV | AMP | KJV | All
		 They devoted themselves to the apostles' teaching and to fellowship, to the breaking of bread and to prayer. (NIV)
		 26. John 3:1
		 NIV | AMP | KJV | All
		 Now there was a Pharisee, a man named Nicodemus who was a member of the Jewish ruling council. (NIV)
		 27. Galatians 5:22
		 NIV | AMP | KJV | All
		 But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness (NIV)
		 28. Proverbs 3:5
		 NIV | AMP | KJV | All
		 Trust in the LORD with all your heart and lean not on your own understanding (NIV)
		 29. Jeremiah 29:11
		 NIV | AMP | KJV | All
		 For I know the plans I have for you," declares the LORD, "plans to prosper you and not to harm you, plans to give you hope and a future. (NIV)
		 30. John 2:1
		 NIV | AMP | KJV | All
		 On the third day a wedding took place at Cana in Galilee. Jesus' mother was there, (NIV)
		 */
		
		//   landscape copy paste?
		//   choose swap mode???
		
		//   more animations... different...* after every verse
		//   glow mode?
		//   fix fade in to title screen
		
		//   verses dont repeat after choose
		
		//   more verses  versions  languages ... by topic, book
		//   word search?
		
		// * verse book and chap verse on banner
		
		//   sounds  -   music?  fx for win (ding coins from mario)
		//   every correct place and ... -  score mario quick dings
		
		
		//  all things in Christ 
		//  AMEN
		
		//   5 5 glitch
			// -  handletouch... eaglview
			//   -  ???
		
		// * refer to friend.. 
		// * giveFeedback  //  review   
		
		//   moveWordEngine
			//  *  wobble like beecell-- switch with next tap
			//  *     - tap offscreen = cancel
		
	
		
		//   fade outs for gameplay.. win lose screens
			//  *  whirl puddles to place?
			//  *  setupAnim = 1 to 60
			//  *  turnoff touch handling
			//  *  method from out to setup
		
		// * hiScore
		// * save setting for gamemode... first game starts at instrucscreen?
		// * new place for hiscore
		// * resources          
		// * userDefaults       
		
		
		
		/*
		if (firstGame==NO){
			for(ii = 0; ii<stringLength; ii++){
				[verseWords[ii] release];
			}
		}*/
		firstGame=NO;
		wincounter2=0;youWin=0;
		youFail=0;
		seconds=51;
		swapReady=-1;
		
        NSLog(@"r called again");

		[self loadNewVerseToPraise];
		

		
		/*
		praise = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
		array = [praise componentsSeparatedByString: (@" ")];
		
		//	stringLength= [praise length];
		stringLength= [array count];//+1;
		start=0;
		wordsPerRow=6;  // seconds
		numRows=(trunc(stringLength/wordsPerRow))+1;*/
		lastRowWords= stringLength-((trunc(stringLength/wordsPerRow))*wordsPerRow);
		if (device==1){
		for(ii = 0; ii<stringLength; ii++){
			
			
			
			if (lite==NO) words[ii].x= 135+numRows*20 -trunc((ii-start)/wordsPerRow)*40;//+50;
			else 			words[ii].x= 145+numRows*20 -trunc((ii-start)/wordsPerRow)*40;//+50;

			
			
			words[ii].y= 423+-((ii-start)*(440/(wordsPerRow)))%438+00;
			
			
			if	(ii>=(trunc(stringLength/wordsPerRow))*wordsPerRow)
				words[ii].y= 210+35*lastRowWords-((ii-start)-((trunc(stringLength/wordsPerRow))*wordsPerRow))*72;			
			
			
			wordsHome[ii].x=words[ii].x;
			wordsHome[ii].y=words[ii].y;
			wordsHomeFull[ii]=ii+start;
			
		}}
		else 
		{
		for(ii = 0; ii<stringLength; ii++){
			
			
			words[ii].x= .42*rect.size.width+numRows*.0625*rect.size.width -trunc((ii-start)/wordsPerRow)*.125*rect.size.width;//+50;
			//words[ii].y= .88*rect.size.height+-(trunc((ii-start)*((.92*rect.size.height)/(wordsPerRow))))%(438)+00;
			words[ii].y= .88*rect.size.height+-fmod((trunc((ii-start)*((.92*rect.size.height)/(wordsPerRow)))),(.919*rect.size.height))+00;
			
			if	(ii>=(trunc(stringLength/wordsPerRow))*wordsPerRow)
				words[ii].y= .44*rect.size.height+.07*rect.size.height*lastRowWords-((ii-start)-((trunc(stringLength/wordsPerRow))*wordsPerRow))*.15*rect.size.height;			
			
			
			wordsHome[ii].x=words[ii].x;
			wordsHome[ii].y=words[ii].y;
			wordsHomeFull[ii]=ii+start;
			
		}
	}
		// glitch as swap two words at start
		// 
		trueRandom= randomNess;
		if (gameModeSelection==2) trueRandom= randomNess*2+4;
		if (gameModeSelection==0) trueRandom= randomNess+1;
        
        NSLog(@"stringlength %i",stringLength);
        
        if (stringLength<1)stringLength=1;
		for(j = 0; j<trueRandom; j++){
			arnd= arc4random()%stringLength;
			brnd= arc4random()%stringLength;
			holderi=wordsHomeFull[arnd];
			wordsHomeFull[arnd]=wordsHomeFull[brnd];
			wordsHomeFull[brnd]=holderi;
	
			action[arnd]=5;	
			action[brnd]=5;	
		}
		
		for(ii = 0; ii<stringLength; ii++){
			if (wordsHomeFull[ii]==ii)
				action[ii]=6;
		}
		
		
		//	stringLength= [array count];//+1;
		for(ii = start; ii<stringLength; ii++){
			
			makeLettersSmaller[ii]= [[array objectAtIndex:ii]length]-6;
			if (makeLettersSmaller[ii]<0) makeLettersSmaller[ii]=0;
			
			
			//// add in array for mls to move big owrd down??
		//	for(ii = 0; ii<stringLength; ii++){
				
			//	shadowLength[ii]= [[array objectAtIndex:wordsHomeFull[ii]]length];
				
		//	}
			
			
			verseWords[ii] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"%@",[array objectAtIndex:ii]]dimensions:CGSizeMake(222+fontSizePad*6+[[array objectAtIndex:ii] length]*0, 38-makeLettersSmaller[ii]*.5+fontSizePad*1.3) alignment:UITextAlignmentCenter fontName:@"Verdana"  fontSize:30+fontSizePad+ biggerLetter+ 0*action[ii]-makeLettersSmaller[ii]];
			
			makeLettersSmaller[ii]= [[array objectAtIndex:ii]length];

		}
		
		//setup testing for doubles
		group=0;
		for(ii = start; ii<stringLength; ii++){  //  
			for(j = ii+1; j<stringLength; j++){
				if ([(@"%@",[array objectAtIndex:ii]) isEqualToString:(@"%@",[array objectAtIndex:j])]) {
					set [group][0]=ii;
					set [group][1]=j;
					group++;
				}
			}
		}
		
		// test for doubles
		for(ii = start; ii<group; ii++){  //  
			
			if ((wordsHomeFull[set[ii][0]])==(set[ii][1]))		 
				action[set[ii][0]]=6;	
			
			if ((wordsHomeFull[set[ii][1]])==(set[ii][0]))		 
				action[set[ii][1]]=6;
		}
		//	score=group;
		fresh=NO;
	}
	
	
	
	for(ii = 0; ii<stringLength; ii++){
		
		shadowLength[ii]= [[array objectAtIndex:wordsHomeFull[ii]]length];
		
	}
	
	
	for(ii = 0; ii<stringLength; ii++){
		if(action[ii]!=6) {allInOrder=NO; howManyOutOfOrder++;}
	}
	
	howManyOutOfOrderLastTime=howManyOutOfOrder;
	
	


}

- (void) drawBackground {

	
	
	glPushMatrix();
	glTranslatef(rect.size.width/2, rect.size.height/2, 0);  //05  lines
	//glTranslatef(284, rect.size.height/2, 0);  //05  lines
	//glTranslatef(180, 480,1);  //05  lines
//glScalef(1.19, 1.345, 1);  acceler

	if (device==0) glScalef(1.03, 1.03, 1);
//	glScalef(1.3, 2.43, 1);
//	glScalef(1.3, 1.43, 1);
//	glRotatef(-90, 0, 0, 1);

////glTranslatef(160, 266, 0);  //for ad port
//glScalef(1.19, 1.345, 1); // acceler
//glScalef(1.3, 1.29, 1);   // for ad port

[_textures[kTexture_Blueinv] drawAtPoint:CGPointMake(0,0)];
glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		

	
if (fadeIn<1) glColor4f(1, 1, 1, .7*fadeIn);
else glColor4f(1, 1, 1, .7);


[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];

glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
glPopMatrix();
	
	
	if ((menuState==NO)||(gospelState==YES)||(resourcesState==YES)||(optionsState==YES)||(instrucState==YES)){
	glPushMatrix();
	
	if (device==1)  glTranslatef(-15,-34, 1);
	else            glTranslatef(35,37, 1);
	
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glRotatef(-90, 0, 0, 1);
	
//		menuHighlighted
		
		if (menuHighlighted) glColor4f(1, 1, 1, fadeIn);
		else glColor4f(1, 1, .5, fadeIn);
		//glColor4f(1, 1, .5, .9);
	[_textures[menuText] drawAtPoint:CGPointZero];
	
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	}
	/*
	if (adReceived==YES){
		if (device==1){
		glPushMatrix();
		glTranslatef(0, 240, 0);  
		glScalef(.3, .95, 1);
		glColor4f(1, 1, 1, .7);

	//	[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
		[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
		//glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		}
	/*	else{
			glPushMatrix();
			glTranslatef(0, rect.size.height/2, 0);  
			glScalef(.11, .34, 1);
			glColor4f(1, 1, 1, .7);
			[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
			glPopMatrix();	
		}
	}*/
	//[self autoRotate];
}

// Saves the user's score in the application preferences
- (void)saveScore {
	[self drawBackground];
//	score=swapReady;
	
	//isLoggedIn2= 
	//[[[UIApplication sharedApplication] facebookAgent] isLoggedIn];
	
	//writing
	//[[[UIApplication sharedApplication] delegate] setYourVariable:newValue];
	
//	if (isLoggedIn2==YES) hiScore=555; else hiScore=444;	
	if (internetIsAvailable==YES){
	glPushMatrix();
	glTranslatef(.08*rect.size.width,.35*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glRotatef(-90, 0, 0, 1);
	if(device==0) glScalef(.5, .5, 1);
//	else glScalef(.37, .37, 1);
	else glScalef(.23, .23, 1);
	[_textures[kTexture_BibleIcon] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	glPushMatrix();
	glTranslatef(.08*rect.size.width,.65*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glRotatef(-90, 0, 0, 1);
	if(device==0) glScalef(.5, .5, 1);
	else  glScalef(.23, .23, 1);
	[_textures[kTexture_Facebook] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	}
	if (youWin>22) {
		
		glPushMatrix();
		if(device==1) glTranslatef(-.19*rect.size.width,rect.size.height/2, 1);
		else  glTranslatef(-.12*rect.size.width,rect.size.height/2, 1);
		
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );	
		glColor4f(1, 1, .5, 1);
		glRotatef(-90, 0, 0, 1);	
		
			[_textures[tapToGoOnText] drawAtPoint:CGPointZero];
		//	[_textures[endWebOnBorderText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
	}
		
	christ=YES;
	if(christ==YES) {
		
		if (youFail>0){
			if (youFail==2) {
				score=0;
				if (toggleSound==YES)[sound4 play];
			}
			youFail++;if (youFail>44) {fresh=YES;youWin=0;youFail=0;randomNess=2;}
		}
		
		if (youWin>0){
			if (gameModeSelection>0) {  // savescore
				if (seconds>0){
					seconds-=3;if (seconds<0) seconds=0;
					score+=3*gameModeSelection;

					if (toggleSound==YES){
						if (altSounds%2==1)
						[sound6 play];
						else
							[sound8 play];
						altSounds++;

					
					}
					if (seconds==0) score+=25*gameModeSelection; 	
					if (score>hiScore) hiScore=score;

				}
			}
			
			if (youWin==2) {

			//	score+=(25+seconds)*gameModeSelection; 
			
				
				if (toggleSound==YES)[sound3 play];
				
			}
			
			youWin++;if (youWin>52) {
				
				glPushMatrix();
				glTranslatef(.5*rect.size.width,rect.size.height/2, 1);
				glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
				glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
				glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );	
				glColor4f(1, 1, .5, 1);
				glRotatef(-90, 0, 0, 1);	
				
		//		[_textures[tapToGoOnText] drawAtPoint:CGPointZero];
		//		[_textures[endWebOnBorderText] drawAtPoint:CGPointZero];
				glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
				glPopMatrix();
				
				
				if (score>=hiScore){
					hiScore=score;
					[[NSUserDefaults standardUserDefaults] setInteger: score forKey:@"hiScore"];
				}
				
			if (userTouchedScreenToContinue==YES){
				seconds=50;
				fresh=YES;youWin=0;
				verse+=1;if (verse>verseCount) verse=1;
				historicVerses++;
				randomNess+=1; if (randomNess>5) randomNess=5;

				[[NSUserDefaults standardUserDefaults] setInteger: historicVerses forKey:@"history"];
				historicVerses=1;
				if (((historicVerses%12)==3)&&(internetIsAvailable==YES)){
					[_timer invalidate];
					_timer = nil;
					[UIApplication sharedApplication].idleTimerDisabled = NO;
					evangelState=YES;
					_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(evangel) userInfo:nil repeats:YES];
					[UIApplication sharedApplication].idleTimerDisabled = YES;
					return;
				}
				else{
					if (((historicVerses%12)==3)&&(internetIsAvailable==NO)) historicVerses-=2;
				[_timer invalidate];
				_timer = nil;
				[UIApplication sharedApplication].idleTimerDisabled = NO;
				
				if (fresh==YES) [self refreshSetupForPlay];
				fresh=NO;
				animationState=YES;
				_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(setupAnimation) userInfo:nil repeats:YES];
				[UIApplication sharedApplication].idleTimerDisabled = YES;
					return;
				}
			}
			}
		}
		
		
		if (fresh==YES) [self refreshSetupForPlay];
		
		
        NSLog(@"s called again");

		[self loadNewVerseToPraise];
		
		
		praise = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
		array = [praise componentsSeparatedByString: (@" ")];
		
		
		if ([[array objectAtIndex:0] length] ==1) {
			
			nBook=      [array objectAtIndex:0];
			book =      [array objectAtIndex:1];
			chapVerse = [array objectAtIndex:2];  //  banner
		
			bookHolder = [book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			
			[_textures[bannerText] release];
			
			_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"%@ %@ %@",nBook,book,chapVerse]dimensions:CGSizeMake(822, 122) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:14+fontSizePad/2];			
			/// these are in two places
			[array removeObjectAtIndex:0];
			[array removeObjectAtIndex:0];		
			[array removeObjectAtIndex:0];		
			
		}
		else{
			
			book =      [array objectAtIndex:0];
			chapVerse = [array objectAtIndex:1];  //  banner
			
			bookHolder = [book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			
			[_textures[bannerText] release];
			
			_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"%@ %@",bookHolder,chapVerse]dimensions:CGSizeMake(422, 122) alignment:UITextAlignmentCenter fontName: kFontName2 fontSize:14+fontSizePad/2]; // 14
			/// these are in two places
			[array removeObjectAtIndex:0];
			[array removeObjectAtIndex:0];
			
		}
		
		
		//	[array removeObjectAtIndex:0];
		//	[array removeObjectAtIndex:0];
		
		
	}
	
	if(christ==YES){
		//glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		ii=0;
		
		if ((gameModeSelection>0)){
			_textures[scoreText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Score: %i",score]dimensions:CGSizeMake(222+fontSizePad*6, 122+fontSizePad) alignment:UITextAlignmentLeft fontName: @"Zapfino"  fontSize:14+fontSizePad/2];
			
			glPushMatrix();
			if (device==1) glTranslatef(.78*rect.size.width,.71*rect.size.height, 1);
			else           glTranslatef(.89*rect.size.width,.76*rect.size.height, 1);
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
			glColor4f(1, 1, .5, .9);
			glRotatef(-90, 0, 0, 1);
			[_textures[scoreText] drawAtPoint:CGPointZero];
			glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			glPopMatrix();
			
			[_textures[scoreText] release];   // have to do this cuz time score changes
			if( hiScore>-90){
			_textures[scoreText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Hi: %i",hiScore]dimensions:CGSizeMake(222+fontSizePad*6, 122+fontSizePad) alignment:UITextAlignmentLeft fontName: @"Zapfino"  fontSize:13+fontSizePad/2];
			
			glPushMatrix();
			if (device==1)            glTranslatef(-.06*rect.size.width,.72*rect.size.height, 1);
			else           glTranslatef(.02*rect.size.width,.77*rect.size.height, 1);
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
			glColor4f(1, 1, .5, .9);
			glRotatef(-90, 0, 0, 1);
			
			[_textures[scoreText] drawAtPoint:CGPointZero];
			glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			glPopMatrix();
			[_textures[scoreText] release]; 
			}
		}
		
		
		/*
		glPushMatrix();
		
		if (device==1)  glTranslatef(-15,-37, 1);
		else            glTranslatef(35,37, 1);
		
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
		glColor4f(1, 1, .5, .9);
		glRotatef(-90, 0, 0, 1);
		
		[_textures[menuText] drawAtPoint:CGPointZero];
		
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		*/
		
		
		
		if ((youWin>=0)&&(gameModeSelection>0)){
			_textures[timeText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Time: %i", (seconds)]dimensions:CGSizeMake(222+fontSizePad*6, 122+fontSizePad) alignment:UITextAlignmentLeft fontName: @"Zapfino"  fontSize:14+fontSizePad/2];

			glPushMatrix();
			if (device==1)  glTranslatef(.78*rect.size.width,.0*rect.size.height, 1);

			else           glTranslatef(.89*rect.size.width,.02*rect.size.height, 1);
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );	
		//	if (seconds>-10)
			glColor4f(1, 1, .5, .9);
		//	else {
		//	glColor4f(.7, 0, 0, 1);
//				glScalef(1.2,1.2, 1);
		//	}

			glRotatef(-90, 0, 0, 1);
			
			[_textures[timeText] drawAtPoint:CGPointZero];
			if ((seconds<=10)&&(youWin<=0)){
				glTranslatef(-1,0,0);

				glColor4f(.7, 0, 0, 1);
			//	[_textures[timeText] drawAtPoint:CGPointMake(2, 2)];
				[_textures[timeText] drawAtPoint:CGPointZero];
			
			}
			[_textures[timeText] release];
			
			glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			glPopMatrix();
		}
		
		// else{
		 glPushMatrix();
	//	glTranslatef(251,240, 1);
		if(device==0) glTranslatef(.91*rect.size.width,.5*rect.size.height, 1);
		else glTranslatef(250,235, 1);
		 glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		 glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
		 glColor4f(1, 1, .5, .9);
		 glRotatef(-90, 0, 0, 1);
		 
		 [_textures[bannerText] drawAtPoint:CGPointZero];
		 
		 glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		 glPopMatrix();	
		// }
		 
		
		////// block of code for yellow shadows for placeholders
		
		for(ii = 0; ii<[array count]; ii++){
			if (wordsHomeFull[ii]<0){
				glPushMatrix();
				glTranslatef(wordsHome[ii].x-8,wordsHome[ii].y, 1);
				//	if (flipped==YES)glRotatef(180, 0, 0, 1);
				
				glScalef(.1, .74, 1);
				
				//	if (ii==hover) 	glScalef(2, 2.5, 1);
				glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
				glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
				glColor4f(1,1,0, .6);
				glRotatef(90, 0, 0, 1);
				
				[_textures[kTexture_Star] drawAtPoint:CGPointZero];
				glPopMatrix();  // blueinv
			}
		}
		
		for(ii = start; ii<[array count]; ii++){
		
			if (youWin>0) biggerLetter=3; 
			else biggerLetter=0;
			
			iii=ii;
			
			if(action[ii]<6) action[ii]-=.1;
			if (action[ii]<4) action[ii]=4;
			
			
			glPushMatrix();
			
			if (action[ii]!=7)	glTranslatef(words[ii].x-8,words[ii].y, 1);
						else    glTranslatef(words[ii].x-18,words[ii].y, 1);
		
			if (action[ii]!=7)	glScalef(.5, .5, 1);
			
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			
			if(action[ii]<6) {red= 1;green=.3;blue=.3;}
			else if (action[ii]==6)  {red= .3;green=1;blue=.3;}   
//			else if (action[ii]==7) {red= .1;green=.5;blue=.7;}      
			else if (action[ii]==7) {red= .5;green=.5;blue=1;}      
			
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
			
			glColor4f(red, green, blue,  .5);
			//glColor4f(1, 1, 1, .9);
			
			glRotatef(90, 0, 0, 1);
			
			//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
			//		[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			//	else
			//		[verseWords[holding] drawAtPoint:CGPointZero];
			
			//glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			//glScalef(1.4, 1.4, 1);
			xStretch=.27;
			
			if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
				//if (action[ii]!=7)
				makeShadowsLonger= [[array objectAtIndex:wordsHomeFull[ii]]length];
			shadowLength[ii]= [[array objectAtIndex:wordsHomeFull[ii]]length];
			
			//  else 
			//makeLettersSmaller[ii]= [[array objectAtIndex:holding]length];
			//if (makeLettersSmaller[ii]>3) makeLettersSmaller[ii]=3+(makeLettersSmaller[ii]-3)/2;
		
			
			if (makeShadowsLonger>6) makeShadowsLonger=6+2*(makeShadowsLonger-6)/3;
			
			if (device==0) {
				glScalef( 2, 2, 1);//
				glTranslatef(0, 10, 0);
			}
			
			glScalef((.4+makeShadowsLonger/4),xStretch, 1);
			//if ((pickedup==NO)||(ii!=hover)) 
			
			counterFloat+=.03;
		//	if ((holding==ii)&&(pickedup==NO)&&(wordsHomeFull[holding]==holding)) 
		//	glScalef(1+.25*sin(counterFloat), 1+.25*sin(counterFloat), 1);
			
		//	swapReady=holding;
			pulsar=NO;
			if (pulsar==YES){
			
			if ((swapReady==wordsHomeFull[ii])&&(pickedup==NO))//&&(wordsHomeFull[holding]==holding)) 
				glScalef(1+.25*sin(counterFloat), 1+.25*sin(counterFloat), 1);
			}
			[_textures[kTexture_Star] drawAtPoint:CGPointZero];
		
		//	if ((pickedup==NO)||((ii!=wordsHomeFull[holding])&&(ii!=holding)))	  
		//		[_textures[kTexture_Star] drawAtPoint:CGPointZero];

		//	if((wordsHomeFull[holding]!=holding)&&(ii!=holding))
		//	[_textures[kTexture_Star] drawAtPoint:CGPointZero];

		//	if((wordsHomeFull[holding]!=holding)&&(ii!=wordsHomeFull[holding]))
		//		[_textures[kTexture_Star] drawAtPoint:CGPointZero];

			glPopMatrix();
			
			
			/*
			if (holding==ii){
				
				glPushMatrix();
				glTranslatef(words[ii].x,words[ii].y, 1);
				glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
				glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
				glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
				
				if (youWin>0) glColor4f(1, 1, 0, 1);
				else //glColor4f(red, green, blue,  .9);
					glColor4f(0,0,0,  .9);
				//if (youWin>0) glColor4f(1, 1, 0, 1);
				//else glColor4f(1, 1, 1, .5);
				
				glRotatef(-90, 0, 0, 1);
				//glTranslatef(0 , 10, 0);
				
				if (action[ii]!=7)	glScalef(.5, .5, 1);
				
				if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
					[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
				else
					[verseWords[holding] drawAtPoint:CGPointZero];
				
				if (youWin>0) glColor4f(1, 1, 0, 1);
				else glColor4f(1,1,.5, 1);
				//glTranslatef(-1 , 1, 0);
				
			
					[_textures[sparks] drawAtPoint:CGPointZero];
				
				glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
				glPopMatrix();
			
			}
			*/
			
			
			glPushMatrix();
			glTranslatef(words[ii].x,words[ii].y, 1);
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
			
			if (youWin>0) glColor4f(1, 1, 0, 1);
			else //glColor4f(red, green, blue,  .9);
				glColor4f(0,0,0,  .9);
			//if (youWin>0) glColor4f(1, 1, 0, 1);
			//else glColor4f(1, 1, 1, .5);
			
			glRotatef(-90, 0, 0, 1);
			//glTranslatef(0 , 10, 0);
			//  cutoff letter
			if (action[ii]!=7)	glScalef(.5, .5, 1);
			
			if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
				[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			else
				[verseWords[holding] drawAtPoint:CGPointZero];
			
			if (youWin>0) glColor4f(1, 1, 0, 1);
			else glColor4f(1,1,.5, 1);
			//glTranslatef(-1 , 1, 0);
			
			if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
				[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			else
				[verseWords[holding] drawAtPoint:CGPointZero];
			
			glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			glPopMatrix();
		}	
	}
	
	//if (wincounter>0){
	
	//glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	//}
	
	_state = kState_StandBy;
	
	if (youFail>0){
		
		[self drawBackground];
		
		/*
		if (adReceived==YES){
			if (device==1){
				glPushMatrix();
				glTranslatef(0, 240, 0);  
				glScalef(.3, .95, 1);
				glColor4f(1, 1, 1, .7);
				
				//	[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
				[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
				//glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
				glPopMatrix();
			}
			else{
				glPushMatrix();
				glTranslatef(0, rect.size.height/2, 0);  
				glScalef(.13, .34, 1);
				glColor4f(1, 1, 1, .7);
				[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
				glPopMatrix();	
			}
		}
		*/
		
	
		glPushMatrix();
		if(device==1) glTranslatef(200,250, 1);
		else  glTranslatef(.75*rect.size.width,rect.size.height/2, 1);		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
		glColor4f(1, 1, .5, .9);
		glRotatef(-90, 0, 0, 1);
		///		if (flipped==YES)glRotatef(180, 0, 0, 1);
		
		[_textures[timeUpText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		
		glPushMatrix();
		if(device==1) glTranslatef(200,250, 1);
		else  glTranslatef(.6*rect.size.width,rect.size.height/2, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
		glColor4f(1, 1, .5, .9);
		glRotatef(-90, 0, 0, 1);
		///		if (flipped==YES)glRotatef(180, 0, 0, 1);
		// youwin
		[_textures[YouFailText] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		//	[_textures[tex] release];
	}
	if((youWin>0)&&(youWin<30)) iiii=0;
	if ((userTouchedScreenToContinue==NO)&&(youWin>32)) youWin=32;
	if (youWin>32){
		/*
		glPushMatrix();
		glTranslatef(rect.size.width/2, rect.size.height/2, 0);  //05  lines
		//glScalef(1.19, 1.345, 1);  acceler
		//	if (flipped==YES)glRotatef(180, 0, 0, 1);
		
		glScalef(1.3, 1.43, 1);
		
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );	
		[_textures[kTexture_Blueinv] drawAtPoint:CGPointMake(0,0)];
		
		glColor4f(1, 1, 1, .7);
		[_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
		
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		*/
		[self drawBackground];

		//list
        
//        if change verse then mess up circles and number of words, check translation++ and loadverse
        
        //  
        // sounds.. more ethereal? polyphonic?
        // facebook exit, retool for like page  fbagent linked two places to piano now
        // but ye samaria kjv too many words... 36 max
        // verses that start mid sentecnce.. drop, look for footnote brackets [a]
        
		glPushMatrix();
		if (device==1) 		glTranslatef(110,240, 1);
		else glTranslatef(.5*rect.size.width,.5*rect.size.height, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	//	iii=youWin; // make it float
//		iiii+=1.5;
		iiii+=.7;
		glColor4f(1, 1, .5, .6+(iiii)/20);
		glRotatef(-90, 0, 0, 1);
		//		if (flipped==YES)glRotatef(180, 0, 0, 1);
		if (iiii<18) glScalef(1+.25*sin(iiii/6), 1+.25*sin(iiii/6), 1);
		[_textures[kTexture_praiseGod] drawAtPoint:CGPointZero];
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		glPopMatrix();
		//[_textures[kTexture_praiseGod] release];
	}
	
	//adReceived=NO;
	/*
	 if (adReceived==YES){
	 
	 glPushMatrix();
	 glTranslatef(0, 240, 0);  
	 glScalef(.3, .95, 1);
	 [_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
	 [_textures[kTexture_border] drawAtPoint:CGPointMake(0,0)];
	 //glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	 glPopMatrix();
	 
	 }
	 */
	
	
	
	allInOrder=YES;			
	for(ii = 0; ii<(stringLength); ii++){
		if(wordsHomeFull[ii]!=ii){
			//ii=stringLength;
			allInOrder=NO;}
	}
	if (allInOrder==YES) {
		if (youWin<1) youWin=1;
	}
	
	[self autoRotate];
	
}

- (void)autoRotate{
	//adMobAd.frame =CGRectMake(-144, 492, 320, 38);   //centre
	
	flippedView=NO;//YES;//NO;  sound
	if (_accelerometer[0]>0) flippedView=YES; /////  change please!!
	
	if (flippedView!=historyView) {
		if (fabs(_accelerometer[0])<.1) flippedView=historyView;
	}
		//changedView=YES; else changedView =NO;
	
	historyView=flippedView;
	
	
	biggerAd=1;//1.5
	
	if (flippedView==YES){
		CGAffineTransform transform = CGAffineTransformMakeRotation(3.14159);
		CGAffineTransform transform2 = CGAffineTransformMakeRotation(-3.14159/2);
		 [UIApplication sharedApplication].statusBarOrientation =	UIInterfaceOrientationLandscapeLeft;
		glView.transform = transform;
		if (webViewState==YES) webView.transform= transform2;
		CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(0);

		if (device==0)makeLandscape=CGAffineTransformTranslate(makeLandscape, 730, 0);
		else makeLandscape = CGAffineTransformTranslate(makeLandscape, 282, -275);
		makeLandscape = CGAffineTransformScale(makeLandscape, biggerAd, biggerAd);
		//adContainer.transform = makeLandscape;
			//	if (adContainer==
		adContainer.transform = makeLandscape;
	}
	else {
		CGAffineTransform transform = CGAffineTransformMakeRotation(0);
		CGAffineTransform transform2 = CGAffineTransformMakeRotation(3.14159/2);
		
			[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
		glView.transform = transform;
		if (webViewState==YES) webView.transform= transform2;

		CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(3.1416);
		if (device==0) makeLandscape= CGAffineTransformTranslate(makeLandscape,-6, 0);
		else makeLandscape = CGAffineTransformTranslate(makeLandscape, -6, 275);
		makeLandscape = CGAffineTransformScale(makeLandscape, biggerAd, biggerAd);
		adContainer.transform = makeLandscape;

	}
	adContainer.multipleTouchEnabled=YES;
	adContainer.userInteractionEnabled=YES;
	
	
	//adMobAd.superview=YES;
	

//	[[adContainer superview] touchesEnded:touches withEvent:event];
	[glView swapBuffers];

	
	
}

- (void)timerHolder{
	if ((seconds>0)&&(_firstTap==NO)&&(gameModeSelection>0)&&(evangelState==NO)&&(webViewState==NO)&&(youWin==0)&&(gospelState==NO)) {seconds--;
		if (seconds==10) [sound5 play];
	}
	if ((seconds==0) &&(youFail==0)&&(gameModeSelection>0)&&(youWin==0)) youFail=1;
}

- (void)instructionScreen{
	
	if (fadeIn<1){
		fadeIn+=.1;
		if (fadeIn>1) fadeIn=1;}
	
	[self drawBackground];

	glPushMatrix();
	if (device==1) glTranslatef(253,245, 1);
	else if (device==0) glTranslatef(.8*rect.size.width,.5*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, 1);
	glRotatef(-90, 0, 0, 1);
	
	[_textures[instrucTitleText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	glPushMatrix();
	if (device==1) glTranslatef(103,245, 1);
	else glTranslatef(.35*rect.size.width,.51*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, 1);
	glRotatef(-90, 0, 0, 1);

	[_textures[instrucText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	christ=YES;
	/*
	
	if (christ==YES){

		ii=0;
		
		
		
		 glPushMatrix();
		 
		 if (device==1)  glTranslatef(-15,-37, 1);
		 else            glTranslatef(35,37, 1);
		 
		 glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
		 glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
		 glColor4f(1, 1, .5, .9);
		 glRotatef(-90, 0, 0, 1);
		 
		 [_textures[menuText] drawAtPoint:CGPointZero];
		 
		 glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		 glPopMatrix();
		 
	
		
		
		
		////// block of code for yellow shadows for placeholders
		
		for(ii = 0; ii<[array count]; ii++){
			if (wordsHomeFull[ii]<0){
				glPushMatrix();
				glTranslatef(wordsHome[ii].x-8,wordsHome[ii].y, 1);
				//	if (flipped==YES)glRotatef(180, 0, 0, 1);
				
				glScalef(.1, .74, 1);
				
				//	if (ii==hover) 	glScalef(2, 2.5, 1);
				glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
				glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
				glColor4f(1,1,0, .6);
				glRotatef(90, 0, 0, 1);
				
				[_textures[kTexture_Star] drawAtPoint:CGPointZero];
				glPopMatrix();  // blueinv
			}
		}
		
		for(ii = start; ii<[array count]; ii++){
			
			if (youWin>0) biggerLetter=3; 
			else biggerLetter=0;
			
			iii=ii;
			
			if(action[ii]<6) action[ii]-=.1;
			if (action[ii]<4) action[ii]=4;
			
			
			glPushMatrix();
			
			if (action[ii]!=7)	glTranslatef(words[ii].x-8,words[ii].y, 1);
			else    glTranslatef(words[ii].x-18,words[ii].y, 1);
			
			if (action[ii]!=7)	glScalef(.5, .5, 1);
			
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			
			if(action[ii]<6) {red= 1;green=.3;blue=.3;}
			else if (action[ii]==6)  {red= .3;green=1;blue=.3;}   
			else if (action[ii]==7) {red= .1;green=.5;blue=.7;}      
			
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
			
			glColor4f(red, green, blue,  .5);
			//glColor4f(1, 1, 1, .9);
			
			glRotatef(90, 0, 0, 1);
			
			//	if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
			//		[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			//	else
			//		[verseWords[holding] drawAtPoint:CGPointZero];
			
			//glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			//glScalef(1.4, 1.4, 1);
			xStretch=.27;
			
			if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
				//if (action[ii]!=7)
				makeShadowsLonger= [[array objectAtIndex:wordsHomeFull[ii]]length];
			shadowLength[ii]= [[array objectAtIndex:wordsHomeFull[ii]]length];
			
			//  else 
			//makeLettersSmaller[ii]= [[array objectAtIndex:holding]length];
			//if (makeLettersSmaller[ii]>3) makeLettersSmaller[ii]=3+(makeLettersSmaller[ii]-3)/2;
			
			
			if (makeShadowsLonger>6) makeShadowsLonger=6+2*(makeShadowsLonger-6)/3;
			
			if (device==0) {
				glScalef( 2, 2, 1);//
				glTranslatef(0, 10, 0);
			}
			
			glScalef((.4+makeShadowsLonger/4),xStretch, 1);
			//if ((pickedup==NO)||(ii!=hover)) 
			
			counterFloat+=.03;
			//	if ((holding==ii)&&(pickedup==NO)&&(wordsHomeFull[holding]==holding)) 
			//	glScalef(1+.25*sin(counterFloat), 1+.25*sin(counterFloat), 1);
			
			//	swapReady=holding;
			pulsar=NO;
			if (pulsar==YES){
				
				if ((swapReady==wordsHomeFull[ii])&&(pickedup==NO))//&&(wordsHomeFull[holding]==holding)) 
					glScalef(1+.25*sin(counterFloat), 1+.25*sin(counterFloat), 1);
			}
			[_textures[kTexture_Star] drawAtPoint:CGPointZero];
			
			//	if ((pickedup==NO)||((ii!=wordsHomeFull[holding])&&(ii!=holding)))	  
			//		[_textures[kTexture_Star] drawAtPoint:CGPointZero];
			
			//	if((wordsHomeFull[holding]!=holding)&&(ii!=holding))
			//	[_textures[kTexture_Star] drawAtPoint:CGPointZero];
			
			//	if((wordsHomeFull[holding]!=holding)&&(ii!=wordsHomeFull[holding]))
			//		[_textures[kTexture_Star] drawAtPoint:CGPointZero];
			
			glPopMatrix();
			
			
			
			 if (holding==ii){
			 
			 glPushMatrix();
			 glTranslatef(words[ii].x,words[ii].y, 1);
			 glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			 glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			 glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
			 
			 if (youWin>0) glColor4f(1, 1, 0, 1);
			 else //glColor4f(red, green, blue,  .9);
			 glColor4f(0,0,0,  .9);
			 //if (youWin>0) glColor4f(1, 1, 0, 1);
			 //else glColor4f(1, 1, 1, .5);
			 
			 glRotatef(-90, 0, 0, 1);
			 //glTranslatef(0 , 10, 0);
			 
			 if (action[ii]!=7)	glScalef(.5, .5, 1);
			 
			 if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
			 [verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			 else
			 [verseWords[holding] drawAtPoint:CGPointZero];
			 
			 if (youWin>0) glColor4f(1, 1, 0, 1);
			 else glColor4f(1,1,.5, 1);
			 //glTranslatef(-1 , 1, 0);
			 
			 
			 [_textures[sparks] drawAtPoint:CGPointZero];
			 
			 glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			 glPopMatrix();
			 
			 }
			 
			
			
			glPushMatrix();
			glTranslatef(words[ii].x,words[ii].y, 1);
			glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
			
			if (youWin>0) glColor4f(1, 1, 0, 1);
			else //glColor4f(red, green, blue,  .9);
				glColor4f(0,0,0,  .9);
			//if (youWin>0) glColor4f(1, 1, 0, 1);
			//else glColor4f(1, 1, 1, .5);
			
			glRotatef(-90, 0, 0, 1);
			//glTranslatef(0 , 10, 0);
			
			if (action[ii]!=7)	glScalef(.5, .5, 1);
			
			if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
				[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			else
				[verseWords[holding] drawAtPoint:CGPointZero];
			
			if (youWin>0) glColor4f(1, 1, 0, 1);
			else glColor4f(1,1,.5, 1);
			//glTranslatef(-1 , 1, 0);
			
			if ((wordsHomeFull[ii]>-1)&&(wordsHomeFull[ii]<=stringLength))
				[verseWords[wordsHomeFull[ii]] drawAtPoint:CGPointZero];
			else
				[verseWords[holding] drawAtPoint:CGPointZero];
			
			glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
			glPopMatrix();
		}	
	}
	*/
	[self autoRotate];  //  score=

	//Instructions: Touch and drag the words until they're in order, green words are in the right place, red words still need rearrangement

}
// odesk
/*

 get most popular bible verses and format them how i need them
 
 go to  this site: (topverses.com) get the verses in the KJV / NIV for the top 200 verses and put them in this format
 
 else if (verse==2) praise=[NSString stringWithFormat:@"Colossians 3:23\nWhatever you do, work at it with all your heart, as working for the Lord, not for men"];

 if therei s a " in the verse put \" like below
 
 else if (verse==41) praise=[NSString stringWithFormat:@"John 14:6\nJesus answered, \"I am the way and the truth and the life. No one comes to the Father except through me.\""];


*/

- (void) justVerseToPraiseKJV{

     if (verse==1) praise=[NSString stringWithFormat:@"John 3:16\nFor God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life."];
    else if (verse==2) praise=[NSString stringWithFormat:@"Jeremiah 29:11\nFor I know the thoughts that I think toward you, saith the LORD, thoughts of peace, and not of evil, to give you an expected end."]; 
    else if (verse==3) praise=[NSString stringWithFormat:@"Romans 8:28\nAnd we know that all things work together for good to them that love God, to them who are the called according to his purpose."];
    else if (verse==4) praise=[NSString stringWithFormat:@"Philipians 4:13\nI can do all things through Christ which strengtheneth me."];
    else if (verse==5) praise=[NSString stringWithFormat:@"Genesis 1:1\nIn the beginning God created the heaven and the earth."];
    else if (verse==6) praise=[NSString stringWithFormat:@"Proverbs 3:5\nTrust in the LORD with all thine heart; and lean not unto thine own understanding."];
    else if (verse==7) praise=[NSString stringWithFormat:@"Proverbs 3:6\nIn all thy ways acknowledge him, and he shall direct thy paths."];
    else if (verse==8) praise=[NSString stringWithFormat:@"Romans 12:2\nAnd be not conformed to this world: but be ye transformed by the renewing of your mind, that ye may prove what is that good, and acceptable, and perfect, will of God."];
    else if (verse==9) praise=[NSString stringWithFormat:@"Philippians 4:6\nBe careful for nothing; but in every thing by prayer and supplication with thanksgiving let your requests be made known unto God."];
    else if (verse==10) praise=[NSString stringWithFormat:@"Matthew 28:19\nGo ye therefore, and teach all nations, baptizing them in the name of the Father, and of the Son, and of the Holy Ghost"];
    else if (verse==11) praise=[NSString stringWithFormat:@"Ephesians 2:8\nFor by grace are ye saved through faith; and that not of yourselves: it is the gift of God:"];
    else if (verse==12) praise=[NSString stringWithFormat:@"Galatians 5:22\nBut the fruit of the Spirit is love, joy, peace, longsuffering, gentleness, goodness, faith, meekness, temperance: against such there is no law."];
    else if (verse==13) praise=[NSString stringWithFormat:@"Romans 12:1\nI beseech you therefore, brethren, by the mercies of God, that ye present your bodies a living sacrifice, holy, acceptable unto God, which is your reasonable service."];
    else if (verse==14) praise=[NSString stringWithFormat:@"John 10:10\nThe thief cometh not, but for to steal, and to kill, and to destroy: I am come that they might have life, and that they might have it more abundantly."];
    else if (verse==15) praise=[NSString stringWithFormat:@"Acts 18:10\nFor I am with thee, and no man shall set on thee to hurt thee: for I have much people in this city."];
    else if (verse==16) praise=[NSString stringWithFormat:@"Acts 18:9\nThen spake the Lord to Paul in the night by a vision, Be not afraid, but speak, and hold not thy peace:"];
    else if (verse==17) praise=[NSString stringWithFormat:@"Acts 18:11\nAnd he continued there a year and six months, teaching the word of God among them."];
    else if (verse==18) praise=[NSString stringWithFormat:@"Galatians 2:20\nI am crucified with Christ: nevertheless I live; yet not I, but Christ liveth in me: and the life which I now live in the flesh I live by the faith of the Son of God, who loved me, and gave himself for me."];
    else if (verse==19) praise=[NSString stringWithFormat:@"1 John 1:9\nIf we confess our sins, he is faithful and just to forgive us our sins, and to cleanse us from all unrighteousness."];
    else if (verse==20) praise=[NSString stringWithFormat:@"Romans 3:23\nFor all have sinned, and come short of the glory of God;"];
    
    
    
    
    
    else if (verse==21) praise=[NSString stringWithFormat:@"John 14:6\nJesus saith unto him, I am the way, the truth, and the life: no man cometh unto the Father, but by me."];
    else if (verse==22) praise=[NSString stringWithFormat:@"Matthew 28:20\nTeaching them to observe all things whatsoever I have commanded you: and, lo, I am with you always, even unto the end of the world. Amen."]; 
    else if (verse==23) praise=[NSString stringWithFormat:@"Romans 5:8\nBut God commendeth his love toward us, in that, while we were yet sinners, Christ died for us."];
    else if (verse==24) praise=[NSString stringWithFormat:@"Philipians 4:8\nFinally, brethren, whatsoever things are true, whatsoever things are honest, whatsoever things are just, whatsoever things are pure, whatsoever things are lovely, whatsoever things are of good report; if there be any virtue, and if there be any praise, think on these things."];
    else if (verse==25) praise=[NSString stringWithFormat:@"Philippinas 4:7\nAnd the peace of God, which passeth all understanding, shall keep your hearts and minds through Christ Jesus."];
    else if (verse==26) praise=[NSString stringWithFormat:@"Joshua 1:9\nHave not I commanded thee? Be strong and of a good courage; be not afraid, neither be thou dismayed: for the LORD thy God is with thee whithersoever thou goest."];
    else if (verse==27) praise=[NSString stringWithFormat:@"Isaiah 40:31\nBut they that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles; they shall run, and not be weary; and they shall walk, and not faint."];
    else if (verse==28) praise=[NSString stringWithFormat:@"Ephesians 2:9\nNot of works, lest any man should boast."];
    else if (verse==29) praise=[NSString stringWithFormat:@"Romans 6:23\nFor the wages of sin is death; but the gift of God is eternal life through Jesus Christ our Lord."];
    else if (verse==30) praise=[NSString stringWithFormat:@"Galatians 5:23\nMeekness, temperance: against such there is no law. Isaiah 40:31\nBut they that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles; they shall run, and not be weary; and they shall walk, and not faint Isaiah 40:31\nBut they that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles; they shall run, and not be weary; and they shall walk, and not faint"];
    else if (verse==31) praise=[NSString stringWithFormat:@"Isaiah 53:5\nBut he was wounded for our transgressions, he was bruised for our iniquities: the chastisement of our peace was upon him; and with his stripes we are healed."];
    else if (verse==32) praise=[NSString stringWithFormat:@"1 Peter 3:15\nBut sanctify the Lord God in your hearts: and be ready always to give an answer to every man that asketh you a reason of the hope that is in you with meekness and fear:"];
    else if (verse==33) praise=[NSString stringWithFormat:@"2 Timothy 3:16\nAll scripture is given by inspiration of God, and is profitable for doctrine, for reproof, for correction, for instruction in righteousness:"];
    else if (verse==34) praise=[NSString stringWithFormat:@"Matthew 6:33\nBut seek ye first the kingdom of God, and his righteousness; and all these things shall be added unto you."];
    else if (verse==35) praise=[NSString stringWithFormat:@"Hebrews 12:2\nLooking unto Jesus the author and finisher of our faith; who for the joy that was set before him endured the cross, despising the shame, and is set down at the right hand of the throne of God."];
    else if (verse==36) praise=[NSString stringWithFormat:@"1 Peter 5:7\nCasting all your care upon him; for he careth for you."];
    else if (verse==37) praise=[NSString stringWithFormat:@"Ephesians 2:10\nFor we are his workmanship, created in Christ Jesus unto good works, which God hath before ordained that we should walk in them."];
    else if (verse==38) praise=[NSString stringWithFormat:@"1 Corinthians 10:13\nThere hath no temptation taken you but such as is common to man: but God is faithful, who will not suffer you to be tempted above that ye are able; but will with the temptation also make a way to escape, that ye may be able to bear it."];
    else if (verse==39) praise=[NSString stringWithFormat:@"Matthew 11:28\nCome unto me, all ye that labour and are heavy laden, and I will give you rest."];
    else if (verse==40) praise=[NSString stringWithFormat:@"Hebrew 11:1\nNow faith is the substance of things hoped for, the evidence of things not seen."];
    
    else if (verse==41) praise=[NSString stringWithFormat:@"2 Corinthians 5:17\nTherefore if any man be in Christ, he is a new creature: old things are passed away; behold, all things are become new."];
    else if (verse==42) praise=[NSString stringWithFormat:@"Hebrews 13:5\nLet your conversation be without covetousness; and be content with such things as ye have: for he hath said, I will never leave thee, nor forsake thee."]; 
    else if (verse==43) praise=[NSString stringWithFormat:@"2 Corinthians 12:9\nAnd he said unto me, My grace is sufficient for thee: for my strength is made perfect in weakness. Most gladly therefore will I rather glory in my infirmities, that the power of Christ may rest upon me."];
    else if (verse==44) praise=[NSString stringWithFormat:@"Romans 10:9\nThat if thou shalt confess with thy mouth the Lord Jesus, and shalt believe in thine heart that God hath raised him from the dead, thou shalt be saved."];
    else if (verse==45) praise=[NSString stringWithFormat:@"Isaiah 41:10\nFear thou not; for I am with thee: be not dismayed; for I am thy God: I will strengthen thee; yea, I will help thee; yea, I will uphold thee with the right hand of my righteousness."];
    else if (verse==46) praise=[NSString stringWithFormat:@"Genesis 1:26\nAnd God said, Let us make man in our image, after our likeness: and let them have dominion over the fish of the sea, and over the fowl of the air, and over the cattle, and over all the earth, and over every creeping thing that creepeth upon the earth."];
    else if (verse==47) praise=[NSString stringWithFormat:@"Matthew 11:29\nTake my yoke upon you, and learn of me; for I am meek and lowly in heart: and ye shall find rest unto your souls."];
    else if (verse==48) praise=[NSString stringWithFormat:@"John 16:33\nThese things I have spoken unto you, that in me ye might have peace. In the world ye shall have tribulation: but be of good cheer; I have overcome the world."];
    else if (verse==49) praise=[NSString stringWithFormat:@"Acts 1:8\nBut ye shall receive power, after that the Holy Ghost is come upon you: and ye shall be witnesses unto me both in Jerusalem, and in all Judaea, and in Samaria, and unto the uttermost part of the earth."];
    else if (verse==50) praise=[NSString stringWithFormat:@"2 Timothy 1:7\nFor God hath not given us the spirit of fear; but of power, and of love, and of a sound mind."];
    else if (verse==51) praise=[NSString stringWithFormat:@"Isaiah 53:4\nSurely he hath borne our griefs, and carried our sorrows: yet we did esteem him stricken, smitten of God, and afflicted."];
    else if (verse==52) praise=[NSString stringWithFormat:@"2 Corinthians 5:21\nFor he hath made him to be sin for us, who knew no sin; that we might be made the righteousness of God in him."];
    else if (verse==53) praise=[NSString stringWithFormat:@"Romans 15:13\nNow the God of hope fill you with all joy and peace in believing, that ye may abound in hope, through the power of the Holy Ghost."];
    else if (verse==54) praise=[NSString stringWithFormat:@"John 11:25\nJesus said unto her, I am the resurrection, and the life: he that believeth in me, though he were dead, yet shall he live:"];
    else if (verse==55) praise=[NSString stringWithFormat:@"Hebrews 11:6\nBut without faith it is impossible to please him: for he that cometh to God must believe that he is, and that he is a rewarder of them that diligently seek him."];
    else if (verse==56) praise=[NSString stringWithFormat:@"John 5:24\nVerily, verily, I say unto you, He that heareth my word, and believeth on him that sent me, hath everlasting life, and shall not come into condemnation; but is passed from death unto life."];
    else if (verse==57) praise=[NSString stringWithFormat:@"James 1:2\nMy brethren, count it all joy when ye fall into divers temptations;"];
    else if (verse==58) praise=[NSString stringWithFormat:@"Isaiah 53:6\nAll we like sheep have gone astray; we have turned every one to his own way; and the LORD hath laid on him the iniquity of us all."];
    else if (verse==59) praise=[NSString stringWithFormat:@"Acts 2:38\nThen Peter said unto them, Repent, and be baptized every one of you in the name of Jesus Christ for the remission of sins, and ye shall receive the gift of the Holy Ghost."];
    else if (verse==60) praise=[NSString stringWithFormat:@"Ephesians 3:20\nNow unto him that is able to do exceeding abundantly above all that we ask or think, according to the power that worketh in us,"];
    else if (verse==61) praise=[NSString stringWithFormat:@"Matthew 11:30\nFor my yoke is easy, and my burden is light."];
    else if (verse==62) praise=[NSString stringWithFormat:@"Genesis 1:27\nSo God created man in his own image, in the image of God created he him; male and female created he them."]; 
    else if (verse==63) praise=[NSString stringWithFormat:@"Colossians 3:12\nPut on therefore, as the elect of God, holy and beloved, bowels of mercies, kindness, humbleness of mind, meekness, longsuffering;"];
    else if (verse==64) praise=[NSString stringWithFormat:@"Hebrew 12:1\nWherefore seeing we also are compassed about with so great a cloud of witnesses, let us lay aside every weight, and the sin which doth so easily beset us, and let us run with patience the race that is set before us,"];
    else if (verse==65) praise=[NSString stringWithFormat:@"James 5:16\nConfess your faults one to another, and pray one for another, that ye may be healed. The effectual fervent prayer of a righteous man availeth much."];
    else if (verse==66) praise=[NSString stringWithFormat:@"Acts 17:11\nThese were more noble than those in Thessalonica, in that they received the word with all readiness of mind, and searched the scriptures daily, whether those things were so."];
    else if (verse==67) praise=[NSString stringWithFormat:@"Philippians 4:19\nBut my God shall supply all your need according to his riches in glory by Christ Jesus."];
    else if (verse==68) praise=[NSString stringWithFormat:@"John 1:1\nIn the beginning was the Word, and the Word was with God, and the Word was God."];
    else if (verse==69) praise=[NSString stringWithFormat:@"1 Corinthians 6:19\nWhat? know ye not that your body is the temple of the Holy Ghost which is in you, which ye have of God, and ye are not your own?"];
    else if (verse==70) praise=[NSString stringWithFormat:@"1 John 3:16\nHereby perceive we the love of God, because he laid down his life for us: and we ought to lay down our lives for the brethren."];
    else if (verse==71) praise=[NSString stringWithFormat:@"Psalms 133:1\nBehold, how good and how pleasant it is for brethren to dwell together in unity!"];
    else if (verse==72) praise=[NSString stringWithFormat:@"John 14:27\nPeace I leave with you, my peace I give unto you: not as the world giveth, give I unto you. Let not your heart be troubled, neither let it be afraid."];
    else if (verse==73) praise=[NSString stringWithFormat:@"Hebrews 4:12\nFor the word of God is quick, and powerful, and sharper than any twoedged sword, piercing even to the dividing asunder of soul and spirit, and of the joints and marrow, and is a discerner of the thoughts and intents of the heart."];
    else if (verse==74) praise=[NSString stringWithFormat:@"John 15:13\nGreater love hath no man than this, that a man lay down his life for his friends."];
    else if (verse==75) praise=[NSString stringWithFormat:@"Micha 6:8\nHe hath shewed thee, O man, what is good; and what doth the LORD require of thee, but to do justly, and to love mercy, and to walk humbly with thy God?"];
    else if (verse==76) praise=[NSString stringWithFormat:@"Romans 10:17\nSo then faith cometh by hearing, and hearing by the word of God."];
    else if (verse==77) praise=[NSString stringWithFormat:@"John 1:12\nBut as many as received him, to them gave he power to become the sons of God, even to them that believe on his name:"];
    else if (verse==78) praise=[NSString stringWithFormat:@"James 1:12\nBlessed is the man that endureth temptation: for when he is tried, he shall receive the crown of life, which the Lord hath promised to them that love him."];
    else if (verse==79) praise=[NSString stringWithFormat:@"James 1:3\nKnowing this, that the trying of your faith worketh patience."];
    else if (verse==80) praise=[NSString stringWithFormat:@"Romans 8:38\nFor I am persuaded, that neither death, nor life, nor angels, nor principalities, nor powers, nor things present, nor things to come,"];
    
    
    
    
    else if (verse==81) praise=[NSString stringWithFormat:@"Romans 8:39\nNor height, nor depth, nor any other creature, shall be able to separate us from the love of God, which is in Christ Jesus our Lord."];
                                else if (verse==82) praise=[NSString stringWithFormat:@"Hebrews 10:25\nNot forsaking the assembling of ourselves together, as the manner of some is; but exhorting one another: and so much the more, as ye see the day approaching."]; 
                                else if (verse==83) praise=[NSString stringWithFormat:@"2 Peter 1:4\nWhereby are given unto us exceeding great and precious promises: that by these ye might be partakers of the divine nature, having escaped the corruption that is in the world through lust."];
                                else if (verse==84) praise=[NSString stringWithFormat:@"Philippians 1:6\nBeing confident of this very thing, that he which hath begun a good work in you will perform it until the day of Jesus Christ:"];
                                else if (verse==85) praise=[NSString stringWithFormat:@"Psalms 133:3\nAs the dew of Hermon, and as the dew that descended upon the mountains of Zion: for there the LORD commanded the blessing, even life for evermore."];
                                else if (verse==86) praise=[NSString stringWithFormat:@"Hebrew 4:16\nLet us therefore come boldly unto the throne of grace, that we may obtain mercy, and find grace to help in time of need."];
                                else if (verse==87) praise=[NSString stringWithFormat:@"Psalms 37:4\nDelight thyself also in the LORD: and he shall give thee the desires of thine heart."];
                                else if (verse==88) praise=[NSString stringWithFormat:@"John 3:17\nFor God sent not his Son into the world to condemn the world; but that the world through him might be saved."];
                                else if (verse==89) praise=[NSString stringWithFormat:@"Acts 4:12\nNeither is there salvation in any other: for there is none other name under heaven given among men, whereby we must be saved."];
                                else if (verse==90) praise=[NSString stringWithFormat:@"Isaiah 26:3\nThou wilt keep him in perfect peace, whose mind is stayed on thee: because he trusteth in thee."];
                                else if (verse==91) praise=[NSString stringWithFormat:@"1 Peter 2:24\nWho his own self bare our sins in his own body on the tree, that we, being dead to sins, should live unto righteousness: by whose stripes ye were healed."];
                                else if (verse==92) praise=[NSString stringWithFormat:@"Joshua 1:8\nThis book of the law shall not depart out of thy mouth; but thou shalt meditate therein day and night, that thou mayest observe to do according to all that is written therein: for then thou shalt make thy way prosperous, and then thou shalt have good success."];
                                else if (verse==93) praise=[NSString stringWithFormat:@"Matthew 28:18\nAnd Jesus came and spake unto them, saying, All power is given unto me in heaven and in earth."];
                                else if (verse==94) praise=[NSString stringWithFormat:@"Colossians 3:23\nAnd whatsoever ye do, do it heartily, as to the Lord, and not unto men;"];
                                else if (verse==95) praise=[NSString stringWithFormat:@"Matthew 22:37\nJesus said unto him, Thou shalt love the Lord thy God with all thy heart, and with all thy soul, and with all thy mind."];
                                else if (verse==96) praise=[NSString stringWithFormat:@"Psalms 133:2\nIt is like the precious ointment upon the head, that ran down upon the beard, even Aaron's beard: that went down to the skirts of his garments;"];
                                else if (verse==97) praise=[NSString stringWithFormat:@"Matthew 5:16\nLet your light so shine before men, that they may see your good works, and glorify your Father which is in heaven."];
                                else if (verse==98) praise=[NSString stringWithFormat:@"Isaiah 55:8\nFor my thoughts are not your thoughts, neither are your ways my ways, saith the LORD."];
                                else if (verse==99) praise=[NSString stringWithFormat:@"Hebrew 4:15\nFor we have not an high priest which cannot be touched with the feeling of our infirmities; but was in all points tempted like as we are, yet without sin."];
                                else if (verse==100) praise=[NSString stringWithFormat:@"John 13:35\nBy this shall all men know that ye are my disciples, if ye have love one to another."]; ////////////////////////////////////////////////////////////////////////////////////////////////////
	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
	
	setApartVerse = [NSString stringWithFormat:@"%@",praiseFormatted];
	
	
    
}

- (void) justVerseToPraiseNLT{
    //    verse=24;
    
    if (verse==1) praise=[NSString stringWithFormat:@"John 3:16\n\"For God loved the world so much that he gave his one and only Son, so that everyone who believes in him will not perish but have eternal life."];
    else if (verse==2) praise=[NSString stringWithFormat:@"Jeremiah 29:11\nFor I know the plans I have for you,\" says the LORD. \"They are plans for good and not for disaster, to give you a future and a hope."]; 
    else if (verse==3) praise=[NSString stringWithFormat:@"Romans 8:28\nAnd we know that God causes everything to work together for the good of those who love God and are called according to his purpose for them."];
    else if (verse==4) praise=[NSString stringWithFormat:@"Philipians 4:13\nFor I can do everything through Christ, who gives me strength."];
    else if (verse==5) praise=[NSString stringWithFormat:@"Genesis 1:1\nIn the beginning God created the heavens and the earth."];
    else if (verse==6) praise=[NSString stringWithFormat:@"Proverbs 3:5\nTrust in the LORD with all your heart; do not depend on your own understanding."];
    else if (verse==7) praise=[NSString stringWithFormat:@"Proverbs 3:6\nSeek his will in all you do, and he will show you which path to take."];
    else if (verse==8) praise=[NSString stringWithFormat:@"Romans 12:2\nDon’t copy the behavior and customs of this world, but let God transform you into a new person by changing the way you think. Then you will learn to know God’s will for you, which is good and pleasing and perfect."];
    else if (verse==9) praise=[NSString stringWithFormat:@"Philippians 4:6\nDon’t worry about anything; instead, pray about everything. Tell God what you need, and thank him for all he has done."];
    else if (verse==10) praise=[NSString stringWithFormat:@"Matthew 28:19\nTherefore, go and make disciples of all the nations, baptizing them in the name of the Father and the Son and the Holy Spirit."];
    else if (verse==11) praise=[NSString stringWithFormat:@"Ephesians 2:8\nGod saved you by his grace when you believed. And you can’t take credit for this; it is a gift from God."];
    else if (verse==12) praise=[NSString stringWithFormat:@"Galatians 5:22-23\nBut the Holy Spirit produces this kind of fruit in our lives: love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, and self-control. There is no law against these things!"];
    else if (verse==13) praise=[NSString stringWithFormat:@"Romans 12:1\nAnd so, dear brothers and sisters, I plead with you to give your bodies to God because of all he has done for you. Let them be a living and holy sacrifice—the kind he will find acceptable. This is truly the way to worship him."];
    else if (verse==14) praise=[NSString stringWithFormat:@"John 10:10\nThe thief’s purpose is to steal and kill and destroy. My purpose is to give them a rich and satisfying life."];
    else if (verse==15) praise=[NSString stringWithFormat:@"Acts 18:10\nFor I am with you, and no one will attack and harm you, for many people in this city belong to me.\""];
    else if (verse==16) praise=[NSString stringWithFormat:@"Acts 18:9\nOne night the Lord spoke to Paul in a vision and told him, \"Don’t be afraid! Speak out! Don’t be silent!"];
    else if (verse==17) praise=[NSString stringWithFormat:@"Acts 18:11\nSo Paul stayed there for the next year and a half, teaching the word of God."];
    else if (verse==18) praise=[NSString stringWithFormat:@"Galatians 2:20\nMy old self has been crucified with Christ. It is no longer I who live, but Christ lives in me. So I live in this earthly body by trusting in the Son of God, who loved me and gave himself for me."];
    else if (verse==19) praise=[NSString stringWithFormat:@"1 John 1:9\nBut if we confess our sins to him, he is faithful and just to forgive us our sins and to cleanse us from all wickedness."];
    else if (verse==20) praise=[NSString stringWithFormat:@"Romans 3:23\nFor everyone has sinned; we all fall short of God’s glorious standard."];
    
    
    
    
    
    
    else if (verse==21) praise=[NSString stringWithFormat:@"John 14:6\nJesus told him, \"I am the way, the truth, and the life. No one can come to the Father except through me."];
    else if (verse==22) praise=[NSString stringWithFormat:@"Matthew 28:20\nTeach these new disciples to obey all the commands I have given you. And be sure of this: I am with you always, even to the end of the age."]; 
    else if (verse==23) praise=[NSString stringWithFormat:@"Romans 5:8\nBut God showed his great love for us by sending Christ to die for us while we were still sinners."];
    else if (verse==24) praise=[NSString stringWithFormat:@"Philipians 4:8\nAnd now, dear brothers and sisters, one final thing. Fix your thoughts on what is true, and honorable, and right, and pure, and lovely, and admirable. Think about things that are excellent and worthy of praise."];
    else if (verse==25) praise=[NSString stringWithFormat:@"Philippinas 4:7\nThen you will experience God’s peace, which exceeds anything we can understand. His peace will guard your hearts and minds as you live in Christ Jesus."];
    else if (verse==26) praise=[NSString stringWithFormat:@"Joshua 1:9\nThis is my command—be strong and courageous! Do not be afraid or discouraged. For the LORD your God is with you wherever you go."];
    else if (verse==27) praise=[NSString stringWithFormat:@"Isaiah 40:31\nBut those who trust in the LORD will find new strength. They will soar high on wings like eagles. They will run and not grow weary. They will walk and not faint."];
    else if (verse==28) praise=[NSString stringWithFormat:@"Ephesians 2:9\nSalvation is not a reward for the good things we have done, so none of us can boast about it."];
    else if (verse==29) praise=[NSString stringWithFormat:@"Romans 6:23\nFor the wages of sin is death, but the free gift of God is eternal life through Christ Jesus our Lord."];
    else if (verse==30) praise=[NSString stringWithFormat:@"Galatians 5:23\nGentleness, and self-control. There is no law against these Galatians 5:23\nGentleness, and self-control. There is no law against these Galatians 5:23\nGentleness, and self-control. There is no law against these Galatians 5:23\nGentleness, and self-control. There is no law against these Galatians 5:23\nGentleness, and self-control. There is no law against these things!"];
    else if (verse==31) praise=[NSString stringWithFormat:@"Isaiah 53:5\nBut he was pierced for our rebellion, crushed for our sins. He was beaten so we could be whole. He was whipped so we could be healed."];
    else if (verse==32) praise=[NSString stringWithFormat:@"1 Peter 3:15\nInstead, you must worship Christ as Lord of your life. And if someone asks about your Christian hope, always be ready to explain it."];
    else if (verse==33) praise=[NSString stringWithFormat:@"2 Timothy 3:16\nAll Scripture is inspired by God and is useful to teach us what is true and to make us realize what is wrong in our lives. It corrects us when we are wrong and teaches us to do what is right."];
    else if (verse==34) praise=[NSString stringWithFormat:@"Matthew 6:33\nSeek the Kingdom of God above all else, and live righteously, and he will give you everything you need."];
    else if (verse==35) praise=[NSString stringWithFormat:@"Hebrews 12:2\nWe do this by keeping our eyes on Jesus, the champion who initiates and perfects our faith. Because of the joy awaiting him, he endured the cross, disregarding its shame. Now he is seated in the place of honor beside God’s throne."];
    else if (verse==36) praise=[NSString stringWithFormat:@"1 Peter 5:7\nGive all your worries and cares to God, for he cares about you."];
    else if (verse==37) praise=[NSString stringWithFormat:@"Ephesians 2:10\nFor we are God’s masterpiece. He has created us anew in Christ Jesus, so we can do the good things he planned for us long ago."];
    else if (verse==38) praise=[NSString stringWithFormat:@"1 Corinthians 10:13\nThe temptations in your life are no different from what others experience. And God is faithful. He will not allow the temptation to be more than you can stand. When you are tempted, he will show you a way out so that you can endure."];
    else if (verse==39) praise=[NSString stringWithFormat:@"Matthew 11:28\nThen Jesus said, \"Come to me, all of you who are weary and carry heavy burdens, and I will give you rest.\""];
    else if (verse==40) praise=[NSString stringWithFormat:@"Hebrew 11:1\nFaith is the confidence that what we hope for will actually happen; it gives us assurance about things we cannot see."];
    
    
    
    
    
    else if (verse==41) praise=[NSString stringWithFormat:@"2 Corinthians 5:17\nThis means that anyone who belongs to Christ has become a new person. The old life is gone; a new life has begun!"];
    else if (verse==42) praise=[NSString stringWithFormat:@"Hebrews 13:5\nDon’t love money; be satisfied with what you have. For God has said, \"I will never fail you. I will never abandon you.\""]; 
    else if (verse==43) praise=[NSString stringWithFormat:@"2 Corinthians 12:9\nEach time he said, \"My grace is all you need. My power works best in weakness.\" So now I am glad to boast about my weaknesses, so that the power of Christ can work through me."];
    else if (verse==44) praise=[NSString stringWithFormat:@"Romans 10:9\nIf you confess with your mouth that Jesus is Lord and believe in your heart that God raised him from the dead, you will be saved."];
    else if (verse==45) praise=[NSString stringWithFormat:@"Isaiah 41:10\nDon’t be afraid, for I am with you. Don’t be discouraged, for I am your God. I will strengthen you and help you. I will hold you up with my victorious right hand."];
    else if (verse==46) praise=[NSString stringWithFormat:@"Genesis 1:26\nThen God said, \"Let us make human beings in our image, to be like us. They will reign over the fish in the sea, the birds in the sky, the livestock, all the wild animals on the earth, and the small animals that scurry along the ground.\""];
    else if (verse==47) praise=[NSString stringWithFormat:@"Matthew 11:29\nTake my yoke upon you. Let me teach you, because I am humble and gentle at heart, and you will find rest for your souls."];
    else if (verse==48) praise=[NSString stringWithFormat:@"John 16:33\nI have told you all this so that you may have peace in me. Here on earth you will have many trials and sorrows. But take heart, because I have overcome the world.\""];
    else if (verse==49) praise=[NSString stringWithFormat:@"Acts 1:8\nBut you will receive power when the Holy Spirit comes upon you. And you will be my witnesses, telling people about me everywhere—in Jerusalem, throughout Judea, in Samaria, and to the ends of the earth.\""];
    else if (verse==50) praise=[NSString stringWithFormat:@"2 Timothy 1:7\nFor God has not given us a spirit of fear and timidity, but of power, love, and self-discipline."];
    else if (verse==51) praise=[NSString stringWithFormat:@"Isaiah 53:4\nYet it was our weaknesses he carried; it was our sorrows that weighed him down. And we thought his troubles were a punishment from God, a punishment for his own sins!"];
    else if (verse==52) praise=[NSString stringWithFormat:@"2 Corinthians 5:21\nFor God made Christ, who never sinned, to be the offering for our sin, so that we could be made right with God through Christ."];
    else if (verse==53) praise=[NSString stringWithFormat:@"Romans 15:13\nI pray that God, the source of hope, will fill you completely with joy and peace because you trust in him. Then you will overflow with confident hope through the power of the Holy Spirit."];
    else if (verse==54) praise=[NSString stringWithFormat:@"John 11:25\nJesus told her, \"I am the resurrection and the life. Anyone who believes in me will live, even after dying."];
    else if (verse==55) praise=[NSString stringWithFormat:@"Hebrews 11:6\nAnd it is impossible to please God without faith. Anyone who wants to come to him must believe that God exists and that he rewards those who sincerely seek him."];
    else if (verse==56) praise=[NSString stringWithFormat:@"John 5:24\n\"I tell you the truth, those who listen to my message and believe in God who sent me have eternal life. They will never be condemned for their sins, but they have already passed from death into life."];
    else if (verse==57) praise=[NSString stringWithFormat:@"James 1:2\nDear brothers and sisters, when troubles come your way, consider it an opportunity for great joy."];
    else if (verse==58) praise=[NSString stringWithFormat:@"Isaiah 53:6\nAll of us, like sheep, have strayed away. We have left God’s paths to follow our own. Yet the LORD laid on him the sins of us all."];
    else if (verse==59) praise=[NSString stringWithFormat:@"Acts 2:38\nPeter replied, \"Each of you must repent of your sins and turn to God, and be baptized in the name of Jesus Christ for the forgiveness of your sins. Then you will receive the gift of the Holy Spirit."];
    else if (verse==60) praise=[NSString stringWithFormat:@"Ephesians 3:20\nNow all glory to God, who is able, through his mighty power at work within us, to accomplish infinitely more than we might ask or think"];
    else if (verse==61) praise=[NSString stringWithFormat:@"Matthew 11:30\nFor my yoke is easy to bear, and the burden I give you is light.\""];
    else if (verse==62) praise=[NSString stringWithFormat:@"Genesis 1:27\nSo God created human beings in his own image. In the image of God he created them; male and female he created them."]; 
    else if (verse==63) praise=[NSString stringWithFormat:@"Colossians 3:12\nSince God chose you to be the holy people he loves, you must clothe yourselves with tenderhearted mercy, kindness, humility, gentleness, and patience."];
    else if (verse==64) praise=[NSString stringWithFormat:@"Hebrew 12:1\nTherefore, since we are surrounded by such a huge crowd of witnesses to the life of faith, let us strip off every weight that slows us down, especially the sin that so easily trips us up. And let us run with endurance the race God has set before us."];
    else if (verse==65) praise=[NSString stringWithFormat:@"James 5:16\nConfess your sins to each other and pray for each other so that you may be healed. The earnest prayer of a righteous person has great power and produces wonderful results."];
    else if (verse==66) praise=[NSString stringWithFormat:@"Acts 17:11\nAnd the people of Berea were more open-minded than those in Thessalonica, and they listened eagerly to Paul’s message. They searched the Scriptures day after day to see if Paul and Silas were teaching the truth."];
    else if (verse==67) praise=[NSString stringWithFormat:@"Philippians 4:19\nAnd this same God who takes care of me will supply all your needs from his glorious riches, which have been given to us in Christ Jesus."];
    else if (verse==68) praise=[NSString stringWithFormat:@"John 1:1\nIn the beginning the Word already existed. The Word was with God, and the Word was God."];
    else if (verse==69) praise=[NSString stringWithFormat:@"1 Corinthians 6:19\nDon’t you realize that your body is the temple of the Holy Spirit, who lives in you and was given to you by God? You do not belong to yourself,"];
    else if (verse==70) praise=[NSString stringWithFormat:@"1 John 3:16\nWe know what real love is because Jesus gave up his life for us. So we also ought to give up our lives for our brothers and sisters."];
    else if (verse==71) praise=[NSString stringWithFormat:@"Psalms 133:1\nHow wonderful and pleasant it is when brothers live together in harmony!"];
    else if (verse==72) praise=[NSString stringWithFormat:@"John 14:27\n\"I am leaving you with a gift—peace of mind and heart. And the peace I give is a gift the world cannot give. So don’t be troubled or afraid."];
    else if (verse==73) praise=[NSString stringWithFormat:@"Hebrews 4:12\nFor the word of God is alive and powerful. It is sharper than the sharpest two-edged sword, cutting between soul and spirit, between joint and marrow. It exposes our innermost thoughts and desires."];
    else if (verse==74) praise=[NSString stringWithFormat:@"John 15:13\nThere is no greater love than to lay down one’s life for one’s friends."];
    else if (verse==75) praise=[NSString stringWithFormat:@"Micha 6:8\nNo, O people, the LORD has told you what is good, and this is what he requires of you: to do what is right, to love mercy, and to walk humbly with your God."];
    else if (verse==76) praise=[NSString stringWithFormat:@"Romans 10:17\nSo faith comes from hearing, that is, hearing the Good News about Christ."];
    else if (verse==77) praise=[NSString stringWithFormat:@"John 1:12\nBut to all who believed him and accepted him, he gave the right to become children of God."];
    else if (verse==78) praise=[NSString stringWithFormat:@"James 1:12\nGod blesses those who patiently endure testing and temptation. Afterward they will receive the crown of life that God has promised to those who love him."];
    else if (verse==79) praise=[NSString stringWithFormat:@"James 1:3\nFor you know that when your faith is tested, your endurance has a chance to grow."];
    else if (verse==80) praise=[NSString stringWithFormat:@"Romans 8:38\nAnd I am convinced that nothing can ever separate us from God’s love. Neither death nor life, neither angels nor demons, neither our fears for today nor our worries about tomorrow—not even the powers of hell can separate us from God’s love."];
    
    
    
    
    else if (verse==81) praise=[NSString stringWithFormat:@"Romans 8:39\nNo power in the sky above or in the earth below -indeed, nothing in all creation will ever be able to separate us from the love of God that is revealed in Christ Jesus our Lord."];
    else if (verse==82) praise=[NSString stringWithFormat:@"Hebrews 10:25\nAnd let us not neglect our meeting together, as some people do, but encourage one another, especially now that the day of his return is drawing near."]; 
    else if (verse==83) praise=[NSString stringWithFormat:@"2 Peter 1:4\nAnd because of his glory and excellence, he has given us great and precious promises. These are the promises that enable you to share his divine nature and escape the world’s corruption caused by human desires."];
    else if (verse==84) praise=[NSString stringWithFormat:@"Philippians 1:6\nAnd I am certain that God, who began the good work within you, will continue his work until it is finally finished on the day when Christ Jesus returns."];
    else if (verse==85) praise=[NSString stringWithFormat:@"Psalms 133:3\nHarmony is as refreshing as the dew from Mount Hermon that falls on the mountains of Zion. And there the LORD has pronounced his blessing, even life everlasting."];
    else if (verse==86) praise=[NSString stringWithFormat:@"Hebrew 4:16\nSo let us come boldly to the throne of our gracious God. There we will receive his mercy, and we will find grace to help us when we need it most."];
    else if (verse==87) praise=[NSString stringWithFormat:@"Psalms 37:4\nTake delight in the LORD, and he will give you your heart’s desires."];
    else if (verse==88) praise=[NSString stringWithFormat:@"John 3:17\nGod sent his Son into the world not to judge the world, but to save the world through him."];
    else if (verse==89) praise=[NSString stringWithFormat:@"Acts 4:12\nThere is salvation in no one else! God has given no other name under heaven by which we must be saved.\”"];
    else if (verse==90) praise=[NSString stringWithFormat:@"Isaiah 26:3\nYou will keep in perfect peace all who trust in you, all whose thoughts are fixed on you"];
    else if (verse==91) praise=[NSString stringWithFormat:@"1 Peter 2:24\nHe personally carried our sins in his body on the cross so that we can be dead to sin and live for what is right. By his wounds you are healed."];
    else if (verse==92) praise=[NSString stringWithFormat:@"Joshua 1:8\nStudy this Book of Instruction continually. Meditate on it day and night so you will be sure to obey everything written in it. Only then will you prosper and succeed in all you do."];
    else if (verse==93) praise=[NSString stringWithFormat:@"Matthew 28:18\nJesus came and told his disciples, \"I have been given all authority in heaven and on earth."];
    else if (verse==94) praise=[NSString stringWithFormat:@"Colossians 3:23\nWork willingly at whatever you do, as though you were working for the Lord rather than for people."];
    else if (verse==95) praise=[NSString stringWithFormat:@"Matthew 22:37\nJesus replied, \"‘You must love the LORD your God with all your heart, all your soul, and all your mind.’"];
    else if (verse==96) praise=[NSString stringWithFormat:@"Psalms 133:2\nFor harmony is as precious as the anointing oil that was poured over Aaron’s head, that ran down his beard and onto the border of his robe."];
    else if (verse==97) praise=[NSString stringWithFormat:@"Matthew 5:16\nIn the same way, let your good deeds shine out for all to see, so that everyone will praise your heavenly Father."];
    else if (verse==98) praise=[NSString stringWithFormat:@"Isaiah 55:8\n\"My thoughts are nothing like your thoughts,\" says the LORD. \"And my ways are far beyond anything you could imagine."];
    else if (verse==99) praise=[NSString stringWithFormat:@"Hebrew 4:15\nThis High Priest of ours understands our weaknesses, for he faced all of the same testings we do, yet he did not sin."];
    else if (verse==100) praise=[NSString stringWithFormat:@"John 13:35\nYour love for one another will prove to the world that you are my disciples.\""]; ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
	
	setApartVerse = [NSString stringWithFormat:@"%@",praiseFormatted];
	
	
    
} 

- (void) justVerseToPraiseNIV{
    //    verse=24;
    if (verse==0) praise=[NSString stringWithFormat:@"John 13:35\nBy this all men will know that you are my disciples, if you love one another."]; 
    
    if (verse==1) praise=[NSString stringWithFormat:@"John 3:16\nFor God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."];
    else if (verse==2) praise=[NSString stringWithFormat:@"Jeremiah 29:11\n\"For I know the plans I have for you, \"declares the LORD,  \"plans to prosper you and not to harm you, plans to give you hope and a future\""]; 
    else if (verse==3) praise=[NSString stringWithFormat:@"Romans 8:28\nAnd we know that in all things God works for the good of those who love him, who have been called according to his purpose."];
    else if (verse==4) praise=[NSString stringWithFormat:@"Philipians 4:13\nI can do everything through him who gives me strength."];
    else if (verse==5) praise=[NSString stringWithFormat:@"Genesis 1:1\nIn the beginning God created the heavens and the earth."];
    else if (verse==6) praise=[NSString stringWithFormat:@"Proverbs 3:5\nTrust in the LORD with all your heart and lean not on your own understanding."];
    else if (verse==7) praise=[NSString stringWithFormat:@"Proverbs 3:6\nIn all your ways submit to him, and he will make your paths straight."];
    else if (verse==8) praise=[NSString stringWithFormat:@"Romans 12:2\nDo not conform any longer to the pattern of this world, but be transformed by the renewing of your mind..."];
    else if (verse==9) praise=[NSString stringWithFormat:@"Philippians 4:6\nDo not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your request to God."];
    else if (verse==10) praise=[NSString stringWithFormat:@"Matthew 28:19\nTherefore go and make disciples of all nations, baptizing them in the name of the Father and of the Son and of the Holy Spirit."];
    else if (verse==11) praise=[NSString stringWithFormat:@"Ephesians 2:8\nFor it is by grace you have been saved, through faith—and this is not from yourselves, it is the gift of God-"];
    else if (verse==12) praise=[NSString stringWithFormat:@"Galatians 5:22\nBut the fruit of the Spirit is love, joy, peace, forbearance, kindness, goodness, faithfulness, gentleness and self-control. Against such things there is no law."];
    else if (verse==13) praise=[NSString stringWithFormat:@"Romans 12:1\nTherefore, I urge you, brothers and sisters, in view of God’s mercy, to offer your bodies as a living sacrifice, holy and pleasing to God, this is your true and proper worship."];
    else if (verse==14) praise=[NSString stringWithFormat:@"John 10:10\nThe thief comes only to steal and kill and destroy; I have come that they may have life, and have it to the full."];
    else if (verse==15) praise=[NSString stringWithFormat:@"Acts 18:10\nFor I am with you, and no one is going to attack and harm you, because I have many people in this city."];
    else if (verse==16) praise=[NSString stringWithFormat:@"Acts 18:9\nOne night the Lord spoke to Paul in a vision: \"Do not be afraid; keep on speaking, do not be silent."];
    else if (verse==17) praise=[NSString stringWithFormat:@"Acts 18:11\nSo Paul stayed in Corinth for a year and a half, teaching them the word of God."];
    else if (verse==18) praise=[NSString stringWithFormat:@"Galatians 2:20\nI have been crucified with Christ and I no longer live, but Christ lives in me..."];
    else if (verse==19) praise=[NSString stringWithFormat:@"1 John 1:9\nIf we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness."];
    else if (verse==20) praise=[NSString stringWithFormat:@"Romans 3:23\nfor all have sinned and fall short of the glory of God,"];
    
    
    
    
    
    else if (verse==21) praise=[NSString stringWithFormat:@"John 14:6\nJesus answered, \"I am the way and the truth and the life. No one comes to the Father except through me."];
    else if (verse==22) praise=[NSString stringWithFormat:@"Matthew 28:20\nand teaching them to obey everything I have commanded you. And surely I am with you always, to the very end of the age.\""]; 
    else if (verse==23) praise=[NSString stringWithFormat:@"Romans 5:8\But God demonstrates his own love for us in this: While we were still sinners, Christ died for us."];
    else if (verse==24) praise=[NSString stringWithFormat:@"Philipians 4:8\nFinally, brothers and sisters, whatever is true, whatever is noble, whatever is right, whatever is pure, whatever is lovely, whatever is admirable —if anything is excellent or praiseworthy —think about such things."];
    else if (verse==25) praise=[NSString stringWithFormat:@"Philippinas 4:7\nAnd the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus."];
    else if (verse==26) praise=[NSString stringWithFormat:@"Joshua 1:9\nHave I not commanded you? Be strong and courageous. Do not be afraid; do not be discouraged, for the LORD your God will be with you wherever you go.\""];
    else if (verse==27) praise=[NSString stringWithFormat:@"Isaiah 40:31\nbut those who hope in the LORD will renew their strength. They will soar on wings like eagles; they will run and not grow weary, they will walk and not be faint."];
    else if (verse==28) praise=[NSString stringWithFormat:@"Ephesians 2:9\nnot by works, so that no one can boast."];
    else if (verse==29) praise=[NSString stringWithFormat:@"Romans 6:23\nFor the wages of sin is death, but the gift of God is eternal life in[a] Christ Jesus our Lord."];
    else if (verse==30) praise=[NSString stringWithFormat:@"Galatians 5:23\ngentleness and self-control. Against such things there is no law. Isaiah 40:31\nBut they that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles; they shall run, and not be weary; and they shall walk, and not faint Isaiah 40:31\nBut they that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles; they shall run, and not be weary; and they shall walk, and not faint"];
    else if (verse==31) praise=[NSString stringWithFormat:@"Isaiah 53:5\nBut he was pierced for our transgressions, he was crushed for our iniquities; the punishment that brought us peace was on him, and by his wounds we are healed."];
    else if (verse==32) praise=[NSString stringWithFormat:@"1 Peter 3:15\nBut in your hearts revere Christ as Lord. Always be prepared to give an answer to everyone who asks you to give the reason for the hope that you have. But do this with gentleness and respect,"];
    else if (verse==33) praise=[NSString stringWithFormat:@"2 Timothy 3:16\nAll Scripture is God-breathed and is useful for teaching, rebuking, correcting and training in righteousness,"];
    else if (verse==34) praise=[NSString stringWithFormat:@"Matthew 6:33\nBut seek first his kingdom and his righteousness, and all these things will be given to you as well."];
    else if (verse==35) praise=[NSString stringWithFormat:@"Hebrews 12:2\nLet us fix our eyes on Jesus, the author and perfecter of our faith, who for the joy set before him endured the cross, scorning its shame, and sat down at the right hand of the throne of God."];
    else if (verse==36) praise=[NSString stringWithFormat:@"1 Peter 5:7\nCast all your anxiety on him because he cares for you."];
    else if (verse==37) praise=[NSString stringWithFormat:@"Ephesians 2:10\nFor we are God’s workmanship, created in Christ Jesus to do good works, which God prepared in advance for us to do."];
    else if (verse==38) praise=[NSString stringWithFormat:@"1 Corinthians 10:13\nNo temptation has seized you except what is common to man. And God is faithful; he will not let you be tempted beyond what you can bear. But when you are tempted, he will also provide a way out so that you can stand up under it."];
    else if (verse==39) praise=[NSString stringWithFormat:@"Matthew 11:28\n \"Come to me, all you who are weary and burdened, and I will give you rest."];
    else if (verse==40) praise=[NSString stringWithFormat:@"Hebrew 11:1\nNow faith is being sure of what we hope for and certain of what we do not see."];
    
    
    else if (verse==41) praise=[NSString stringWithFormat:@"2 Corinthians 5:17\nTherefore, if anyone is in Christ, he is a new creation; the old has gone, the new has come!"];
    else if (verse==42) praise=[NSString stringWithFormat:@"Hebrews 13:5\nKeep your lives free from the love of money and be content with what you have, because God has said, \"Never will I leave you; never will I forsake you.\""]; 
    else if (verse==43) praise=[NSString stringWithFormat:@"2 Corinthians 12:9\nBut he said to me, \"My grace is sufficient for you, for my power is made perfect in weakness. \" Therefore I will boast all the more gladly about my weaknesses, so that Christ’s power may rest on me."];
    else if (verse==44) praise=[NSString stringWithFormat:@"Romans 10:9\nThat if you confess with your mouth, \"Jesus is Lord, \" and believe in your heart that God raised him from the dead, you will be saved."];
    else if (verse==45) praise=[NSString stringWithFormat:@"Isaiah 41:10\nSo do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand."];
    else if (verse==46) praise=[NSString stringWithFormat:@"Genesis 1:26\nThen God said, \"Let us make man in our image, in our likeness, and let them rule over the fish of the sea and the birds of the air, over the livestock, over all the earth, and over all the creatures that move along the ground.\""];
    else if (verse==47) praise=[NSString stringWithFormat:@"Matthew 11:29\nTake my yoke upon you and learn from me, for I am gentle and humble in heart, and you will find rest for your souls."];
    else if (verse==48) praise=[NSString stringWithFormat:@"John 16:33\n \"I have told you these things, so that in me you may have peace. In this world you will have trouble. But take heart! I have overcome the world.\""];
    else if (verse==49) praise=[NSString stringWithFormat:@"Acts 1:8\nBut you will receive power when the Holy Spirit comes on you; and you will be my witnesses in Jerusalem, and in all Judea and Samaria, and to the ends of the earth.\""];
    else if (verse==50) praise=[NSString stringWithFormat:@"2 Timothy 1:7\nFor God did not give us a spirit of timidity, but a spirit of power, of love and of self-discipline."];
    else if (verse==51) praise=[NSString stringWithFormat:@"Isaiah 53:4\nSurely he took up our infirmities and carried our sorrows, yet we considered him stricken by God, smitten by him, and afflicted."];
    else if (verse==52) praise=[NSString stringWithFormat:@"2 Corinthians 5:21\nGod made him who had no sin to be sin for us, so that in him we might become the righteousness of God."];
    else if (verse==53) praise=[NSString stringWithFormat:@"Romans 15:13\nMay the God of hope fill you with all joy and peace as you trust in him, so that you may overflow with hope by the power of the Holy Spirit."];
    else if (verse==54) praise=[NSString stringWithFormat:@"John 11:25\nJesus said to her, \"I am the resurrection and the life. He who believes in me will live, even though he dies;"];
    else if (verse==55) praise=[NSString stringWithFormat:@"Hebrews 11:6\nAnd without faith it is impossible to please God, because anyone who comes to him must believe that he exists and that he rewards those who earnestly seek him."];
    else if (verse==56) praise=[NSString stringWithFormat:@"John 5:24\n\"I tell you the truth, whoever hears my word and believes him who sent me has eternal life and will not be condemned; he has crossed over from death to life."];
    else if (verse==57) praise=[NSString stringWithFormat:@"James 1:2\nConsider it pure joy, my brothers, whenever you face trials of many kinds,"];
    else if (verse==58) praise=[NSString stringWithFormat:@"Isaiah 53:6\nWe all, like sheep, have gone astray, each of us has turned to his own way; and the LORD has laid on him the iniquity of us all."];
    else if (verse==59) praise=[NSString stringWithFormat:@"Acts 2:28\nPeter replied, \"Repent and be baptized, every one of you, in the name of Jesus Christ for the forgiveness of your sins. And you will receive the gift of the Holy Spirit.\""];
    else if (verse==60) praise=[NSString stringWithFormat:@"Ephesians 3:20\nNow to him who is able to do immeasurably more than all we ask or imagine, according to his power that is at work within us,"];
    
    else if (verse==61) praise=[NSString stringWithFormat:@"Matthew 11:30\nFor my yoke is easy and my burden is light.\""];
    else if (verse==62) praise=[NSString stringWithFormat:@"Genesis 1:27\nSo God created man in his own image, in the image of God he created him; male and female he created them."]; 
    else if (verse==63) praise=[NSString stringWithFormat:@"Colossians 3:12\nTherefore, as God’s chosen people, holy and dearly loved, clothe yourselves with compassion, kindness, humility, gentleness and patience."];
    else if (verse==64) praise=[NSString stringWithFormat:@"Hebrew 12:1\nTherefore, since we are surrounded by such a great cloud of witnesses, let us throw off everything that hinders and the sin that so easily entangles, and let us run with perseverance the race marked out for us."];
    else if (verse==65) praise=[NSString stringWithFormat:@"James 5:16\nTherefore confess your sins to each other and pray for each other so that you may be healed. The prayer of a righteous man is powerful and effective."];
    else if (verse==66) praise=[NSString stringWithFormat:@"Acts 17:11\nNow the Bereans were of more noble character than the Thessalonians, for they received the message with great eagerness and examined the Scriptures every day to see if what Paul said was true."];
    else if (verse==67) praise=[NSString stringWithFormat:@"Philippians 4:19\nAnd my God will meet all your needs according to his glorious riches in Christ Jesus."];
    else if (verse==68) praise=[NSString stringWithFormat:@"John 1:1\nIn the beginning was the Word, and the Word was with God, and the Word was God."];
    else if (verse==69) praise=[NSString stringWithFormat:@"1 Corinthians 6:19\nDo you not know that your body is a temple of the Holy Spirit, who is in you, whom you have received from God? You are not your own;"];
    else if (verse==70) praise=[NSString stringWithFormat:@"1 John 3:16\nThis is how we know what love is: Jesus Christ laid down his life for us. And we ought to lay down our lives for our brothers."];
    else if (verse==71) praise=[NSString stringWithFormat:@"Psalms 133:1\nHow good and pleasant it is when brothers live together in unity!"];
    else if (verse==72) praise=[NSString stringWithFormat:@"John 14:27\nPeace I leave with you; my peace I give you. I do not give to you as the world gives. Do not let your hearts be troubled and do not be afraid."];
    else if (verse==73) praise=[NSString stringWithFormat:@"Hebrews 4:12\nFor the word of God is living and active. Sharper than any double-edged sword, it penetrates even to dividing soul and spirit, joints and marrow; it judges the thoughts and attitudes of the heart."];
    else if (verse==74) praise=[NSString stringWithFormat:@"John 15:13\nGreater love has no one than this, that he lay down his life for his friends."];
    else if (verse==75) praise=[NSString stringWithFormat:@"Micha 6:8\nHe has showed you, O man, what is good. And what does the LORD require of you? To act justly and to love mercy and to walk humbly with your God."];
    else if (verse==76) praise=[NSString stringWithFormat:@"Romans 10:17\nConsequently, faith comes from hearing the message, and the message is heard through the word of Christ."];
    else if (verse==77) praise=[NSString stringWithFormat:@"John 1:12\nYet to all who received him, to those who believed in his name, he gave the right to become children of God—"];
    else if (verse==78) praise=[NSString stringWithFormat:@"James 1:12\nBlessed is the man who perseveres under trial, because when he has stood the test, he will receive the crown of life that God has promised to those who love him."];
    else if (verse==79) praise=[NSString stringWithFormat:@"James 1:3\nbecause you know that the testing of your faith develops perseverance."];
    else if (verse==80) praise=[NSString stringWithFormat:@"Romans 8:38\nFor I am convinced that neither death nor life, neither angels nor demons, neither the present nor the future, nor any powers,"];
    
    
    
    
    
    
    else if (verse==81) praise=[NSString stringWithFormat:@"Romans 8:39\nneither height nor depth, nor anything else in all creation, will be able to separate us from the love of God that is in Christ Jesus our Lord."];
    
    else if (verse==82) praise=[NSString stringWithFormat:@"Hebrews 10:25\nLet us not give up meeting together, as some are in the habit of doing, but let us encourage one another—and all the more as you see the Day approaching."]; 
    else if (verse==83) praise=[NSString stringWithFormat:@"2 Peter 1:4\nThrough these he has given us his very great and precious promises, so that through them you may participate in the divine nature and escape the corruption in the world caused by evil desires."];
    else if (verse==84) praise=[NSString stringWithFormat:@"Philippians 1:6\nbeing confident of this, that he who began a good work in you will carry it on to completion until the day of Christ Jesus."];
    else if (verse==85) praise=[NSString stringWithFormat:@"Psalms 133:3\nIt is as if the dew of Hermon were falling on Mount Zion. For there the LORD bestows his blessing, even life forevermore."];
    else if (verse==86) praise=[NSString stringWithFormat:@"Hebrew 4:16\nLet us then approach the throne of grace with confidence, so that we may receive mercy and find grace to help us in our time of need."];
    else if (verse==87) praise=[NSString stringWithFormat:@"Psalms 37:4\nDelight yourself in the LORD and he will give you the desires of your heart."];
    else if (verse==88) praise=[NSString stringWithFormat:@"John 3:17\nFor God did not send his Son into the world to condemn the world, but to save the world through him."];
    else if (verse==89) praise=[NSString stringWithFormat:@"Acts 4:12\nSalvation is found in no one else, for there is no other name under heaven given to men by which we must be saved.\""];
    else if (verse==90) praise=[NSString stringWithFormat:@"Isaiah 26:3\nYou will keep in perfect peace him whose mind is steadfast, because he trusts in you."];
    else if (verse==91) praise=[NSString stringWithFormat:@"1 Peter 2:24\n He himself bore our sins in his body on the tree, so that we might die to sins and live for righteousness; by his wounds you have been healed."];
    else if (verse==92) praise=[NSString stringWithFormat:@"Joshua 1:8\nDo not let this Book of the Law depart from your mouth; meditate on it day and night, so that you may be careful to do everything written in it. Then you will be prosperous and successful."];
    else if (verse==93) praise=[NSString stringWithFormat:@"Matthew 28:18\nThen Jesus came to them and said, \"All authority in heaven and on earth has been given to me."];
    else if (verse==94) praise=[NSString stringWithFormat:@"Colossians 3:23\nWhatever you do, work at it with all your heart, as working for the Lord, not for men,"];
    else if (verse==95) praise=[NSString stringWithFormat:@"Matthew 22:37\nJesus replied: \" ‘Love the Lord your God with all your heart and with all your soul and with all your mind.’"];
    else if (verse==96) praise=[NSString stringWithFormat:@"Psalms 133:2\nIt is like precious oil poured on the head, running down on the beard, running down on Aaron’s beard, down upon the collar of his robes."];
    else if (verse==97) praise=[NSString stringWithFormat:@"Matthew 5:16\nIn the same way, let your light shine before men, that they may see your good deeds and praise your Father in heaven."];
    else if (verse==98) praise=[NSString stringWithFormat:@"Isaiah 55:8\n \"For my thoughts are not your thoughts, neither are your ways my ways, \"declares the LORD."];
    else if (verse==99) praise=[NSString stringWithFormat:@"Hebrew 4:15\nFor we do not have a high priest who is unable to sympathize with our weaknesses, but we have one who has been tempted in every way, just as we are—yet was without sin."];
    else if (verse==100) praise=[NSString stringWithFormat:@"John 13:35\nBy this all men will know that you are my disciples, if you love one another.\""]; 
    
    
    
	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
	
	setApartVerse = [NSString stringWithFormat:@"%@",praiseFormatted];
	
	
    
}


- (void) justVerseToPraise{
	//verse=0;  historicvers
//	if (verse==0) praise=[NSString stringWithFormat:@"John 14:15\nTouch and drag the words\n until they make the verse,\n green words are in the right place,\n red words still need rearrangement Get it?"];
	if (verse==1) praise=[NSString stringWithFormat:@"John 14:15\nIf you love me, keep my commands"];

	else if (verse==2) praise=[NSString stringWithFormat:@"Colossians 3:23\nWhatever you do, work at it with all your heart, as working for the Lord, not for men"];
	
	//else if (verse==2) praise=[NSString stringWithFormat:@"Philippians 4:6\nDo not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God"];
	//else if (verse==3) praise=[NSString stringWithFormat:@"1Peter 2:24: He himself bore our sins in his body on the tree, so that we might die to sins and live for righteousness; by his wounds you have been healed"];
	//else if (verse==3) praise=[NSString stringWithFormat:@"Proverbs 3:5\nTrust in the LORD with all your heart and lean not on your own understanding"];
	else if (verse==3) praise=[NSString stringWithFormat:@"John 5:24\nWhoever hears my word and believes him who sent me has eternal life and will not be judged but has crossed over from death to life"];
	else if (verse==4) praise=[NSString stringWithFormat:@"Matthew 22:37\nLove the Lord your God with all your heart and with all your soul and with all your mind"];
	
	//	else if (verse==4) praise=[NSString stringWithFormat:@"Hebrews 4:12\nFor the word of God is alive and active. Sharper than any double-edged sword, it penetrates even to dividing soul and spirit, joints and marrow; it judges the thoughts and attitudes of the heart"];
	else if (verse==5) praise=[NSString stringWithFormat:@"John 13:34\nA new command I give you: Love one another, As I have loved you, so you must love one another"];
	
	else if (verse==6) praise=[NSString stringWithFormat:@"1 Peter 3:15\nAlways be prepared to give an answer to everyone who asks you to give the reason for the hope that you have"];
	
	else if (verse==7) praise=[NSString stringWithFormat:@"Hebrews 10:25\nLet us not give up meeting together"];
	else if (verse==8) praise=[NSString stringWithFormat:@"Psalms 37:4\nDelight yourself in the LORD and he will give you the desires of your heart"];
	
	//else if (verse==7) praise=[NSString stringWithFormat:@"Isaiah 53:5 But he was pierced for our transgressions, he was crushed for our iniquities; the punishment that brought us peace was upon him, and by his wounds we are healed"];
	//else if (verse==8) praise=[NSString stringWithFormat:@"Heb 4:15 For we do not have a high priest who is unable to sympathize with our weaknesses, but we have one who has been tempted in every way, just as we are—yet was without sin"];
	else if (verse==9) praise=[NSString stringWithFormat:@"Matthew 11:30\nFor my yoke is easy and my burden is light"];
	else if (verse==10) praise=[NSString stringWithFormat:@"Matthew 6:33\nBut seek first his kingdom and his righteousness, and all these things will be given to you as well"];
	else if (verse==11) praise=[NSString stringWithFormat:@"Hebrews 12:2\nLet us fix our eyes on Jesus, the author and perfecter of our faith, who for the joy set before him endured the cross"];
	else if (verse==12) praise=[NSString stringWithFormat:@"1 Peter 5:7\nCast all your anxiety on him because he cares for you"];
	else if (verse==13) praise=[NSString stringWithFormat:@"Matthew 28:18\nThen Jesus came to them and said, \"All authority in heaven and on earth has been given to me\""];
	else if (verse==14) praise=[NSString stringWithFormat:@"Matthew 11:28\nCome to me, all you who are weary and burdened, and I will give you rest"];
	else if (verse==15) praise=[NSString stringWithFormat:@"2 Corinthians 5:17\nTherefore, if anyone is in Christ, he is a new creation; the old has gone, the new has come!"];
	else if (verse==16) praise=[NSString stringWithFormat:@"1 John 4:16\nWe know and rely on the love God has for us. God is love. Whoever lives in love lives in God, and God in him"];
	else if (verse==17) praise=[NSString stringWithFormat:@"Jeremiah 29:11\nI know the plans I have for you, declares the LORD, plans to prosper you and not to harm you, plans to give you hope and a future"];
	else if (verse==18) praise=[NSString stringWithFormat:@"Romans 8:28\nIn all things God works for the good of those who love him, who have been called according to his purpose"];
	else if (verse==19) praise=[NSString stringWithFormat:@"Philipians 4:13\nI can do everything through him who gives me strength"];
	else if (verse==20) praise=[NSString stringWithFormat:@"Proverbs 3:6\nIn all your ways acknowledge him, and he will make your paths straight"];
	else if (verse==21) praise=[NSString stringWithFormat:@"Romans 12:2\nDo not conform any longer to the pattern of this world, but be transformed by the renewing of your mind"];
	else if (verse==22) praise=[NSString stringWithFormat:@"Matthew 16:25\nWhoever would save his life will lose it, but whoever loses his life for my sake will find it"];	
	else if (verse==23) praise=[NSString stringWithFormat:@"2 Corinthians 12:9\nMy grace is sufficient for you, for my power is made perfect in weakness"];
	else if (verse==24) praise=[NSString stringWithFormat:@"Joshua 1:9\nBe strong and courageous. Do not be terrified; do not be discouraged, for the LORD your God will be with you wherever you go"];
	else if (verse==25) praise=[NSString stringWithFormat:@"2 Timothy 1:7\nFor God did not give us a spirit of timidity, but a spirit of power, of love and of self-discipline"];
	else if (verse==26) praise=[NSString stringWithFormat:@"2 Corinthians 5:21\nGod made him who had no sin to be sin for us, so that in him we might become the righteousness of God"];
	else if (verse==27) praise=[NSString stringWithFormat:@"Philipians 1:6\nHe who began a good work in you will carry it on to completion until the day of Christ Jesus"];
	else if (verse==28) praise=[NSString stringWithFormat:@"1 John 3:16\nThis is how we know what love is: Jesus Christ laid down his life for us. And we ought to lay down our lives for our brothers"];
	else if (verse==29) praise=[NSString stringWithFormat:@"Isaiah 53:6\nWe all, like sheep, have gone astray, each of us has turned to his own way; and the LORD has laid on him the iniquity of us all"];
	else if (verse==30) praise=[NSString stringWithFormat:@"John 3:3\nJesus replied, \"Very truly I tell you, no one can see the kingdom of God without being born again\""];  //////
	else if (verse==31) praise=[NSString stringWithFormat:@"John 3:17\nFor God did not send his Son into the world to condemn the world, but to save the world through him"];
	else if (verse==32) praise=[NSString stringWithFormat:@"Romans 5:8\nGod demonstrates his own love for us in this: While we were still sinners, Christ died for us"];
	else if (verse==33) praise=[NSString stringWithFormat:@"Philipians 4:7\nAnd the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus"];
	else if (verse==34) praise=[NSString stringWithFormat:@"John 16:33\nI have told you these things, so that in me you may have peace. In this world you will have trouble. But take heart! I have overcome the world"];
	else if (verse==35) praise=[NSString stringWithFormat:@"Isaiah 53:4\nSurely he took up our infirmities and carried our sorrows, yet we considered him stricken by God, smitten by him, and afflicted"];
	else if (verse==36) praise=[NSString stringWithFormat:@"Galatians 2:20\nI have been crucified with Christ and I no longer live, but Christ lives in me..."];
	else if (verse==37) praise=[NSString stringWithFormat:@"John 11:25\nJesus said to her, I am the resurrection and the life. He who believes in me will live, even though he dies"];
	//else if (verse==38) praise=[NSMutableString stringWithFormat:@"Proverbs 16:33\nWe may throw the dice, but the Lord determines how they fall"];
	else if (verse==38) praise=[NSString stringWithFormat:@"Proverbs 16:33\nWe may throw the dice, but the Lord determines how they fall"];
	//	else if (verse==38) praise=[NSString stringWithFormat:@"21. Mark 16:15 NIV | AMP | KJV | All He said to them, Go into all the world and preach the gospel to all creation. (NIV)"];
	
	else if (verse==39) praise=[NSString stringWithFormat:@"John 3:16\nFor God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life"];
	else if (verse==40) praise=[NSString stringWithFormat:@"John 1:1\nIn the beginning was the Word, and the Word was with God, and the Word was God"];
	else if (verse==41) praise=[NSString stringWithFormat:@"John 14:6\nJesus answered, \"I am the way and the truth and the life. No one comes to the Father except through me.\""];
	else if (verse==42) praise=[NSString stringWithFormat:@"Matthew 28:19\nTherefore go and make disciples of all nations, baptizing them in the name of the Father and of the Son and of the Holy Spirit"];
	else if (verse==43) praise=[NSString stringWithFormat:@"Romans 3:23\nFor all have sinned and fall short of the glory of God"];
	else if (verse==44) praise=[NSString stringWithFormat:@"Ephesians 2:8\nFor it is by grace you have been saved, through faith –and this is not from yourselves, it is the gift of God"];
	else if (verse==45) praise=[NSString stringWithFormat:@"Genesis 1:1\nIn the beginning God created the heavens and the earth"];
	else if (verse==46) praise=[NSString stringWithFormat:@"Acts 1:8\nYou will receive power when the Holy Spirit comes on you; and you will be my witnesses in Jerusalem, in all Judea and Samaria, and to the ends of the earth"];
	else if (verse==47) praise=[NSString stringWithFormat:@"2 Timothy 3:16\nAll Scripture is God-breathed and is useful for teaching, rebuking, correcting and training in righteousness"];
	else if (verse==48) praise=[NSString stringWithFormat:@"Romans 10:9\nIf you declare with your mouth, \"Jesus is Lord,\" and believe in your heart that God raised him from the dead, you will be saved"];
	else if (verse==49) praise=[NSString stringWithFormat:@"Romans 6:23\nFor the wages of sin is death, but the gift of God is eternal life in Christ Jesus our Lord"];
	else if (verse==50) praise=[NSString stringWithFormat:@"Acts 2:38\nRepent and be baptized, every one of you, in the name of Jesus Christ for the forgiveness of your sins. And you will receive the gift of the Holy Spirit"];
	else if (verse==51) praise=[NSString stringWithFormat:@"John 1:9\nThe true light that gives light to everyone was coming into the world."];
	else if (verse==52) praise=[NSString stringWithFormat:@"Genesis 1:26\nThen God said, \"Let us make human beings in our image, in our likeness...\""];
	else if (verse==53) praise=[NSString stringWithFormat:@"Romans 12:1\nI urge you, brothers and sisters, in view of God's mercy, to offer your bodies as a living sacrifice, holy and pleasing to God, \"this is true worship\""];
	else if (verse==54) praise=[NSString stringWithFormat:@"Romans 5:8\nBut God demonstrates his own love for us in this: While we were still sinners, Christ died for us"];
	else if (verse==55) praise=[NSString stringWithFormat:@""];
	else if (verse==56) praise=[NSString stringWithFormat:@"John 3:3\nJesus replied, \"Very truly I tell you, no one can see the kingdom of God without being born again\""];
	else if (verse==57) praise=[NSString stringWithFormat:@""];
	else if (verse==58) praise=[NSString stringWithFormat:@""];
	else if (verse==59) praise=[NSString stringWithFormat:@""];
	else if (verse==60) praise=[NSString stringWithFormat:@""];
	else if (verseCount==61) praise=[NSString stringWithFormat:@""];
	else if (verse==62) praise=[NSString stringWithFormat:@""];
	else if (verse==63) praise=[NSString stringWithFormat:@""];
	else if (verse==64) praise=[NSString stringWithFormat:@""];
	else if (verse==65) praise=[NSString stringWithFormat:@""];
	else if (verse==66) praise=[NSString stringWithFormat:@""];
	else if (verse==67) praise=[NSString stringWithFormat:@""];
	else if (verse==68) praise=[NSString stringWithFormat:@""];
	else if (verse==69) praise=[NSString stringWithFormat:@""];
	else if (verse==70) praise=[NSString stringWithFormat:@""];
	else if (verse==71) praise=[NSString stringWithFormat:@""];
	else if (verse==72) praise=[NSString stringWithFormat:@""];
	else if (verse==73) praise=[NSString stringWithFormat:@""];
	else if (verse==74) praise=[NSString stringWithFormat:@""];
	else if (verse==75) praise=[NSString stringWithFormat:@""];
	else if (verse==76) praise=[NSString stringWithFormat:@""];
	else if (verse==77) praise=[NSString stringWithFormat:@""];
	else if (verse==78) praise=[NSString stringWithFormat:@""];
	else if (verse==79) praise=[NSString stringWithFormat:@""];
	else if (verse==80) praise=[NSString stringWithFormat:@""];
	else if (verse==81) praise=[NSString stringWithFormat:@""];
	else if (verse==82) praise=[NSString stringWithFormat:@""];
	else if (verse==83) praise=[NSString stringWithFormat:@""];
	else if (verse==84) praise=[NSString stringWithFormat:@""];
	else if (verse==85) praise=[NSString stringWithFormat:@""];
	else if (verse==86) praise=[NSString stringWithFormat:@""];
	else if (verse==87) praise=[NSString stringWithFormat:@""];
	else if (verse==88) praise=[NSString stringWithFormat:@""];
	else if (verse==89) praise=[NSString stringWithFormat:@""];
	
	//setApartVerse = [NSString stringWithFormat:@"%@",praise];
	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
	
	setApartVerse = [NSString stringWithFormat:@"%@",praiseFormatted];
	
	
	
}
- (void) loadNewVerseToPraise{
//    stringLength=99;
    for (i=0;i<36;i++){
      //  for (i=99;i>36;i--){
//    (stringLength<36)
        [self loadNewVerseToPraise2];
//        i=stringLength;
        if (stringLength<35) i=99;
        else verse++;
        
        NSLog(@"loop %i %i %i",i ,stringLength, verse);
    }
    NSLog(@"called again");

}
    - (void) loadNewVerseToPraise2{
	//verse=38;
//	verse=1;
    if (translation==0)
	[self justVerseToPraiseNIV];
       else  if (translation==1)
           [self justVerseToPraise];
       else  if (translation==2)
    [self justVerseToPraiseKJV];

	/*
	if (verse==1) praise=[NSString stringWithFormat:@"John 14:15\nIf you love me, keep my commands"];
	else if (verse==2) praise=[NSString stringWithFormat:@"Colossians 3:23\nWhatever you do, work at it with all your heart, as working for the Lord, not for men"];
	
	//else if (verse==2) praise=[NSString stringWithFormat:@"Philippians 4:6\nDo not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God"];
	//else if (verse==3) praise=[NSString stringWithFormat:@"1Peter 2:24: He himself bore our sins in his body on the tree, so that we might die to sins and live for righteousness; by his wounds you have been healed"];
	//else if (verse==3) praise=[NSString stringWithFormat:@"Proverbs 3:5\nTrust in the LORD with all your heart and lean not on your own understanding"];
	else if (verse==3) praise=[NSString stringWithFormat:@"John 5:24\nWhoever hears my word and believes him who sent me has eternal life and will not be judged but has crossed over from death to life"];
	else if (verse==4) praise=[NSString stringWithFormat:@"Matthew 22:37\nLove the Lord your God with all your heart and with all your soul and with all your mind"];
	
	//	else if (verse==4) praise=[NSString stringWithFormat:@"Hebrews 4:12\nFor the word of God is alive and active. Sharper than any double-edged sword, it penetrates even to dividing soul and spirit, joints and marrow; it judges the thoughts and attitudes of the heart"];
	else if (verse==5) praise=[NSString stringWithFormat:@"John 13:34\nA new command I give you: Love one another, As I have loved you, so you must love one another"];
	
	else if (verse==6) praise=[NSString stringWithFormat:@"1 Peter 3:15\nAlways be prepared to give an answer to everyone who asks you to give the reason for the hope that you have"];
	
	else if (verse==7) praise=[NSString stringWithFormat:@"Hebrews 10:25\nLet us not give up meeting together"];
	else if (verse==8) praise=[NSString stringWithFormat:@"Psalms 37:4\nDelight yourself in the LORD and he will give you the desires of your heart"];
	
	//else if (verse==7) praise=[NSString stringWithFormat:@"Isaiah 53:5 But he was pierced for our transgressions, he was crushed for our iniquities; the punishment that brought us peace was upon him, and by his wounds we are healed"];
	//else if (verse==8) praise=[NSString stringWithFormat:@"Heb 4:15 For we do not have a high priest who is unable to sympathize with our weaknesses, but we have one who has been tempted in every way, just as we are—yet was without sin"];
	else if (verse==9) praise=[NSString stringWithFormat:@"Matthew 11:30\nFor my yoke is easy and my burden is light"];
	else if (verse==10) praise=[NSString stringWithFormat:@"Matthew 6:33\nBut seek first his kingdom and his righteousness, and all these things will be given to you as well"];
	else if (verse==11) praise=[NSString stringWithFormat:@"Hebrews 12:2\nLet us fix our eyes on Jesus, the author and perfecter of our faith, who for the joy set before him endured the cross"];
	else if (verse==12) praise=[NSString stringWithFormat:@"1 Peter 5:7\nCast all your anxiety on him because he cares for you"];
	else if (verse==13) praise=[NSString stringWithFormat:@"Ephesians 2:10\nFor we are God’s workmanship, created in Christ Jesus to do good works, which God prepared in advance for us to do"];
	else if (verse==14) praise=[NSString stringWithFormat:@"Matthew 11:28\nCome to me, all you who are weary and burdened, and I will give you rest"];
	else if (verse==15) praise=[NSString stringWithFormat:@"2 Corithians 5:17\nTherefore, if anyone is in Christ, he is a new creation; the old has gone, the new has come!"];
	else if (verse==16) praise=[NSString stringWithFormat:@"1 John 4:16\nWe know and rely on the love God has for us. God is love. Whoever lives in love lives in God, and God in him"];
	else if (verse==17) praise=[NSString stringWithFormat:@"Jeremiah 29:11\nI know the plans I have for you, declares the LORD, plans to prosper you and not to harm you, plans to give you hope and a future"];
	else if (verse==18) praise=[NSString stringWithFormat:@"Romans 8:28\nIn all things God works for the good of those who love him, who have been called according to his purpose"];
	else if (verse==19) praise=[NSString stringWithFormat:@"Philipians 4:13\nI can do everything through him who gives me strength"];
	else if (verse==20) praise=[NSString stringWithFormat:@"Proverbs 3:6\nIn all your ways acknowledge him, and he will make your paths straight"];
	else if (verse==21) praise=[NSString stringWithFormat:@"Romans 12:2\nDo not conform any longer to the pattern of this world, but be transformed by the renewing of your mind"];
	else if (verse==22) praise=[NSString stringWithFormat:@"Matthew 16:25\nWhoever would save his life will lose it, but whoever loses his life for my sake will find it"];	
	else if (verse==23) praise=[NSString stringWithFormat:@"2 Corinthians 12:9\nMy grace is sufficient for you, for my power is made perfect in weakness"];
	else if (verse==24) praise=[NSString stringWithFormat:@"Joshua 1:9\nBe strong and courageous. Do not be terrified; do not be discouraged, for the LORD your God will be with you wherever you go"];
	else if (verse==25) praise=[NSString stringWithFormat:@"2 Timothy 1:7\nFor God did not give us a spirit of timidity, but a spirit of power, of love and of self-discipline"];
	else if (verse==26) praise=[NSString stringWithFormat:@"2 Corinthians 5:21\nGod made him who had no sin to be sin for us, so that in him we might become the righteousness of God"];
	else if (verse==27) praise=[NSString stringWithFormat:@"Philipians 1:6\nHe who began a good work in you will carry it on to completion until the day of Christ Jesus"];
	else if (verse==28) praise=[NSString stringWithFormat:@"1 John 3:16\nThis is how we know what love is: Jesus Christ laid down his life for us. And we ought to lay down our lives for our brothers"];
	else if (verse==29) praise=[NSString stringWithFormat:@"Isaiah 53:6\nWe all, like sheep, have gone astray, each of us has turned to his own way; and the LORD has laid on him the iniquity of us all"];
	else if (verse==30) praise=[NSString stringWithFormat:@"Colossians 3:12\nTherefore, as God’s chosen people, holy and dearly loved, clothe yourselves with compassion, kindness, humility, gentleness and patience"];  //////
	else if (verse==31) praise=[NSString stringWithFormat:@"John 3:17\nFor God did not send his Son into the world to condemn the world, but to save the world through him"];
	else if (verse==32) praise=[NSString stringWithFormat:@"Romans 5:8\nGod demonstrates his own love for us in this: While we were still sinners, Christ died for us"];
	else if (verse==33) praise=[NSString stringWithFormat:@"Philipians 4:7\nAnd the peace of God, which transcends all understanding, will guard your hearts and your minds in Christ Jesus"];
	else if (verse==34) praise=[NSString stringWithFormat:@"John 16:33\nI have told you these things, so that in me you may have peace. In this world you will have trouble. But take heart! I have overcome the world"];
	else if (verse==35) praise=[NSString stringWithFormat:@"Isaiah 53:4\nSurely he took up our infirmities and carried our sorrows, yet we considered him stricken by God, smitten by him, and afflicted"];
	else if (verse==36) praise=[NSString stringWithFormat:@"Galatians 2:20\nI have been crucified with Christ and I no longer live, but Christ lives in me..."];
	else if (verse==37) praise=[NSString stringWithFormat:@"John 11:25\nJesus said to her, I am the resurrection and the life. He who believes in me will live, even though he dies"];
	//else if (verse==38) praise=[NSMutableString stringWithFormat:@"Proverbs 16:33\nWe may throw the dice, but the Lord determines how they fall"];
	else if (verse==38) praise=[NSString stringWithFormat:@"Proverbs 16:33\nWe may throw the dice, but the Lord determines how they fall"];
//	else if (verse==38) praise=[NSString stringWithFormat:@"21. Mark 16:15 NIV | AMP | KJV | All He said to them, Go into all the world and preach the gospel to all creation. (NIV)"];
	
	else if (verse==39) praise=[NSString stringWithFormat:@"John 3:16\nFor God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life"];
	else if (verse==40) praise=[NSString stringWithFormat:@"John 1:1\nIn the beginning was the Word, and the Word was with God, and the Word was God"];
	else if (verse==41) praise=[NSString stringWithFormat:@"John 14:6\nJesus answered -I am the way and the truth and the life. No one comes to the Father except through me"];
	else if (verse==42) praise=[NSString stringWithFormat:@"Matthew 28:19\nTherefore go and make disciples of all nations, baptizing them in the name of the Father and of the Son and of the Holy Spirit"];
	else if (verse==43) praise=[NSString stringWithFormat:@"Romans 3:23\nFor all have sinned and fall short of the glory of God"];
	else if (verse==44) praise=[NSString stringWithFormat:@"Ephesians 2:8\nFor it is by grace you have been saved, through faith – and this is not from yourselves, it is the gift of God"];
	else if (verse==45) praise=[NSString stringWithFormat:@"Genesis 1:1\nIn the beginning God created the heavens and the earth"];
	else if (verse==46) praise=[NSString stringWithFormat:@"Acts 1:8\nYou will receive power when the Holy Spirit comes on you; and you will be my witnesses in Jerusalem, in all Judea and Samaria, and to the ends of the earth"];
	else if (verse==47) praise=[NSString stringWithFormat:@"2 Timothy 3:16\nAll Scripture is God-breathed and is useful for teaching, rebuking, correcting and training in righteousness"];
	else if (verse==48) praise=[NSString stringWithFormat:@"Romans 10:9\nIf you declare with your mouth, \"Jesus is Lord,\" and believe in your heart that God raised him from the dead, you will be saved"];
	else if (verse==49) praise=[NSString stringWithFormat:@"Romans 6:23\nFor the wages of sin is death, but the gift of God is eternal life in Christ Jesus our Lord"];
	else if (verse==50) praise=[NSString stringWithFormat:@"Acts 2:38\nPeter replied -Repent and be baptized, every one of you, in the name of Jesus Christ for the forgiveness of your sins. And you will receive the gift of the Holy Spirit"];
	else if (verse==51) praise=[NSString stringWithFormat:@"John 1:9\nThe true light that gives light to everyone was coming into the world."];
	else if (verse==52) praise=[NSString stringWithFormat:@"Genesis 1:26\nThen God said, -Let us make human beings in our image, in our likeness..."];
	else if (verse==53) praise=[NSString stringWithFormat:@"Romans 12:1\nI urge you, brothers and sisters, in view of God's mercy, to offer your bodies as a living sacrifice, holy and pleasing to God –this is true worship"];
	else if (verse==54) praise=[NSString stringWithFormat:@"Romans 5:8\nBut God demonstrates his own love for us in this: While we were still sinners, Christ died for us"];
	else if (verse==55) praise=[NSString stringWithFormat:@"Matthew 28:18\nThen Jesus came to them and said -All authority in heaven and on earth has been given to me"];
	else if (verse==56) praise=[NSString stringWithFormat:@"John 3:3\nJesus replied -Very truly I tell you, no one can see the kingdom of God without being born again"];
	else if (verse==57) praise=[NSString stringWithFormat:@""];
	else if (verse==58) praise=[NSString stringWithFormat:@""];
	else if (verse==59) praise=[NSString stringWithFormat:@""];
	else if (verse==60) praise=[NSString stringWithFormat:@""];
	else if (verse==61) praise=[NSString stringWithFormat:@""];
	else if (verse==62) praise=[NSString stringWithFormat:@""];
	else if (verse==63) praise=[NSString stringWithFormat:@""];
	else if (verse==64) praise=[NSString stringWithFormat:@""];
	else if (verse==65) praise=[NSString stringWithFormat:@""];
	else if (verse==66) praise=[NSString stringWithFormat:@""];
	else if (verse==67) praise=[NSString stringWithFormat:@""];
	else if (verse==68) praise=[NSString stringWithFormat:@""];
	else if (verse==69) praise=[NSString stringWithFormat:@""];
	else if (verse==70) praise=[NSString stringWithFormat:@""];
	else if (verse==71) praise=[NSString stringWithFormat:@""];
	else if (verse==72) praise=[NSString stringWithFormat:@""];
	else if (verse==73) praise=[NSString stringWithFormat:@""];
	else if (verse==74) praise=[NSString stringWithFormat:@""];
	else if (verse==75) praise=[NSString stringWithFormat:@""];
	else if (verse==76) praise=[NSString stringWithFormat:@""];
	else if (verse==77) praise=[NSString stringWithFormat:@""];
	else if (verse==78) praise=[NSString stringWithFormat:@""];
	else if (verse==79) praise=[NSString stringWithFormat:@""];
	else if (verse==80) praise=[NSString stringWithFormat:@""];
	else if (verse==81) praise=[NSString stringWithFormat:@""];
	else if (verse==82) praise=[NSString stringWithFormat:@""];
	else if (verse==83) praise=[NSString stringWithFormat:@""];
	else if (verse==84) praise=[NSString stringWithFormat:@""];
	else if (verse==85) praise=[NSString stringWithFormat:@""];
	else if (verse==86) praise=[NSString stringWithFormat:@""];
	else if (verse==87) praise=[NSString stringWithFormat:@""];
	else if (verse==88) praise=[NSString stringWithFormat:@""];
	else if (verse==89) praise=[NSString stringWithFormat:@""];

	//setApartVerse = [NSString stringWithFormat:@"%@",praise];
	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
	
	setApartVerse = [NSString stringWithFormat:@"%@",praiseFormatted];

*/
	
//////////////////	
	//	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@""];
	//	praiseFormatted = [praise string ByReplacingOccurrencesOfString :@"(NIV)"withString:@""];
	//	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"NIV | AMP | KJV | All"withString:@"\n"];
	
	/*
	for(i = 0; i < [praiseFormatted length]; i++){

		if  (([praiseFormatted characterAtIndex:i] <=9 )&&([praiseFormatted characterAtIndex:i] >=0)) {numInARow++;		hiScore=999;}

	else numInARow=0;
	
		hiScore=999;
	}
	*/
	
	
	//NSString *newStr; 
//	praiseFormatted = [praiseFormatted substringWithRange:NSMakeRange(1, [praiseFormatted length]-3)];
	
//	praiseFormatted = [praiseFormatted substringWithRange:NSMakeRange(3, [praiseFormatted length]-3)];
	
//if  ((characterAtIndex:i == "." )&&(numInARow==2)) delete characterAtIndex 3x
	/*
	21. Mark 16:15
	NIV | AMP | KJV | All
	He said to them, \"Go into all the world and preach the gospel to all creation.\" (NIV)
	22. John 10:10
	NIV | AMP | KJV | All
	The thief comes only to steal and kill and destroy; I have come that they may have life, and have it to the full. (NIV)
	23. John 1:14
	NIV | AMP | KJV | All
	The Word became flesh and made his dwelling among us. We have seen his glory, the glory of the one and only Son, who came from the Father, full of grace and truth. (NIV)
	24. Acts 4:12
	NIV | AMP | KJV | All
	"Salvation is found in no one else, for there is no other name given under heaven by which we must be saved." (NIV)
	25. Acts 2:42
	NIV | AMP | KJV | All
	They devoted themselves to the apostles' teaching and to fellowship, to the breaking of bread and to prayer. (NIV)
	26. John 3:1
	NIV | AMP | KJV | All
	Now there was a Pharisee, a man named Nicodemus who was a member of the Jewish ruling council. (NIV)
	27. Galatians 5:22
	NIV | AMP | KJV | All
	But the fruit of the Spirit is love, joy, peace, patience, kindness, goodness, faithfulness (NIV)
	28. Proverbs 3:5
	NIV | AMP | KJV | All
	Trust in the LORD with all your heart and lean not on your own understanding (NIV)
	29. Jeremiah 29:11
	NIV | AMP | KJV | All
	For I know the plans I have for you," declares the LORD, "plans to prosper you and not to harm you, plans to give you hope and a future. (NIV)
	
	
	*/
	
	
	
	array = [praiseFormatted componentsSeparatedByString: (@" ")];

	if ([[array objectAtIndex:0] length] ==1) {
		
		nBook=      [array objectAtIndex:0];
		book =      [array objectAtIndex:1];
		chapVerse = [array objectAtIndex:2];  //  banner
	
		bookHolder = [book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		nBook = [nBook stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
		chapVerse = [chapVerseArray objectAtIndex:0];
		
		[_textures[bannerText] release];
		
		_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"%@ %@ %@",nBook,book,chapVerse]dimensions:CGSizeMake(822, 122) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:14+fontSizePad/2]; // 14
		
		/// these are in two places
		[array removeObjectAtIndex:0];
		[array removeObjectAtIndex:0];		
		[array removeObjectAtIndex:0];		
		
	}
	else{
		nBook=nil;
	book =      [array objectAtIndex:0];
	chapVerse = [array objectAtIndex:1];  //  banner
		bookHolder = [book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
	
		//	[logoImg setString: trimmedString];
	//bookHolder = [book stringByReplacingOccurrencesOfString :@"s"withString:@"p"];

	//	chapVerse=      @"12:14";

		chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
		chapVerse = [chapVerseArray objectAtIndex:0];
		
	//[_textures[bannerText] release];
	
//	_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"ahhh%@%@",bookHolder,chapVerse]dimensions:CGSizeMake(422, 122) alignment:UITextAlignmentCenter fontName: kFontName2 fontSize:14+fontSizePad]; // 14

	/// these are in two places
	[array removeObjectAtIndex:0];
	[array removeObjectAtIndex:0];

	}
	
	//bookHolder=@"google.com";
	
	//kk=;
	if (kk==0)//[self internetScreen];
	{

	//	UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(-120,120, rect.size.height-15,  rect.size.width-20)];
		//UIWebView *
	//	webView = [[UIWebView alloc] initWithFrame:CGRectMake(-128,128, rect.size.height,  rect.size.width)];
		if (device==0) webView = [[UIWebView alloc] initWithFrame:CGRectMake(-95,128+32, rect.size.height-64,  rect.size.width-64)];
		else  webView = [[UIWebView alloc] initWithFrame:CGRectMake(-61,95, rect.size.height-36,  rect.size.width-28)];
		
		webView.backgroundColor = [UIColor clearColor];
		webView.scalesPageToFit = YES;
		
		//nBook=      @"12:14";
	//	NSString* bookHolder2= [NSString stringWithFormat:@"%@",book];
		//	book =     @" ! Matthew";
		//	bookHolder =     @"Matthew";
		//	book =     bookHolder;
		//bookHolder = [book stringByReplacingOccurrencesOfString :@" "withString:@"p"];
	//	chapVerseHolder=      @"12:14";

	//	chapVerseHolder=     [chapVerse stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];;

//		 chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
//		 chap = [chapVerseArray objectAtIndex:0];
		//bookHolder = [book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

		
		//	if ([@":" isEqualToString: [nBook characterAtIndex:1]])
		//	chapVerse = [nBook substringWithRange: NSMakeRange (0, 2)];
		
		//	book =      [array objectAtIndex:1];
		
	//	NSString *urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@%@",bookHolder,chap];
		
	//	int  chapInt = [chap intValue];
		
	//	chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
	//	chap = [chapVerseArray objectAtIndex:0];
		
		//NSString *urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@",bookHolder];
	
		//if(nBook==nil) urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@%@",bookHolder,chapVerse];
		//else  urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@%@%@",nBook,bookHolder,chapVerse];
		
        if (translation==0){
        
		if(nBook==nil) urlAddress = [NSString stringWithFormat:@"http://mobile.biblegateway.com/passage/index.php?search=%@%@&version=NIV",bookHolder,chapVerse];
		else  urlAddress = [NSString stringWithFormat:@"http://mobile.biblegateway.com/passage/index.php?search=%@%@%@&version=NIV",nBook,bookHolder,chapVerse];
		}
        
        else if (translation==1){
            if(nBook==nil) urlAddress = [NSString stringWithFormat:@"http://mobile.biblegateway.com/passage/index.php?search=%@%@&version=ESV",bookHolder,chapVerse];
            else  urlAddress = [NSString stringWithFormat:@"http://mobile.biblegateway.com/passage/index.php?search=%@%@%@&version=ESV",nBook,bookHolder,chapVerse];
		}
        
        else if (translation==2){
            if(nBook==nil) urlAddress = [NSString stringWithFormat:@"http://mobile.biblegateway.com/passage/index.php?search=%@%@&version=KJV",bookHolder,chapVerse];
            else  urlAddress = [NSString stringWithFormat:@"http://mobile.biblegateway.com/passage/index.php?search=%@%@%@&version=KJV",nBook,bookHolder,chapVerse];
		}       
//		http://mobile.biblegateway.com/passage/index.php?search=john3&version=NIV
		
		//else  
		//	urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=2peter1"];
		
		//	NSString *urlAddress = [NSString stringWithFormat:@"http://www.google.com"];
		
		  
		NSURL *url = [NSURL URLWithString:urlAddress];
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		[webView loadRequest:requestObj];

//		webView.transform =CGAffineTransformMakeTranslation(-200, 200);

		//webView.center.x=20;
	  webView.transform =CGAffineTransformMakeRotation(-M_PI / 2);// +0+0*fmod(0,arc4random()));
		
//		[window addSubview:webView];     //!!!!!!!!!!!!!
		counterInvert=0;
		
		[_timer invalidate];
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		
		_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(animateToWeb) userInfo:nil repeats:YES];
		[UIApplication sharedApplication].idleTimerDisabled = YES;
		
	//		webContainer = [[UIView alloc] initWithFrame:CGRectMake(-0, rect.size.height, 320, rect.size.width)];
//		[webContainer addSubview: webView];
//		[window addSubview: webContainer];
		
	//	[webView release];	
		[window makeKeyAndVisible];
		
		webViewState=YES;
	//	[webView removeFromSuperview];
	//	webViewState=NO;

	}		
	kk++; 
	
	stringLength= [array count];
	start=0;
	wordsPerRow=6;  // seconds
	numRows=(trunc((stringLength-1)/wordsPerRow))+1;
	

	//praise=[NSString stringWithFormat:@"In the beginning was the Word, and the Word was with God, and the Word was God"];
//praise=[NSString stringWithFormat:@"John 1415 If you love me, keep my commands"];
	
//}
}

- (void) gospelScreen{
	
	[self drawBackground];
/*
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glColor4f(1, 1, 1, 1);
	[_textures[kTexture_Blueinv] drawInRect:[glView bounds]];
	glColor4f(1, 1, 1, .7);
	[_textures[kTexture_border] drawInRect:[glView bounds]];
	*/
	
	_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Choose Verse"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: @"Zapfino"  fontSize:30+fontSizePad]; //Verdana"  fontSize:63];
	
	glPushMatrix();
	if (device==1) glTranslatef(168,245, 1);
	else glTranslatef(.73*rect.size.width,.51*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, 1);
	glRotatef(-90, 0, 0, 1);
	
	[_textures[tex] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	[_textures[tex] release];

	///////////////
	
    NSLog(@"g called again");

	[self loadNewVerseToPraise];
	
	_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"%@",praise]dimensions:CGSizeMake(262+fontSizePad*16, 422+fontSizePad) alignment:UITextAlignmentCenter fontName: @"Verdana"  fontSize:17+fontSizePad*.8]; //Verdana"  fontSize:63];
	
	
	glPushMatrix();
	if (device==1) glTranslatef(-19+numRows*4, rect.size.height/2, 1);
	if (device==0) glTranslatef(210+numRows*10, rect.size.height/2, 1);
	
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, .9);
	glRotatef(-90, 0, 0, 1);
	
	[_textures[tex] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	[_textures[tex] release];
	
	
	
	glPushMatrix();
	if (device==1) glTranslatef(160,40, 1);
	else   glTranslatef(rect.size.width/2,.06*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (device==1) glScalef(4, 1, 1);
	else           glScalef(10, 1.5, 1);
	//glColor4f(1, 1, .5, .9);
	glRotatef(180, 0, 0, 1);
	
	if (arrowHighlightRight==YES)  glColor4f(1, 1, 1, .9);
	else glColor4f(1, 1, .5, .9);
	[_textures[kTexture_Arrow] drawAtPoint:CGPointZero];
	
	
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	glPushMatrix();
	//glTranslatef(160,440, 1);
	if (device==1) glTranslatef(160,440, 1);
	else   glTranslatef(rect.size.width/2,.94*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	if (device==1) glScalef(4, 1, 1);
	else           glScalef(10, 1.5, 1);
	
	
//	arrowHighlightLeft=YES;
	if (arrowHighlightLeft==YES)  glColor4f(1, 1, 1, .9);
	else glColor4f(1, 1, .5, .9);
//	glColor4f(1, 1, .5, .9);

	
	[_textures[kTexture_Arrow] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	
	/*
	glPushMatrix();
	glTranslatef(-15,-37, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, .9);
	glRotatef(-90, 0, 0, 1);
	
	[_textures[menuText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	*/
	[self autoRotate];

}
- (void)internetScreen

{
	
//	[book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

//	praiseFormatted = [praise stringByReplacingOccurrencesOfString :@"\n"withString:@" "];
	
//	praiseFormatted = [praise replaceOccurrencesOfString:@"\n"withString:@" "];
	
	
//	[praise replaceOccurrencesOfString:@"\n" withString:@" " 
//									 options:NSCaseInsensitiveSearch 
//									   range:NSMakeRange(0, [praise length])];
	
//	array = [praiseFormatted componentsSeparatedByString: (@" ")];
	//array = [praise componentsSeparatedByString: (@" ")];
	
	
	/*
	if ([[array objectAtIndex:0] length] ==1) {
		
		nBook=      [array objectAtIndex:0];
		book =      [array objectAtIndex:1];
		chapVerse = [array objectAtIndex:2];  //  banner
		//	bookHolder=book;
		//bookHolder = 
		[book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
	//	[_textures[bannerText] release];
		
	//	_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"%@ %@ %@",nBook,book,chapVerse]dimensions:CGSizeMake(822, 122) alignment:UITextAlignmentCenter fontName: kFontName2  fontSize:14+fontSizePad/2]; // 14
		
		/// these are in two places
		[array removeObjectAtIndex:0];
		[array removeObjectAtIndex:0];		
		[array removeObjectAtIndex:0];		
		
	}
	else{
		
		book =      [array objectAtIndex:0];
		chapVerse = [array objectAtIndex:1];  //  banner
		//	bookHolder=book;
		//bookHolder = 
		[book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		
		//	[logoImg setString: trimmedString];
		//bookHolder = [book stringByReplacingOccurrencesOfString :@"s"withString:@"p"];
		
		//chapVerse=      @"12:14";
		
		chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
		chapVerse = [chapVerseArray objectAtIndex:1];
		
	//	[_textures[bannerText] release];
		
	//	_textures[bannerText] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"ahhh%@%@",bookHolder,chapVerse]dimensions:CGSizeMake(422, 122) alignment:UITextAlignmentCenter fontName: kFontName2 fontSize:14+fontSizePad]; // 14
		
		/// these are in two places
		[array removeObjectAtIndex:0];
		[array removeObjectAtIndex:0];
		
	}
	
	*/
	
	//	webView = [[UIWebView alloc] initWithFrame:CGRectMake(-128,128, rect.size.height,  rect.size.width)];
	
	
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(-95,128, rect.size.height-64, rect.size.width)];
	
	webView.backgroundColor = [UIColor clearColor];
//	webView.backgroundColor = [UIColor whiteColor];
	webView.scalesPageToFit = YES;
	
	//nBook=      @"12:14";
	//	NSString* bookHolder2= [NSString stringWithFormat:@"%@",book];
	book =     @"   MattheW  ";
	//	bookHolder =     @"Matthew";
		//book =    @"%@", bookHolder;
    book=	[book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
//	book= [book stringByTrimmingCharactersInSet: [NSCharacterSet uppercaseLetterCharacterSet]];

	//bookHolder = [book stringByReplacingOccurrencesOfString :@" "withString:@"p"];
	//	chapVerseHolder=      @"12:14";
	
	//	chapVerseHolder=     [chapVerse stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];;
	
	//		 chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
	//		 chap = [chapVerseArray objectAtIndex:0];
	//bookHolder = [book stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	
	//	if ([@":" isEqualToString: [nBook characterAtIndex:1]])
	//	chapVerse = [nBook substringWithRange: NSMakeRange (0, 2)];
	
	//	book =      [array objectAtIndex:1];
	
	//	NSString *urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@%@",bookHolder,chap];
	
	//	int  chapInt = [chap intValue];
	
	//	chapVerseArray = [chapVerse componentsSeparatedByString: (@":")];
	//	chap = [chapVerseArray objectAtIndex:0];
	
//	NSString *urlAddress2 = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@",book];
	//NSString *urlAddress2 = [NSString stringWithFormat:@"http://%@",bookHolder];
	//NSString *urlAddress = [NSString stringWithFormat:@"http://www.biblegateway.com/passage/?search=%@%i",bookHolder,chap];
	
	//NSMutableString *urlAddress2 = [NSMutableString stringWithFormat:@"http://www.biblegateway.com"];
	NSString *urlAddress2 = [NSString stringWithFormat:@"http://www.google.com/search?client=safari&rls=en&q=%@&ie=UTF-8&oe=UTF-8",book];
	
	NSURL *url2 = [NSURL URLWithString:urlAddress2];
	NSURLRequest *requestObj2 = [NSURLRequest requestWithURL:url2];
	[webView loadRequest:requestObj2];
	//webView.contentMode=
	webView.transform =CGAffineTransformMakeRotation(-M_PI / 2);
	
	[window addSubview:webView]; 
	
//	[webView release];	
	
	[window makeKeyAndVisible];
	
	webViewState=YES;

}

- (void)optionScreen{
	
	[self drawBackground];

	_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Options"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: @"Zapfino"  fontSize:34+fontSizePad]; //Verdana"  fontSize:63];
	
	glPushMatrix();
	
	if (device==1) glTranslatef(170,245, 1);
	else glTranslatef(.69*rect.size.width,.51*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, 1);
	glRotatef(-90, 0, 0, 1);

	[_textures[tex] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	[_textures[tex] release];
	
	if (device==1) {
	if (toggleSound==YES) // play
	_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Sound: On"]dimensions:CGSizeMake(462, 272) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24]; 
	else
		_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Sound: Off"]dimensions:CGSizeMake(462, 272) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24];
        
        fontSizePad=0;
        if (translation==0) // play
            
            translationT2D = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Translation: NIV"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
        else     if (translation==1) // play
            
            translationT2D = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Translation: ESV"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
        else 
            
            translationT2D = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Translation: KJV"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
    
    
    }
	else{
	if (toggleSound==YES) // play
		_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Sound: On"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
	else
		_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Sound: Off"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
    
    if (translation==0) // play

        translationT2D = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Translation: NIV"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
	else     if (translation==1) // play

		translationT2D = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Translation: ESV"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
    else 
        
        translationT2D = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Translation: KJV"]dimensions:CGSizeMake(462+fontSizePad*6, 272+fontSizePad) alignment:UITextAlignmentCenter fontName: kFontName  fontSize:24+fontSizePad]; 
    
    }
	
	glPushMatrix();
	//glTranslatef(110,250, 1);
	if (device==1) glTranslatef(40,245, 1);
	else      glTranslatef(.35*rect.size.width,.51*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, 1);
	glRotatef(-90, 0, 0, 1);
//	if (flipped==YES)glRotatef(180, 0, 0, 1);

  //  [translationT2D drawAtPoint:CGPointZero];

	[_textures[tex] drawAtPoint:CGPointZero];
    
  //  glTranslatef(0*rect.size.width,.17*rect.size.height, 1);
//	[translationT2D drawAtPoint:CGPointZero];
    
    
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
    
    
    glPushMatrix();
	//glTranslatef(110,250, 1);
	if (device==1) glTranslatef(1,245, 1);
	else      glTranslatef(.2*rect.size.width,.51*rect.size.height, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, 1);
	glRotatef(-90, 0, 0, 1);
    //	if (flipped==YES)glRotatef(180, 0, 0, 1);
    
  //  [translationT2D drawAtPoint:CGPointZero];
    
    //	[_textures[tex] drawAtPoint:CGPointZero];
    
   // glTranslatef(0*rect.size.width,.17*rect.size.height, 1);
	[translationT2D drawAtPoint:CGPointZero];
    
    
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
    
	[_textures[tex] release];
	
	//_textures[tex] = [[Texture2D alloc] initWithString: [NSString stringWithFormat:@"Menu", (seconds)]dimensions:CGSizeMake(222, 122) alignment:UITextAlignmentLeft fontName: @"Zapfino"  fontSize:16];
	/*
	glPushMatrix();
	glTranslatef(-15,-37, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );		
	glColor4f(1, 1, .5, .9);
	glRotatef(-90, 0, 0, 1);
//	if (flipped==YES)glRotatef(180, 0, 0, 1);

	[_textures[menuText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();
	*/
	//[_textures[tex] release];
	
	[self autoRotate];
}

	- (void)success{
	
	
//		words[ii].x+=dx[ii];
//		words[ii].y+=dy[ii];
	
	
	 for(j = i+1; j<[array count]; j++){
	 
	 if ((fabs(words[ii].x-words[j].x)<30)&&(fabs(words[ii].y-words[j].y)<40)) {
	 words[ii].x=words[j].x+1.2*(words[ii].x-words[j].x);
	 words[ii].y=words[j].y+1.2*(words[ii].y-words[j].y);
	 }}
	/* 
	 if(words[ii].x<10){
	 words[ii].x=11;
	 dx[ii]=(-1*dx[ii])/2;
	 dy[ii]=dy[ii]/2;
	 }
	 
	 if(words[ii].y<20){
	 words[ii].y=20;
	 dy[ii]=dy[ii]*-1;
	 }
	 if(words[ii].x>320){
	 words[ii].x=160;//+ arc4random()%8-4;//dx[ii]= arc4random()%8-4;
	 }
	 if(words[ii].y>470){
	 words[ii].y=470;
	 dy[ii]=dy[ii]*-1;
	 //+ arc4random()%380-190;//dx[ii]= arc4random()%8-4;
	 }
	 
	 */
	
	
	ii++;if (ii>15){
		[_timer invalidate];
		_timer = nil;
		[UIApplication sharedApplication].idleTimerDisabled = NO;
		fresh=YES;
	_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30) target:self selector:@selector(saveScore) userInfo:nil repeats:YES];
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	}
	

}
// Release the status texture and initialized values in preparation for starting a new game
- (void)resetGame {
	CGAffineTransform transform2 = CGAffineTransformMakeRotation(0);
	glView.transform = transform2;
	CGRect contentRect2 = CGRectMake(0, 0, 320, 480);
	glView.bounds = contentRect2;
	CGRect				bounds = [glView bounds];
	
		//Reset the state to running mode
	_state = kState_Running;
	//_lastTime = CFAbsoluteTimeGetCurrent();
	_lastThrust = NO;
	
	//Randomize the landing base position
	_basePosition = RANDOM_FLOAT() * (bounds.size.width - kBaseSize) + kBaseSize / 2;
	
	//Set the initial state or the rocket
	//_fuel = kInitialFuel;
	_rotation = 0.0;
	_rotationVelocity = 0.0;
	//_position.x = RANDOM_FLOAT() * (bounds.size.width - _landerBounds.size.width) + _landerBounds.size.width / 2;
	
	//Render a frame immediately
	[self renderScene];
	
	//Start rendering timer  //  menusc
	
	/// y here i d k!!!  tk away and no instruc
	//_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(renderScene) userInfo:nil repeats:YES];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / kRenderingFPS) target:self selector:@selector(saveScore) userInfo:nil repeats:YES];
	
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	
	//Play start sound
	//SoundEngine_StartEffect( _sounds[kSound_Start]);// water3
}


//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    //   if (!self.bannerIsVisible)
//    //   {
//    NSLog(@"bannerViewDidLoadAd method called");
//    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
//    // banner is invisible now and moved out of the screen on 50 px
//    //        banner.frame = CGRectOffset(banner.frame, 0, 50);
//    [UIView commitAnimations];
//    //     self.bannerIsVisible = YES;
//    adLoadedAndReceived=YES;
//    if (adTime==YES) adView.hidden=NO;
//    //        if (adTime==YES)
//
//   // [adView setCenter:CGPointMake(adView.center.x,self.view.frame.size.width*0+adView.frame.size.height*.5)]; //40
//    //    [adView setCenter:CGPointMake(adView.center.x,self.view.frame.size.width*0+adView.frame.size.height*.5)]; //40
//
//    // [self addView];
//    //            [self.view addSubview:adView];   //  onON  ON OFF
//
//    //    }
//}
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    //   if (self.bannerIsVisible)
//    //  {
//    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
//    // banner is visible and we move it out of the screen, due to connection issue
//    //     banner.frame = CGRectOffset(banner.frame, 0, -50);
//    [UIView commitAnimations];
//    // self.bannerIsVisible = NO;
//    //  }
//}
//
//- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
//{
//    NSLog(@"Banner view is beginning an ad action");
//    BOOL shouldExecuteAction = YES;
//    if (!willLeave && shouldExecuteAction)
//    {
//        // stop all interactive processes in the app
//        // [video pause];
//        // [audio pause];
//    }
//    return shouldExecuteAction;
//}
- (void)menuScene {



	[self drawBackground];
	if (fadeIn<1) fadeIn+=.15;
	/*
	glPushMatrix();
	glTranslatef(250,250, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	glColor4f(.1, 1, 1, 1);
	glRotatef(-90, 0, 0, 1);
	//[_textures[titleText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();*/

	if (counterFloat<100) counterFloat+=5;

	glPushMatrix();
	if (device==1) glTranslatef(251,251, 1);
	else {

		//else
		glTranslatef(rect.size.width*.78, rect.size.height*.52,1);

		if (counterFloat<100)
			//	glTranslatef(rect.size.width*.78, rect.size.height*.52+rect.size.height*.8*sin(counterFloat/ 10+1.6)/(.5+counterFloat/1),1);
			glScalef(1+.15*sin(counterFloat/ 100*3.14),
					 1+.15*sin(counterFloat/ 100*3.14), 1);
	}
	//glTranslatef(22,22,1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	if (counterFloat<100)
	glColor4f(1+.4*sin(counterFloat/ 5+1.6)/(.5+counterFloat/40),
			  1+.4*sin(counterFloat/10+1.6)/(.5+counterFloat/40),
			 .5+.4*sin(counterFloat/ 7+1.6)/(.5+counterFloat/40), fadeIn);
	else	glColor4f(1, 1, .5, fadeIn);

	///   SPARKS DANCING IN FRONT BEHIND... OR JUST A FADE IN FOR TITLE?
	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);

	[_textures[titleText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	glPopMatrix();

	// historicver


//	menuStart.x=150;
	menuStart.x=trunc((.55)*rect.size.width);
	menuStart.y=trunc((.76)*rect.size.height);

	menuInstruc.x=.55*rect.size.width;
	menuInstruc.y=.23*rect.size.height;

	menuOptions.x=.39*rect.size.width;
	menuOptions.y=.28*rect.size.height;

//	gameModeXy.x=.23*rect.size.width;
//	gameModeXy.y=.5*rect.size.height;
	gameModeXy.x=.23*rect.size.width;
	gameModeXy.y=.71*rect.size.height;

	gospelXy.x=.39*rect.size.width;  ////
	gospelXy.y=.72*rect.size.height;  ////   //

	resources.x=.23*rect.size.width;  ////
	resources.y=.31*rect.size.height;



	glPushMatrix();
	glTranslatef(menuStart.x+1,menuStart.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	if (menuoption==1) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
	//glColor4f(1, 1, .5, fadeIn);

	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);

	[_textures[startText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	glPopMatrix();

	glPushMatrix();
	glTranslatef(resources.x+1,resources.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	//glColor4f(1, 1, .5, fadeIn);
	if (menuoption==6) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);//	if (flipped==YES)glRotatef(180, 0, 0, 1);
	[_textures[resourcesText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glPopMatrix();

	glPushMatrix();
	glTranslatef(menuInstruc.x+1,menuInstruc.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	if (menuoption==2) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
	//glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);//	if (flipped==YES)glRotatef(180, 0, 0, 1);

	[_textures[instructionsText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	glPopMatrix();
	//[_textures[tex] release];




	glPushMatrix();
	glTranslatef(menuOptions.x+1,menuOptions.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	if (menuoption==3) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
	//glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);

	[_textures[optionsText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	glPopMatrix();





	glPushMatrix();
	glTranslatef(gameModeXy.x+1,gameModeXy.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	if (menuoption==4) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
	//glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);
	if (gameModeSelection==1)[_textures[gameModeText] drawAtPoint:CGPointZero];
	else if(gameModeSelection==2)[_textures[altgameModeText] drawAtPoint:CGPointZero];
	else if (gameModeSelection==0)[_textures[alt2gameModeText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	glPopMatrix();




	glPushMatrix();
	glTranslatef(gospelXy.x+1,gospelXy.y+1, 1);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glTexEnvf(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_MODULATE );
	if (menuoption==5) glColor4f(1, 1, 1, fadeIn);
	else glColor4f(1, 1, .5, fadeIn);
	//glColor4f(1, 1, .5, fadeIn);
	glRotatef(-90, 0, 0, 1);	//if (flipped==YES)glRotatef(180, 0, 0, 1);

	[_textures[gospelText] drawAtPoint:CGPointZero];
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

	glPopMatrix();

	[self autoRotate];
//	needToRunInternetCheck=NO;

	if (needToRunInternetCheck==YES){
		needToRunInternetCheck=NO;
		struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;

	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;

	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);

	if (!didRetrieveFlags)
	{
		printf("Error. Could not recover network reachability flags\n");
		// return 0;
	}

	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	if (isReachable&&!needsConnection) internetIsAvailable=YES;
	else internetIsAvailable=NO;
	}

    showAdBool=YES;
//    if (showAdBool==YES){
//        adTime=YES;
//        if (adLoaded==NO)
//        {
//            adLoaded=YES;
//
//
//            adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//            [adView setDelegate: self];
//            //        adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
//            if (&ADBannerContentSizeIdentifierPortrait != nil) {
//                adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
//            } else {
//
//                adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifier480x32];
//                adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier480x32;//
//
//            }
//            //   [adView setCenter:CGPointMake(adView.center.x,self.view.frame.size.width*0+adView.frame.size.height*3.25)]; //40
//            [adView setCenter:CGPointMake(adView.center.x,99)]; //40
//
// //           [window addSubview:adView];   //  onON  ON OFF   ?????????  CAUSES CRASH WHY ??????? 8/11
//            adView.hidden=YES;
//
//        }
//        else if (adLoadedAndReceived==YES) {
//            adView.hidden=NO;
//        }
//
//   //     [window bringSubviewToFront:adView]; // invalidate
//
//    }
}


@end
