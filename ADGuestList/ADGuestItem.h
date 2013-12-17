//
//  ADGuestItem.h
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADGuestItem : NSObject <NSCoding>
{
}
@property (nonatomic) NSString * firstName;
@property (nonatomic) NSString * lastName;
@property (nonatomic) NSString * tableNumber;
@property (nonatomic) NSDate * dateCreated;
@property (nonatomic, copy) NSString *imageKey;

- (id)initWithName:firstName last:lastName table:table;
- (NSString *)displayLastFirstName;
- (NSString *)displayName;
- (NSString *)detailLabel;
- (void)setImage:(UIImage *)image;
- (UIImage *)getImage;
- (void)deleteImage;
@end
