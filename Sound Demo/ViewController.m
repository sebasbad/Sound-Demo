//
//  ViewController.m
//  Sound Demo
//
//  Created by Sebastián Badea on 19/5/16.
//  Copyright © 2016 Sebastian Badea. All rights reserved.
//

@import AudioToolbox;
@import AVFoundation.AVAudioPlayer;
#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) SystemSoundID beepHightone;
@property (assign, nonatomic) SystemSoundID beepAttention;

@property (strong, nonatomic) AVAudioPlayer *player;

@property (assign, nonatomic) BOOL beepHightoneGood;
@property (assign, nonatomic) BOOL beepAttentionGood;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Load the sound / create the sound ID
    NSString *beepHightonePath = [[NSBundle mainBundle] pathForResource:@"beep-hightone" ofType:@"aif"];
    NSURL *beepHightoneUrl = [NSURL fileURLWithPath:beepHightonePath];
    
    NSString *beepAttentionPath = [[NSBundle mainBundle] pathForResource:@"beep-attention" ofType:@"aif"];
    NSURL *beepAttentionUrl = [NSURL fileURLWithPath:beepAttentionPath];
    
    NSString *songPath = [[NSBundle mainBundle] pathForResource:@"Allegro from Duet in C Major" ofType:@"mp3"];
    NSURL *songUrl = [NSURL fileURLWithPath:songPath];
    
    // Archaic C code
    // __bridge = C-level cast
    // Tells ARC to stop taking notice of casted object
    // Casting -> Don't generate ARC meta data
    OSStatus beepHightoneOSStatus = AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepHightoneUrl, &_beepHightone);
    
    if (kAudioServicesNoError == beepHightoneOSStatus) {
        self.beepHightoneGood = YES;
    } else {
        self.beepHightoneGood = NO;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Couldn't load beep-hightone" message:@"beep-hightone problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    OSStatus beepAttentionOSStatus = AudioServicesCreateSystemSoundID((__bridge CFURLRef)beepAttentionUrl, &_beepAttention);
    
    if (kAudioServicesNoError == beepAttentionOSStatus) {
        self.beepAttentionGood = YES;
    } else {
        self.beepAttentionGood = NO;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Couldn't load beep-attention" message:@"beep-attention problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    NSError *error;
    
    // Set up AVAudioPlayer
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:songUrl error:&error];
    
    if (!self.player) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Couldn't load the mp3" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (IBAction)playSoundA:(id)sender {
    if (self.beepHightone) {
        AudioServicesPlaySystemSound(self.beepHightone);
    }
}

- (IBAction)playSoundB:(id)sender {
    if (self.beepAttention) {
        AudioServicesPlaySystemSound(self.beepAttention);
    }
}

- (IBAction)playMedia:(id)sender {
}

- (IBAction)stopMedia:(id)sender {
}


- (void)dealloc {
    if (self.beepHightoneGood) {
        AudioServicesDisposeSystemSoundID(self.beepHightone);
    }
    
    if (self.beepAttention) {
        AudioServicesDisposeSystemSoundID(self.beepAttention);
    }
}

@end
