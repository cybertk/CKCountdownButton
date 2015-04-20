//
//  CountdownButton.m
//  Pods
//
//  Created by Quanlong He on 8/2/14.
//
//

#import "CKCountdownButton.h"

static NSString* PLACEHOLDER = @"#";

@interface CKCountdownButton()

@property (strong, nonatomic) NSTimer *clockTimer;
@property (copy, nonatomic) NSString *countingTitle;
@property (copy, nonatomic) NSString *titleForNormal;
@property (copy, nonatomic) NSString *titleForDisabled;
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

    self.enabled = NO;
    self.counting = YES;

    self.titleForNormal = [self titleForState:UIControlStateNormal];
    self.titleForDisabled = [self titleForState:UIControlStateDisabled];

    self.countUntil = [NSDate dateWithTimeIntervalSinceNow:_count];
    self.countingTitle = self.titleForDisabled;
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

        // Restore title disabled and normal state
        if (self.state == UIControlStateNormal)
        {
            self.titleLabel.text = self.titleForNormal;
        }
        else if(self.state == UIControlStateDisabled)
        {
            self.titleLabel.text = self.titleForDisabled;
        }
        [self setTitle:self.titleForNormal forState:UIControlStateNormal];
        [self setTitle:self.titleForDisabled forState:UIControlStateDisabled];

        // [self setTitle:nil forState:UIControlStateNormal] can not clear title
        if ([self.titleForNormal length] == 0) {
            self.titleLabel.text = @"";
        }

        // Restore background color
        if (self.backgroundColorForDisabledState) {
            self.backgroundColor = self.backgroundColorForDefault;
        }

        // Notify
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonDidCountDown:)]) {
            [self.delegate buttonDidCountDown:self];
        }
    } else {
        NSString *title = [self.countingTitle stringByReplacingOccurrencesOfString:PLACEHOLDER withString:[@(currentCount) stringValue]];
        self.titleLabel.text = title;
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
