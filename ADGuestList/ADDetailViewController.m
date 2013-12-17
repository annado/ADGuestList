//
//  ADDetailViewController.m
//  ADGuestList
//
//  Created by Anna Do on 10/14/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import "ADDetailViewController.h"
#import "ADGuestItem.h"
#import "ADGuestStore.h"
#import "ADImageStore.h"

@interface ADDetailViewController ()

@end

@implementation ADDetailViewController
@synthesize guest;
@synthesize delegate;

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"ADDetailViewController" bundle:nil];
    if (self) {
        if (isNew) {
            [self createNavigationBar];
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];
    return nil;
}

- (void)createNavigationBar
{
    NSLog(@"Creating navigation bar for Detail popup");
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
    [self.navigationItem setRightBarButtonItem:doneItem];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setLeftBarButtonItem:cancelItem];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.875 green:0.88 blue:0.91 alpha:1]];

    // iOS7 fix for NavBar covering the view
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; // layout adjustements
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self populateFields];    
}

- (void)populateFields
{
    [firstNameField setText:guest.firstName];
    [lastNameField setText:guest.lastName];
    [tableField setText:guest.tableNumber];
    [imageView setImage:guest.getImage];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to guest
    [self saveChanges];
}

- (void)saveChanges
{
    [guest setFirstName:[firstNameField text]];
    [guest setLastName:lastNameField.text];
    [guest setTableNumber:tableField.text];
}

// Save new guest
- (void)save:(id)sender
{
    NSLog(@"Save");
    [self saveChanges];
    [self.delegate detailViewController:guest];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

// Cancel create new guest
- (void)cancel:(id)sender
{
    NSLog(@"Cancel");
    [self.delegate detailViewController:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setGuest:(ADGuestItem *)g
{
    guest = g;
    [self.navigationItem setTitle:[guest displayName]];
}

// Show image picker
- (IBAction)takePicture:(id)sender
{
    if (imagePickerPopover.isPopoverVisible) {
        [self clearPopover];
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // set image picker source
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // if there is a camera
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else { // otherwise use Photo Library
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    imagePicker.allowsEditing = YES;
    [imagePicker setDelegate:self];
    
    if ([self isOnIpad]) {
        // iPad
        imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [imagePickerPopover setDelegate:self];
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        // iPhone
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

// clear popover
- (void)clearPopover {
    [imagePickerPopover dismissPopoverAnimated:YES];
    imagePickerPopover = nil;
}

// Popover was dismissed
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed image picker popover");
    imagePickerPopover = nil;
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

// on photo selection
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [guest setImage:image];
    [imageView setImage:image];

    if ([self isOnIpad]) {
        [self clearPopover];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)isOnIpad
{
    return [UIDevice.currentDevice userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

