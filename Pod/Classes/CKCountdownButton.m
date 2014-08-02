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
@property (strong, nonatomic) NSString *countingTitle;
@property (strong, nonatomic) NSString *normalTitle;
@property (strong, nonatomic) NSDate *countUntil;
@property (strong, nonatomic) UIColor *backgroundColorForDefault;
@property (nonatomic) BOOL counting;

@end

@implementation CKCountdownButton

# pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    self.startCountWhenClick = YES;
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
    self.backgroundColorForDefault = self.backgroundColor;

    // Change background color
    if (self.backgroundColorForDisabledState) {
        self.backgroundColor = self.backgroundColorForDisabledState;
    }

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

        // Restore background color
        if (self.backgroundColorForDisabledState) {
            self.backgroundColor = self.backgroundColorForDefault;
        }

        // Notify
        if (self.delegate) {
            [self.delegate countedDown:self];
        }
    } else {
        NSString *title = [self.countingTitle stringByReplacingOccurrencesOfString:PLACEHOLDER withString:[@(currentCount) stringValue]];
        [self setTitle:title forState:UIControlStateDisabled];
    }
}

- (void)onClick {

    if (!self.counting && self.startCountWhenClick) {
        self.count = self.count;
    }
}

- (void)dealloc {
    [self.clockTimer invalidate];
}

@end
