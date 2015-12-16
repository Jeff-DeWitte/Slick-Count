//
//  CounterTableViewCell.h
//  Slick Count
//
//  Created by Jeff DeWitte on 11/21/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountChangeButton.h"

@protocol counterCellDelegate;


@interface CounterTableViewCell : UITableViewCell
@property (nonatomic, assign) id<counterCellDelegate> delegate;

@property (strong) NSIndexPath *ip;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet CountChangeButton *incButton;
@property (weak, nonatomic) IBOutlet CountChangeButton *decButton;
@property (weak, nonatomic) IBOutlet CountChangeButton *resetButton;
@property (weak, nonatomic) IBOutlet CountChangeButton *editButton;



- (IBAction)resetTap:(id)sender;
- (IBAction)incTap:(id)sender;
- (IBAction)decTap:(id)sender;
- (IBAction)editTap:(id)sender;


@end

@protocol counterCellDelegate <NSObject>
-(void)cellButtonTapped:(CounterTableViewCell*)sender withIndex:(int)buttonIndex;
@end