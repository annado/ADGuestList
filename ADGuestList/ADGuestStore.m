//
//  ADGuestStore.m
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import "ADGuestStore.h"
#import "ADGuestItem.h"
#import "ADImageStore.h"

@implementation ADGuestStore

+ (ADGuestStore *)sharedStore
{
    static ADGuestStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeItems];
    }
    return self;
}

- (void)initializeItems
{
    NSString *path = [self itemArchivePath];
    allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!allItems) {
        allItems = [[NSMutableArray alloc] init];
    }
}

- (NSArray *)allItems
{
    return allItems;
}

- (ADGuestItem *)createItem
{
    return [self createItem:@"" last:@"" table:@"0"];
}

- (ADGuestItem *)createItem:(NSString *)firstName
                       last:(NSString *)lastName
                      table:table
{
    ADGuestItem *item = [[ADGuestItem alloc] initWithName:firstName last:lastName table:table];
    
    NSLog(@"Created item with name: %@", item.lastName);
    [allItems addObject:item];
    return item;
}

- (int) count
{
    return allItems.count;
}

- (void)removeItem: (ADGuestItem *)p
{
    NSString *key = [p imageKey];
    [ADImageStore.sharedStore deleteImageForKey:key];
    [allItems removeObjectIdenticalTo:p];
}

- (ADGuestItem *)getItemAtIndex:(NSInteger)index
{
    return [allItems objectAtIndex:index];
}

- (void)removeItemAtIndex:(NSInteger)index
{
    ADGuestItem *p = [allItems objectAtIndex:index];
    [ADGuestStore.sharedStore removeItem:p];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    ADGuestItem *g = [allItems objectAtIndex:from];
    
    // Remove from array
    [allItems removeObjectAtIndex:from];

    [allItems insertObject:g atIndex:to];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:allItems toFile:path];
}
@end
