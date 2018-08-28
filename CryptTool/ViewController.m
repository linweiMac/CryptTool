//
//  ViewController.m
//  CryptTool
//
//  Created by EmberWei on 2018/8/28.
//  Copyright © 2018年 EmberWei. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import "LWCryptorTool.h"

@interface ViewController()
@property (unsafe_unretained) IBOutlet NSTextView *tvInput;
@property (weak) IBOutlet NSTextField *tfKey;
@end

@implementation ViewController


// 加密
- (IBAction)onPressTrim:(id)sender {
    self.tvInput.string = [LWCryptorTool trim:self.tvInput.string];
}

- (IBAction)onPressBase64:(id)sender {
    self.tvInput.string = [LWCryptorTool Base64Encrypt:self.tvInput.string];
}

- (IBAction)onPressDes:(id)sender {
    self.tvInput.string = [LWCryptorTool DESEncrypt:self.tvInput.string key:self.tfKey.stringValue];
}

- (IBAction)onPressAES:(id)sender {
    self.tvInput.string = [LWCryptorTool AESEncrypt:self.tvInput.string key:self.tfKey.stringValue];
}

// 解密
- (IBAction)onPressAESRevert:(id)sender {
    self.tvInput.string = [LWCryptorTool AESDecrypt:self.tvInput.string key:self.tfKey.stringValue];
}

- (IBAction)onPressDesRevert:(id)sender {
    self.tvInput.string = [LWCryptorTool DESDecrypt:self.tvInput.string key:self.tfKey.stringValue];
}

- (IBAction)onPressBase64Revert:(id)sender {
    self.tvInput.string = [LWCryptorTool Base64Decrypt:self.tvInput.string];
}

// 秘钥加密
- (IBAction)onPressMd5:(id)sender {
    self.tfKey.stringValue  =  [LWCryptorTool Md5Big32:self.tfKey.stringValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tfKey.stringValue = @"liyimeng0926";
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)goEncrypt:(id)sender {
    NSString *str   = self.tvInput.string;
    NSString *key   = self.tfKey.stringValue;
    
    // 两次 MD5 加密
    key = [LWCryptorTool Md5Big32Twice:key];
    
    str = [LWCryptorTool trim:str];
    str = [LWCryptorTool Base64Encrypt:str];
    str = [LWCryptorTool DESEncrypt:str key:key];
    str = [LWCryptorTool AESEncrypt:str key:key];
    
    self.tfKey.stringValue = key;
    self.tvInput.string = str;
}

- (IBAction)goDecrypt:(id)sender {
    NSString *str   = self.tvInput.string;
    NSString *key   = self.tfKey.stringValue;
    str = [LWCryptorTool AESDecrypt:str key:key];
    str = [LWCryptorTool DESDecrypt:str key:key];
    str = [LWCryptorTool Base64Decrypt:str];
    self.tvInput.string = str;
}



@end
