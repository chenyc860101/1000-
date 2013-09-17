//
//  Utilities.m
//  TRON
//
//  Created by Wu Ming on 8/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import "Utilities.h"


@implementation Utilities

+ (NSString *) returnMD5Hash:(NSString*)concat {
    const char *concat_str = [concat UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
	
}
@end
