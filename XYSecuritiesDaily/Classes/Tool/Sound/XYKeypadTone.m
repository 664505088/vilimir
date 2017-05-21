//
//  XYKeypadTone.m
//  XYNAV
//
//  Created by farben on 14-1-7.
//  Copyright (c) 2014年 Shoo. All rights reserved.
//

#import "XYKeypadTone.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation XYKeypadTone


+ (void)keypadTone:(NSString*)name {
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
}


@end
