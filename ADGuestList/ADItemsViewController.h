//
//  ADItemsViewController.h
//  ADGuestList
//
//  Created by Anna Do on 10/8/13.
//  Copyright (c) 2013 ADT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADDetailViewController.h"

@interface ADItemsViewController : UITableViewController <UITableViewDelegate, ADDetailViewControllerDelegate>
{
}
- (IBAction)addNewItem: (id)sender;
@end
