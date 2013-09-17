//
//  Utilities.h
//  TRON
//
//  Created by Wu Ming on 8/19/11.
//  Copyright 2011 MMU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Utilities : NSObject {

}
+ (NSString *) returnMD5Hash:(NSString*)concat;
@end
