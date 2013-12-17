//
//  ADDetailViewController.h
//  ADGuestList
//
//  Created by Anna Do on 10/14/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADGuestItem;

@protocol ADDetailViewControllerDelegate <NSObject>
- (void)detailViewController:(ADGuestItem *)guest;
@end

@interface ADDetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
{
    __weak IBOutlet UITextField *firstNameField;
    __weak IBOutlet UITextField *lastNameField;
    __weak IBOutlet UITextField *tableField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    
    UIPopoverController *imagePickerPopover;
    
    // Delegate
    id <ADDetailViewControllerDelegate> _delegate;
}

@property (nonatomic,strong) id delegate;
@property (nonatomic, strong) ADGuestItem *guest;

- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (id)initForNewItem:(BOOL)isNew;
@end
