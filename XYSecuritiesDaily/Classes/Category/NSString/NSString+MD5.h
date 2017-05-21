//
//  NSString+MD5.h
//  SecuritiesDaily
//
//  Created by xiwang on 14-6-4.
//  Copyright (c) 2014年 xinwanghulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>//DES
@interface NSString (MD5)
- (NSString*)MD5Valude;
- (NSString*)md5;
- (NSString*)MD5;



- (NSString*)SHA1;
- (NSString*)sha1;


+ (NSString *) udid;
+ (NSString *) doCipher:(NSString *)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt;
+ (NSString *) encryptStr:(NSString *) str;
+ (NSString *) decryptStr:(NSString *) str;


#pragma mark Based64
+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;
@end
