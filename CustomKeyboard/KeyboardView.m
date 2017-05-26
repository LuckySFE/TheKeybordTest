//
//  KeyboardView.m
//  CustomKeyboard
//
//  Created by HBB on 17/3/2.
//  Copyright © 2017年 HBB. All rights reserved.
//

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#import "KeyboardView.h"

@interface KeyboardView ()

@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *removeButton;
@property (nonatomic, strong) UIButton *pointButton;
@property (nonatomic, strong) UIButton *twoZeroButton;
@property (nonatomic, strong) UIButton *zeroButton;


@end


@implementation KeyboardView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAndAddSubviews];
    }
    return self;
}

- (instancetype)init{
    
    return [self initWithFrame:CGRectZero];
}

#pragma mark-
#pragma mark- Event response

- (void)pressKeyboardAciont:(UIButton *)sender{
    
    UIButton *button = sender;
    NSInteger tagValue = button.tag;
    
    if (!_delegate) {
        
        return;
    }
    
    if (tagValue >=0 && tagValue <=9) {
        if ([self.delegate respondsToSelector:@selector(didSelectedNumberOnKeyboard:)]) {
            
            [self.delegate didSelectedNumberOnKeyboard:tagValue];
        }
        
        return;
    }
    
    if (10 == tagValue) {
        
        if ([self.delegate respondsToSelector:@selector(didSelectedDeleteOnKeyboard)]) {
            
            [self.delegate didSelectedDeleteOnKeyboard];
        }
        return;
    }
    
    if (11 == tagValue) {
        
        if ([self.delegate respondsToSelector:@selector(didSelectedTwoZeroOnKeyboard:)]) {
            
            [self.delegate didSelectedTwoZeroOnKeyboard:@"00"];
        }
        return;
    }
    
    if (12 == tagValue) {
        
        if ([self.delegate respondsToSelector:@selector(didSelectedPointOnKeyboard)]) {
            
            [self.delegate didSelectedPointOnKeyboard];
        }
        return;
    }
    
    if (13 == tagValue) {
        
        if ([self.delegate respondsToSelector:@selector(didSelectedRemoveOnKeyboard)]) {
            
            [self.delegate didSelectedRemoveOnKeyboard];
        }
        return;
    }
    
}


#pragma mark-
#pragma mark- Private Methods

- (void)setUpAndAddSubviews{
    
    int space=1;
    for (int i=1; i<10; i++) {
        
        NSString *str=[NSString stringWithFormat:@"%d",i];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake((i-1)%3*(kScreenWidth/4)+space, (i-1)/3*60+(i+2)/3*space, kScreenWidth/4-1, 60);
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:24];
        [button setTitle:str forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(pressKeyboardAciont:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
    [self addSubview:self.zeroButton];
    [self addSubview:self.twoZeroButton];
    [self addSubview:self.removeButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.pointButton];
    
}



#pragma mark
#pragma mark --- Setters & Getters

- (UIButton *)zeroButton{
    
    if (!_zeroButton) {
        _zeroButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zeroButton.backgroundColor = [UIColor whiteColor];
        [_zeroButton setTitle:@"0" forState:UIControlStateNormal];
        [_zeroButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];        _zeroButton.frame = CGRectMake(kScreenWidth/4+1,60*3+4, kScreenWidth/4-1, 60);
        _zeroButton.titleLabel.font=[UIFont systemFontOfSize:24];
        [_zeroButton addTarget:self action:@selector(pressKeyboardAciont:) forControlEvents:UIControlEventTouchUpInside];
        _zeroButton.tag = 0;
    }
    
    return _zeroButton;
}

- (UIButton *)deleteButton{
    
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = [UIColor cyanColor];
        [_deleteButton setTitle:@"删 除" forState:UIControlStateNormal];
        [_deleteButton setTintColor:[UIColor blackColor]];
        _deleteButton.frame = CGRectMake(kScreenWidth/4*3+1,1, kScreenWidth/4-2, 121.5);
        _deleteButton.titleLabel.font=[UIFont systemFontOfSize:24];
        [_deleteButton addTarget:self action:@selector(pressKeyboardAciont:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.tag = 10;
    }
    
    return _deleteButton;
}

- (UIButton *)twoZeroButton{
    
    if (!_twoZeroButton) {
        _twoZeroButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoZeroButton.backgroundColor = [UIColor whiteColor];
        [_twoZeroButton setTitle:@"00" forState:UIControlStateNormal];
        [_twoZeroButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _twoZeroButton.frame = CGRectMake(1,60*3+4 , kScreenWidth/4-1, 60);
        _twoZeroButton.titleLabel.font=[UIFont systemFontOfSize:24];
        [_twoZeroButton addTarget:self action:@selector(pressKeyboardAciont:) forControlEvents:UIControlEventTouchUpInside];
        
        _twoZeroButton.tag = 11;
    }
    return _twoZeroButton;
}

- (UIButton *)pointButton{
    
    if (!_pointButton) {
        _pointButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pointButton.backgroundColor = [UIColor whiteColor];
        [_pointButton setTitle:@"." forState:UIControlStateNormal];
        [_pointButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];        _pointButton.frame = CGRectMake(kScreenWidth/4*2+1,60*3+4, kScreenWidth/4-1, 60);
        _pointButton.titleLabel.font=[UIFont systemFontOfSize:24];
        [_pointButton addTarget:self action:@selector(pressKeyboardAciont:) forControlEvents:UIControlEventTouchUpInside];
        
        _pointButton.tag = 12;
    }
    
    return _pointButton;
}


- (UIButton *)removeButton{
    
    if (!_removeButton) {
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeButton.backgroundColor = [UIColor yellowColor];
        [_removeButton setTitle:@"清 除" forState:UIControlStateNormal];
        [_removeButton setTintColor:[UIColor redColor]];
        _removeButton.frame = CGRectMake(kScreenWidth/4*3+1,122.5, kScreenWidth/4-2, 121.5);
        _removeButton.titleLabel.font=[UIFont systemFontOfSize:24];
        [_removeButton addTarget:self action:@selector(pressKeyboardAciont:) forControlEvents:UIControlEventTouchUpInside];
        _removeButton.tag = 13;
    }
    
    return _removeButton;
    
}

@end
