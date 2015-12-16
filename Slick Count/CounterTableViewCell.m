//
//  CounterTableViewCell.m
//  Slick Count
//
//  Created by Jeff DeWitte on 11/21/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import "CounterTableViewCell.h"

@implementation CounterTableViewCell
@synthesize ip;

@synthesize nameLabel;
@synthesize countLabel;
@synthesize incButton;
@synthesize decButton;
@synthesize resetButton;
@synthesize editButton;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)decTap:(id)sender {
    [self.delegate cellButtonTapped:self withIndex:1];
}


- (IBAction)incTap:(id)sender {
    [self.delegate cellButtonTapped:self withIndex:2];
}

- (IBAction)resetTap:(id)sender {
    [self.delegate cellButtonTapped:self withIndex:3];
}
- (IBAction)editTap:(id)sender {
    [self.delegate cellButtonTapped:self withIndex:4];
}

@end
