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
@property (nonatomic, assign) NSInteger currentCount;

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
    self.clockTimer = [NSTimer timerWithTimeInterval:1
                                              target:self
                                            selector:@selector(clockDidTick:)
                                            userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes];
    self.currentCount = self.count;
    self.originTitle = self.titleLabel.text;

    // Fallback if title is unset of does not contain PlaceholderString '%@'
    if(!self.originTitle || [self.originTitle rangeOfString:@"%%@"].location == NSNotFound) {
        self.originTitle = PLACEHOLDER;
    }

    [self updateDisplay];
}

# pragma mark - Private Functions

- (void)clockDidTick:(NSTimer *)timer {
    self.currentCount--;
//
//    if (self.countDirection == kCountDirectionDown) {
//        //Only setValue if the value passed is a positive number or 0
//        //Trying to pass negative value from subtracting two unsigned variables causes max unsigned long long to be passed
//        if (_startValue >= milliSecs) {
//            [self setValue:(_startValue - milliSecs)];
//        }
//    } else {
//        [self setValue:(_startValue + milliSecs)];
//    }
}

- (void)updateDisplay {
    self.titleLabel.text = [self.originTitle stringByReplacingOccurrencesOfString:PLACEHOLDER withString:[@(self.currentCount) stringValue]];
}

@end
