//
//  ADItemsViewController.m
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import "ADItemsViewController.h"
#import "ADGuestStore.h"
#import "ADGuestItem.h"

@implementation ADItemsViewController

- (id) init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [[ADGuestStore sharedStore] createItem:@"Anna" last:@"Do" table:@"1"];
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"My Guest List"];
        
        // Create new button bar item
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        [self.navigationItem setRightBarButtonItem:bbi];
        [self.navigationItem setLeftBarButtonItem:self.editButtonItem];
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle) style
{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

// Adding new items
- (IBAction)addNewItem:(id)sender
{
    NSLog(@"addNewItem!");
    
    ADDetailViewController *detailViewController = [[ADDetailViewController alloc] initForNewItem:YES];
    ADGuestItem *newGuest = [ADGuestStore.sharedStore createItem];
    [detailViewController setGuest:newGuest];
    detailViewController.delegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self setDefinesPresentationContext:YES];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate methods
// Fill table cells
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    
    ADGuestItem *g = [[ADGuestStore sharedStore] getItemAtIndex:indexPath.row];
    [cell.textLabel setText:g.displayLastFirstName];
    [cell.detailTextLabel setText:g.detailLabel];
    return cell;
}

// Return number of rows
- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [[ADGuestStore sharedStore] count];
}

// Commit Editing Style
- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove from GuestStore
        [ADGuestStore.sharedStore removeItemAtIndex:indexPath.row];
        
        // Remove from UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Delete button text
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

// Reordering items
- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [ADGuestStore.sharedStore moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

// Table row selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ADDetailViewController *detailViewController = [[ADDetailViewController alloc] initForNewItem:NO];
    NSArray *items = ADGuestStore.sharedStore.allItems;
    ADGuestItem *selectedGuest = [items objectAtIndex:indexPath.row];
    
    [detailViewController setGuest:selectedGuest];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - ADDetailViewControllerDelegate method
- (void)detailViewController:(ADGuestItem *)guest;
{
    if (guest) {
        [self.tableView reloadData];
    } else {
        [ADGuestStore.sharedStore removeItem:guest];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
