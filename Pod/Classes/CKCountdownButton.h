//
//  CountdownButton.h
//  Pods
//
//  Created by Quanlong He on 8/2/14.
//
//

#import <UIKit/UIKit.h>

@protocol CKCountdownButtonDelegate;

@interface CKCountdownButton : UIButton

// Set this property will trigger the countdown timer start
@property(nonatomic) NSInteger count;

// defaults to nil
@property(nonatomic, weak) id<CKCountdownButtonDelegate> delegate;

// defautls to nil, the background color used while counting
@property (strong, nonatomic) UIColor *backgroundColorForDisabledState;

// defaults to YES, start counting when click the button
@property(nonatomic) BOOL startCountWhenClick;

/**
 *  添加终止计时器时钟的方法
 */
- (void)stopClockTimer;

@end


@protocol CKCountdownButtonDelegate <NSObject>

@optional

// Called when timer counted down
- (void)buttonDidCountDown:(CKCountdownButton *)button;

@end
