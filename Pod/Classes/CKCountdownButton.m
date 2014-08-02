//
//  CountdownButton.m
//  Pods
//
//  Created by Quanlong He on 8/2/14.
//
//

#import "CKCountdownButton.h"

static NSString* PLACEHOLDER = @"#";

@interface CKCountdownButton() {

}

@property (strong, nonatomic) NSTimer *clockTimer;
@property (copy, nonatomic) NSString *countingTitle;
@property (copy, nonatomic) NSString *normalTitle;
@property (strong, nonatomic) NSDate *countUntil;
@property (nonatomic) BOOL counting;

@end

@implementation CKCountdownButton

# pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setCount:(NSInteger)count {
    if (self.counting) {
        NSLog(@"Warning: Cannot modify count while counting");
        return;
    }

    _count = count;

    self.counting = YES;

    // If the title For normal state is not set, iOS will use title from disabled state.
    self.normalTitle = self.titleLabel.text;

    self.enabled = NO;
    self.countUntil = [NSDate dateWithTimeIntervalSinceNow:_count];
    self.countingTitle = self.titleLabel.text;

    // Fallback if title is unset of does not contain PLACEHOLDER
    if(!self.countingTitle || [self.countingTitle rangeOfString:PLACEHOLDER].location == NSNotFound) {
        self.countingTitle = PLACEHOLDER;
    }

    [self updateDisplay];

    // Start timer
    self.clockTimer = [NSTimer timerWithTimeInterval:0.2
                                              target:self
                                            selector:@selector(clockDidTick:)
                                            userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes];
}

# pragma mark - Private Functions

- (void)clockDidTick:(NSTimer *)timer {

    [self updateDisplay];
}

- (void)updateDisplay {

    // Round up
    NSInteger currentCount = ceil([self.countUntil timeIntervalSinceDate:[NSDate date]]);

    if (currentCount <= 0) {
        self.counting = NO;

        self.enabled = YES;
        [self.clockTimer invalidate];

        if ([self.normalTitle length] == 0) {
            self.titleLabel.text = @"";
        }

        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidCountDown:)]) {
            [self.delegate buttonDidCountDown:self];
        }
    } else {
        NSString *title = [self.countingTitle stringByReplacingOccurrencesOfString:PLACEHOLDER withString:[@(currentCount) stringValue]];
        [self setTitle:title forState:UIControlStateDisabled];
    }
}

- (void)dealloc {
    [self.clockTimer invalidate];
}

@end
