//
//  CountdownButton.m
//  Pods
//
//  Created by Quanlong He on 8/2/14.
//
//

#import "CKCountdownButton.h"

@implementation CKCountdownButton

# pragma - MARK Initializers

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
}

@end
