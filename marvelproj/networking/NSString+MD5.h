//
//  NSString+MD5.h
//  marvelproj
//
//  Created by Andre Nogueira on 09/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString(MD5)

    - (NSString *)generateMD5:(NSString *)input;
    
    @end
