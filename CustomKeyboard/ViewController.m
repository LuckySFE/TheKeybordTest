//
//  ViewController.m
//  CustomKeyboard
//
//  Created by HBB on 17/3/2.
//  Copyright © 2017年 HBB. All rights reserved.
//

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "KeyboardView.h"

@interface ViewController ()<KeyboardDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    KeyboardView *keyboardView = [KeyboardView new];
    keyboardView.delegate = self;
    [self.view addSubview:self.textField];
//    [self.view addSubview:keyboardView];// 不能加,加了就错
    keyboardView.frame=CGRectMake(0, kScreenHeight-245, kScreenWidth, 245);
    keyboardView.backgroundColor = [UIColor redColor];
    self.textField.inputView = keyboardView;
//    [self.textField reg]
////    [self.textField reloadInputViews];
    [self.textField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark-
#pragma mark--- UITextFieldDelegate

// 随键盘上升而上升
- (void)textFieldDidBeginEditing:(UITextField *)textField{
   
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.textField.frame;
        frame.origin.y = kScreenHeight - 310;
        self.textField.frame = frame;
    }];

}


// 随键盘下降而下降
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = self.textField.frame;
        frame.origin.y = kScreenHeight - 200;
        self.textField.frame = frame;
    }];
    
    if ([textField.text characterAtIndex:self.textField.text.length -1] == '.') {
        
        self.textField.text = [NSString stringWithFormat:@"%@0",self.textField.text];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 100) {
   
    if (([string isEqualToString:@"0"] || [string isEqualToString:@"00"] || [string isEqualToString:@"."]) && textField.text.length == 0) {
        
        return NO;
    }
        
        // 保留两位小数
        if (textField.text.length != 0  && [textField.text containsString:@"."] && (textField.text.length - [textField.text rangeOfString:@"."].location > 2) && string.length) {
            
            return  NO;
        }
        // 六位数
        if (textField.text.length > 6) {
            
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    return YES;
}

- (void)textFieldChange:(UITextField *)sender{
    if(_textField.tag == 100){
    _textField = sender;
    
    if ([_textField.text isEqualToString:@"0"] || [_textField.text isEqualToString:@"00"] || [_textField.text isEqualToString:@"."]) {
        
        _textField.text = @"";
    }
    
    }
}


#pragma mark-
#pragma mark--- KeyboardDelegate
- (void)didSelectedNumberOnKeyboard:(NSInteger)number{
    
    NSString *textStr = self.textField.text;
    self.textField.text = [NSString stringWithFormat:@"%@%ld",textStr,number];
}


- (void)didSelectedTwoZeroOnKeyboard:(NSString *)twoZeroStr{
    
    NSString *textStr = self.textField.text;
    self.textField.text = [NSString stringWithFormat:@"%@%@",textStr,twoZeroStr];

    
    
}


- (void)didSelectedDeleteOnKeyboard{
    
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:self.textField.text];
    if (mutableStr.length <= 0) {
        
        return;
    }
    
    [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length-1, 1)];
    self.textField.text = mutableStr;
    
}


- (void)didSelectedPointOnKeyboard{
    
    // 第一位不能输入"."
    if (self.textField.text.length == 0) {
        return;
    }
    
    // 含有"."不能输入
    if ([self.textField.text rangeOfString:@"."].location != NSNotFound) {
        return;
    }
    
    self.textField.text = [NSString stringWithFormat:@"%@%@",self.textField.text,@"."];
    
}

- (void)didSelectedRemoveOnKeyboard{
   
    self.textField.text = @"";
    
}


#pragma mark-
#pragma mark--- Setters & Getters

- (UITextField *)textField{
    
    if (!_textField) {
        _textField = [UITextField new];
        _textField.frame = CGRectMake(50,kScreenHeight - 200, kScreenWidth-100, 50);
        _textField.backgroundColor = [UIColor cyanColor];
        _textField.placeholder = @"请输入内容";
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [_textField sendActionsForControlEvents:UIControlEventTouchUpInside];
        _textField.tag = 100;
        _textField.delegate = self;
    }
    
    return _textField;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
