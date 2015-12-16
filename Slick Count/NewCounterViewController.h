//
//  NewCounterViewController.h
//  Slick Count
//
//  Created by Jeff DeWitte on 11/22/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountChangeButton.h"
#import <Coredata/Coredata.h>
#import <ChameleonFramework/Chameleon.h>

@interface NewCounterViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIGestureRecognizerDelegate>


- (IBAction)cancelTap:(id)sender;
- (void)createOrUpdate;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) BOOL isEditing;
@property (strong, nonatomic) NSManagedObject *recordToEdit;
@end
