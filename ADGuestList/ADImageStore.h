//
//  ADImageStore.h
//  ADGuestList
//
//  Created by Anna Do on 10/15/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}
+ (ADImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;
- (NSString *)imagePathForKey:(NSString *)key;
@end
