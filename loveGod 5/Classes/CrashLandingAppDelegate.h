/*
 
 File: CrashLandingAppDelegate.h
 Abstract: the UIApplication delegate class, which is the central controller of
 the application.
 
 Version: 1.8
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple Inc.
 ("Apple") in consideration of your agreement to the following terms, and your
 use, installation, modification or redistribution of this Apple software
 constitutes acceptance of these terms.  If you do not agree with these terms,
 please do not use, install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject
 to these terms, Apple grants you a personal, non-exclusive license, under
 Apple's copyrights in this original Apple software (the "Apple Software"), to
 use, reproduce, modify and redistribute the Apple Software, with or without
 modifications, in source and/or binary forms; provided that if you redistribute
 the Apple Software in its entirety and without modifications, you must retain
 this notice and the following text and disclaimers in all such redistributions
 of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may be used
 to endorse or promote products derived from the Apple Software without specific
 prior written permission from Apple.  Except as expressly stated in this notice,
 no other rights or licenses, express or implied, are granted by Apple herein,
 including but not limited to any patent rights that may be infringed by your
 derivative works or by other works in which the Apple Software may be
 incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
 WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
 WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
 COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR
 DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF
 CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF
 APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2008 Apple Inc. All Rights Reserved.
 
 */
//#import "FlurryAnalytics.h"
 

//#import "AdMobDelegateProtocol.h"
//#import "FacebookAgent.h"
#import <UIKit/UIKit.h>
#import "Texture2D.h"
//#import "Sound.h"

//#import "MKStoreManager.h"
//#import "SFHFKeychainUtils.h"

#import <iAd/iAd.h>
//#import "iAd/ADBannerView.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>
@class MyEAGLView;

@class AdMobView;


#define AD_REFRESH_PERIOD 50.0 // display fresh ads once per minute


// CONSTANTS 
#define kStripe						5
#define kBaseOffset					20
#define kBaseSize					100
#define kFontName					@"Verdana"
#define kFontName2					@"Zapfino"  //  -Bold
#define kStatusFontSize				104
#define kLabelFontSize				18
#define kScoreFontSize				58
#define kFuelBarX					312
#define kFuelBarY					225
#define kLabelY						455
#define kLightY						460
#define kSpeedX						20
#define kAngleX						120
#define kPositionX					220
#define kLabelOffset				40

#define kInitialVelocity			100   //Pixels/s  frame
#define kInitialFuel				440   //Seconds
#define kMass						80    //Kg
#define kGravity					40    //Pixels/s2
#define kMainThrustThreshold		-0.7050 //Accelerometer Y axis value (about 45 degrees angle)
#define kLateralThrustThreshold		0.02   //Accelerometer X axis value
#define kMainThrust					10000 //N
#define kRotationSpeed				100   //Degrees/s
#define kLateralSpeed				10    //Pixels/s

#define kMaxVelocity				705   //Pixels/s
#define kMaxRotation				280   //Degrees

#define kScoreVelocity				4000
#define kScoreFuel					2500
#define kScoreRotation				2000
#define kScoreDistance				1500

enum {
	kTexture_Title,
	kTexture_Star,// position
	tex,
	sparks,
	kTexture_Background,
	kTexture_Background2,
	kTexture_Clown,
	kTexture_Clowninv,
	kTexture_Stripe,
	kTexture_Stripeinv,
	kTexture_Green,
	kTexture_Greeninv,
	kTexture_Red,
	kTexture_Redinv,
	kTexture_Yellow,
	kTexture_Yellowinv,
	kTexture_Blue,
	kTexture_Blueinv,
	kTexture_Arrow,
	instrucText,
	instrucTitleText,
	timeUpText,
	kTexture_solid,
	kTexture_tex,
	//kTexture_verseWords[36],
	// HostBass1
	kTexture_praiseGod,
	kTexture_praiseGod2,
	kTexture_praiseGod3,
	kTexture_praiseGod4,
	kTexture_border,
	kTexture_Lander,
	kTexture_Base,
	kTexture_MainThrust,
	kTexture_LeftThrust,
	kTexture_RightThrust,
	kTexture_Explosion,
	kTexture_FuelBar,
	kTexture_FuelLevel,
	kTexture_LightGreen,
	kTexture_LightRed,
	kTexture_LabelSpeed,
	kTexture_LabelAngle,
	kTexture_LabelPosition,
	kTexture_BibleIcon,
	kTexture_Facebook,
	YouFailText,
	evangelText,
	tapToGoOnText,
	gameText,
	menuText,
	scoreText,
	timeText,
	twitText,
	fbText,
	titleText,
	optionsText,
	gameModeText,
	altgameModeText,
	alt2gameModeText,
	instructionsText,
	endWebOnBorderText,
	startText,
	gospelText,
	bannerText,
	mosaicText,
	supportText,
	emailText,
	siteText,
	piperText,
	marsText,
	tellFriendText,
	reviewText,
	resourcesText,
	resourcesTitleText,
	kNumTextures
};

enum {
	kSound_Thrust = 0,
	kSound_Start,
	kSound_Success,
	kSound_Failure,
	kNumSounds
};

typedef enum {
	kState_StandBy = 0,
	kState_Running,
	kState_Success,
	kState_Failure
} State;

// STRUCTURES
typedef struct
{
	GLfloat			x;
	GLfloat			y;
} Vector2D;

//CLASS INTERFACE
//@interface FacebookAgentTestViewController : UIViewController 
@interface CrashLandingAppDelegate : NSObject <UIApplicationDelegate, /*ADBannerViewDelegate,*/ UIAccelerometerDelegate, AVAudioPlayerDelegate, UIAlertViewDelegate, UITextFieldDelegate>
//,AdMobDelegate>
{
//	FacebookAgent* fbAgent;
//    MKStoreManager* 
	UIView *adContainer,*webContainer;
	UIView *borderInstrucView;
	UIWebView *webView;
	AdMobView *adMobAd;  // the actual ad; self.view is a placeholder to indicate where the ad should be placed; intentially _not_ an IBOutlet
	NSTimer *autoslider; // timer to slide in fresh ads
	//IBOutlet UIWindow *window;
    bool showAdBool,adLoaded,adTime,adLoadedAndReceived;
//    ADBannerView *adView;

	IBOutlet UIWindow		*window;
	IBOutlet MyEAGLView		*glView;
	/*
	 Sound *shake;
	 Sound *laser;
	 Sound *win;
	 Sound *win2;
	 
	 Sound *lose;
	 Sound *stung;
	 Sound *pick;
	 Sound *settle;
	 */
	int translation;
	AVAudioPlayer *sound1;
	AVAudioPlayer *sound2;
	AVAudioPlayer *sound3;
	AVAudioPlayer *sound4;
	AVAudioPlayer *sound5;
	AVAudioPlayer *sound6;
	AVAudioPlayer *sound7;
	AVAudioPlayer *sound8;
	
	UITextField*			_textField;
	
	Texture2D*				_textures[kNumTextures];
	Texture2D*				verseWords[36];
	Texture2D*				translationT2D;
	UInt32					_sounds[kNumSounds];
	
	CGRect					_landerBounds;
	UIAccelerationValue		_accelerometer[3];
	Texture2D*				_statusTexture;
	BOOL					isLoggedIn2,isLoggedIn,_firstTap,lite,christ,evangelState;
	
	NSTimer*				_timer;
	NSTimer*				_timer2;
	
	State					_state;
	CFTimeInterval			lasttime,thistime;
	BOOL					_lastThrust,arrowHighlightLeft,arrowHighlightRight;
	GLfloat					_basePosition;
	GLfloat					_rotation,
	_rotationVelocity;
	
	CGPoint startTouch,currentTouch;
	int levelct, wincounter,wincounter2,youWin,kClown,start,verse,randomNess, trueRandom,holderi,holderx,holdery,lastRowWords, youFail,score,group,altSounds;
	float action[136],red,green,blue;//						29
	
	CGPoint menupt,menuInstruc,gameModeXy, gospelXy,menuStart,menuOptions,touched,fb,email,site,words[136],wordsHome[136];
	float spun,spinning,qq,iii;//, dx[50],dy[50];
	bool flippedView,adReceived,internetIsAvailable,needToRunInternetCheck;
	bool extra2,pickedup,historyView,changedView,userTouchedScreenToContinue;
	bool allInOrder,menuState,instrucState,optionsState,gospelState,supportDevState,menuHighlighted;
	float biggerLetter,biggerAd,iiii;
	int verseCount, wordsPerRow, numRows, gameModeSelection,wordsHomeFull[136],empty,hover,holding,set[136][2], howManyOutOfOrder,howManyOutOfOrderLastTime,linkOptions;
	int charc,stringLength, first,menuoption,arnd,brnd,ii,seconds,kk,bigOut;
	NSMutableString *praise, *praiseFormatted,*chapVerseHolder;
	NSMutableString *book, *nBook, *chapVerse,*chap, *bookHolder;
	NSMutableArray *array,*texArray,*chapVerseArray;
	NSMutableString *urlAddress, *setApartVerse;
	UIApplication *application;

	
	float screen,pi,xcord,xStretch;
	bool internetState, dragged, change,pressed,pressedright,blockdown,gameover,themechanged,circlecolor,blockchange,blockchangego,onetime,scroll,fresh,firstGame,toggleSound,stayOptions,stayGospel, animationState,wordSwap, webViewState,touchDownInBibleIcon,touchDownInFB,touchDownInMenu;
	int typegame,theme,xtilt,chosenVerse;
	int makeLettersSmaller[136];
	float counterForRedBig;
	float makeShadowsLonger,counterFloat;
	int rnd,fontSizePad;
	//nextrnd, score0,fishtype[55],touchdown,eaten,clownleft,
	float counter;
	int holder,i,j,l,m,k,device,shadowLength[136],historicVerses;
	float counterInvert;
	CGRect				rect,rectSideways;// = [[UIScreen mainScreen] bounds];	
	
	unsigned				_score;
	float fadeIn,amplitude;
	BOOL firstLaunch,resourcesState, pulsar;
	
	CGPoint mosaic,piper,mars,tellFriend,review,resources,moveOut,twit;
	int hiScore,swapReady, swapReadyIndex, numInARow;
	
	UIWebView *myWebView;
	
	NSMutableString *myString;
}

@property (nonatomic, retain) AVAudioPlayer *sound1;
@property (nonatomic, retain) AVAudioPlayer *sound2;
@property (nonatomic, retain) AVAudioPlayer *sound3;
@property (nonatomic, retain) AVAudioPlayer *sound4;
@property (nonatomic, retain) AVAudioPlayer *sound5;
@property (nonatomic, retain) AVAudioPlayer *sound6;
@property (nonatomic, retain) AVAudioPlayer *sound7;
@property (nonatomic, retain) AVAudioPlayer *sound8;


- (void)handleTap:(CGPoint)touchpt;//(int)first;
- (void)handlebegan:(CGPoint)touches withEvent:(UIEvent *)event;
- (void)handleMoved:(CGPoint)currentT;

- (void)refreshAd:(NSTimer *)timer;

@end
