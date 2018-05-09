//
//  NSString+MD5.m
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//  NSString+MD5.m
//
//  Created by Sean Nieuwoudt on 2013/07/19.
//  Copyright (c) 2013 Wixel. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)
    
    - (NSString *)generateMD5:(NSString *)input{
        const char *cStr = [input UTF8String];
        unsigned char digest[16];
        CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
        
        return output;
    }
    @end

