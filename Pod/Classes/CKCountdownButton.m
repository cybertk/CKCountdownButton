//
//  CountdownButton.m
//  Pods
//
//  Created by Quanlong He on 8/2/14.
//
//

#import "CKCountdownButton.h"

static NSString* PLACEHOLDER = @"__CKCountdownButton__";

@interface CKCountdownButton() {

}

@property (strong, nonatomic) NSTimer *clockTimer;
@property (strong, nonatomic) NSString *originTitle;
@property (strong, nonatomic) NSDate *countUntil;

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
        // Initialization code
    }
    return self;
}

- (void)setCount:(NSInteger)count {
    _count = count;

    self.enabled = NO;
    self.countUntil = [NSDate dateWithTimeIntervalSinceNow:_count];
    self.originTitle = self.titleLabel.text;

    // Fallback if title is unset of does not contain PlaceholderString '%@'
    if(!self.originTitle || [self.originTitle rangeOfString:@"%%@"].location == NSNotFound) {
        self.originTitle = PLACEHOLDER;
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

    self.titleLabel.text = [self.originTitle stringByReplacingOccurrencesOfString:PLACEHOLDER withString:[@(currentCount) stringValue]];
}

- (void)dealloc {
    [self.clockTimer invalidate];
}

@end
