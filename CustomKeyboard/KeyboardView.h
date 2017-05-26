//
//  KeyboardView.h
//  CustomKeyboard
//
//  Created by HBB on 17/3/2.
//  Copyright © 2017年 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardDelegate <NSObject>

- (void)didSelectedNumberOnKeyboard:(NSInteger)number;
- (void)didSelectedTwoZeroOnKeyboard:(NSString *)twoZeroStr;
- (void)didSelectedRemoveOnKeyboard;
- (void)didSelectedDeleteOnKeyboard;
- (void)didSelectedPointOnKeyboard;

@end

@interface KeyboardView : UIView

@property (nonatomic, weak)id <KeyboardDelegate> delegate ;

@end

