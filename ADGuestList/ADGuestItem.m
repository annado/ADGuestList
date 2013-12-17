//
//  ADGuestItem.m
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import "ADGuestItem.h"
#import "ADImageStore.h"

@implementation ADGuestItem

@synthesize firstName;
@synthesize lastName;
@synthesize tableNumber;
@synthesize imageKey;

- (id)initWithName:first last:last table:table
{
    self = [super init];
    if (self) {
        firstName = first;
        lastName = last;
        tableNumber = table;
        
        NSLog(@"Name: %@ %@", firstName, lastName);
    }
    return self;

}

- (NSString *)displayLastFirstName
{
    return [NSString stringWithFormat:@"%@, %@", lastName, firstName];
}

- (NSString *)displayName
{
    return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}

- (NSString *)detailLabel
{
    return [NSString stringWithFormat:@"table %@", tableNumber];
}
- (void)setImage:(UIImage *)image
{
    [self deleteImage]; // delete any existing image
    
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [self setImageKey:key];
    [ADImageStore.sharedStore setImage:image forKey:self.imageKey];
    
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
}

- (UIImage *)getImage
{
    UIImage *image = nil;
    if (imageKey) {
        image = [ADImageStore.sharedStore imageForKey:imageKey];
    }
    return image;
}

- (void)deleteImage
{
    if (imageKey) {
        [ADImageStore.sharedStore deleteImageForKey:imageKey];
        imageKey = nil;
    }
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setFirstName:[aDecoder decodeObjectForKey:@"firstName"]];
        [self setLastName:[aDecoder decodeObjectForKey:@"lastName"]];
        [self setTableNumber:[aDecoder decodeObjectForKey:@"tableNumber"]];
        [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSLog(@"ADGuestItem: encodeWithCoder");
    [aCoder encodeObject:firstName forKey:@"firstName"];
    [aCoder encodeObject:lastName forKey:@"lastName"];
    [aCoder encodeObject:tableNumber forKey:@"tableNumber"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
}

@end
