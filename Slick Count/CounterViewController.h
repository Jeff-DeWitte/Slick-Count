//
//  CounterViewController.h
//  Slick Count
//
//  Created by Jeff DeWitte on 11/21/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CounterTableViewCell.h"

@interface CounterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, counterCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *counterListTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButton;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
