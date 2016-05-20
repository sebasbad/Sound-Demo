//
//  ViewController.m
//  Sound Demo
//
//  Created by Sebastián Badea on 19/5/16.
//  Copyright © 2016 Sebastian Badea. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
}

- (IBAction)playSoundA:(id)sender {
}

- (IBAction)playSoundB:(id)sender {
}

@end
