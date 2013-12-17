//
//  ADGuestStore.h
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADGuestItem;

@interface ADGuestStore : NSObject
{
    NSMutableArray *allItems;
}

- (NSInteger)count;
- (ADGuestItem *)createItem;
- (ADGuestItem *)createItem:firstName last:(NSString *)lastName table:(NSString *)table;
- (NSArray *)allItems;
+ (ADGuestStore *)sharedStore;
- (ADGuestItem *)getItemAtIndex:(NSInteger)index;
- (void)removeItemAtIndex:(NSInteger)index;
- (void)removeItem: (ADGuestItem *)p;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;

- (NSString *)itemArchivePath;
- (BOOL)saveChanges;
@end
