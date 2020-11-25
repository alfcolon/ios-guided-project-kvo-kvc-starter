//
//  ViewController.m
//  StopWatchDemo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIStopWatch.h"


// TODO: Create a KVOContext to identify the StopWatch observer
// A KVOContect is just an address in memory to nothing in particular with the value being the address itself. It might look something like this if you were to print it out: 23198830129384109283
// static makes this only available in this file
static void *KVOContext = &KVOContext;


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic) LSIStopWatch *stopwatch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stopwatch = [[LSIStopWatch alloc] init];
	[self.timeLabel setFont:[UIFont monospacedDigitSystemFontOfSize: self.timeLabel.font.pointSize  weight:UIFontWeightMedium]];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self.stopwatch reset];
}

- (IBAction)startStopButtonPressed:(id)sender {
    if (self.stopwatch.isRunning) {
        [self.stopwatch stop];
    } else {
        [self.stopwatch start];
    }
}

- (void)updateViews {
    if (self.stopwatch.isRunning) {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    self.resetButton.enabled = self.stopwatch.elapsedTime > 0;
    
    self.timeLabel.text = [self stringFromTimeInterval:self.stopwatch.elapsedTime];
}


- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger timeIntervalAsInt = (NSInteger)interval;
    NSInteger tenths = (NSInteger)((interval - floor(interval)) * 10);
    NSInteger seconds = timeIntervalAsInt % 60;
    NSInteger minutes = (timeIntervalAsInt / 60) % 60;
    NSInteger hours = (timeIntervalAsInt / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%ld", (long)hours, (long)minutes, (long)seconds, (long)tenths];
}

- (void)setStopwatch:(LSIStopWatch *)stopwatch {
    
    if (stopwatch != _stopwatch) {
        
        // willSet
		// TODO: Cleanup KVO - Remove Observers
        [_stopwatch removeObserver:self forKeyPath:@"running" context:KVOContext];
        [_stopwatch removeObserver:self forKeyPath:@"elapsedTime" context:KVOContext];

        _stopwatch = stopwatch;
        
        // didSet
		// TODO: Setup KVO - Add Observers
        
        //NSKeyValueIbservingOptionInitial means we will get every single change to 'running' including its initial value
        
        // In giving the context a value that we specift, we can distinguish observed values that WE care about, as opposed to values the iOS cares about and it is also obsrving.
        
        [_stopwatch addObserver:self
                     forKeyPath:@"running"
                        options:NSKeyValueObservingOptionInitial
                        context:KVOContext];
        [_stopwatch addObserver:self
                     forKeyPath:@"elapsedTime"
                        options:NSKeyValueObservingOptionInitial
                        context:KVOContext];
    }
    
}

// Overriding this function
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        // We know that this is a change that we want to observe.
        [self updateViews];
        
    } else {
        // This is some other change that iOS or some superclass wants to observe. We donb;t care about it, so just forward it up to the next superclass.
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// TODO: Review docs and implement observerValueForKeyPath


- (void)dealloc {
	// TODO: Stop observing KVO (otherwise it will crash randomly)
    
}

@end
