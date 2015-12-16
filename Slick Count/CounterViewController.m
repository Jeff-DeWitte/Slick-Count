//
//  CounterViewController.m
//  Slick Count
//
//  Created by Jeff DeWitte on 11/21/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import "CounterViewController.h"
#import <CoreData/CoreData.h>
#import "NewCounterViewController.h"

@interface CounterViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *cellToEdit;
@end

@implementation CounterViewController
@synthesize counterListTableView;
@synthesize addBarButton;
@synthesize managedObjectContext;
@synthesize cellToEdit;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Counter"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"datecreated" ascending:YES]]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [self.fetchedResultsController setDelegate:self];
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@,", error, error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CounterTableViewCell *cell = (CounterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"counterCell" forIndexPath:indexPath];
    
    // Configure Table View Cell
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void)cellButtonTapped:(CounterTableViewCell *)sender withIndex:(int)buttonIndex{
    switch (buttonIndex) {
        case 1: //dec
            [self decrementAtIndexPath:sender.ip];
            
            break;
            
        case 2: //inc
            [self incrementAtIndexPath:sender.ip];
            break;
        
        case 3: //reset
            [self resetAtIndexPath:sender.ip];
            break;
        case 4:
            self.cellToEdit = sender.ip;
            [self performSegueWithIdentifier:@"listToEdit" sender:self];
            break;
        default:
            break;
    }
}

-(BOOL)updatedRecord{
    // Save Record
    NSError *error = nil;
    
    if ([self.managedObjectContext save:&error]) {
        return YES;
        
    } else {
        if (error) {
            NSLog(@"Unable to save record.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        return NO;
    }
}

-(void)decrementAtIndexPath:(NSIndexPath*)ip{
    CounterTableViewCell *cell = [self.counterListTableView cellForRowAtIndexPath:ip];
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:ip];
    int newcount = [[record valueForKey:@"count"] intValue];
    
    if (newcount > 0) {
        int dec = [[record valueForKey:@"decrement"] intValue];
        newcount -= dec;
        [record setValue:[NSNumber numberWithInt:newcount] forKey:@"count"];
    
        if([self updatedRecord]){
            cell.countLabel.text = [NSString stringWithFormat:@"%d", newcount];
        }
    }
}

-(void)incrementAtIndexPath:(NSIndexPath*)ip{
    CounterTableViewCell *cell = [self.counterListTableView cellForRowAtIndexPath:ip];
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:ip];
    int newcount = [[record valueForKey:@"count"] intValue];
    
    if (newcount < 999999) {
        int inc = [[record valueForKey:@"increment"] intValue];
        newcount += inc;
        [record setValue:[NSNumber numberWithInt:newcount] forKey:@"count"];
    
        if([self updatedRecord]){
            cell.countLabel.text = [NSString stringWithFormat:@"%d", newcount];
        }
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Count Limit Reached" message:@"Slick Count does not support count numbers larger than 999,999." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    
}

-(void)resetAtIndexPath:(NSIndexPath*)ip{
    CounterTableViewCell *cell = [self.counterListTableView cellForRowAtIndexPath:ip];
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:ip];
    
    [record setValue:[NSNumber numberWithInt:0] forKey:@"count"];
    
    if([self updatedRecord]){
        cell.countLabel.text = [NSString stringWithFormat:@"%d", 0];
    }
}


- (void)configureCell:(CounterTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    cell.ip = indexPath;
    
    // Fetch Record
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Update Cell
    NSDictionary *attributes = [(NSAttributedString *)cell.nameLabel.attributedText attributesAtIndex:0 effectiveRange:NULL];
   // [cell.nameLabel setText:[record valueForKey:@"title"]];
    cell.nameLabel.attributedText = [[NSAttributedString alloc] initWithString:[record valueForKey:@"title"] attributes:attributes];
    
    [cell.countLabel setText:[NSString stringWithFormat:@"%d", [[record valueForKey:@"count"] intValue]]];
    [cell.incButton setTitle:[NSString stringWithFormat:@"+%d", [[record valueForKey:@"increment"] intValue]] forState:UIControlStateNormal];
    [cell.decButton setTitle:[NSString stringWithFormat:@"-%d", [[record valueForKey:@"decrement"] intValue]] forState:UIControlStateNormal];
    
    [cell.incButton.titleLabel sizeToFit];
    [cell.decButton.titleLabel sizeToFit];
    
    [cell.nameLabel setAdjustsFontSizeToFitWidth:YES];
    [cell.countLabel setAdjustsFontSizeToFitWidth:YES];
    
    NSData *colorData = [record valueForKey:@"color"];
    UIColor *counterColor = (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    
   
    cell.decButton.fillColor = counterColor;
    cell.incButton.fillColor = counterColor;
    cell.nameLabel.textColor = counterColor;
    cell.countLabel.textColor = counterColor;
    cell.resetButton.fillColor = counterColor;
    cell.editButton.fillColor = counterColor;
    
    cell.contentView.layer.borderWidth = 4.0f;
    [cell.contentView.layer setBorderColor:counterColor.CGColor];
    
    [cell setBackgroundColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1.0]];
}

- (IBAction)addTap:(id)sender {
    [self performSegueWithIdentifier:@"listToAdd" sender:self];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.counterListTableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.counterListTableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.counterListTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.counterListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(CounterTableViewCell *)[self.counterListTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.counterListTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.counterListTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"listToAdd"]){
        // Obtain Reference to View Controller
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
         NewCounterViewController *vc = (NewCounterViewController *)[nc topViewController];
        // Configure View Controller
        [vc setManagedObjectContext:self.managedObjectContext];
        [vc setIsEditing:FALSE];
    }
    else if ([segue.identifier isEqualToString:@"listToEdit"]){
        // Obtain Reference to View Controller
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        NewCounterViewController *vc = (NewCounterViewController *)[nc topViewController];
        // Configure View Controller
        [vc setManagedObjectContext:self.managedObjectContext];
        [vc setIsEditing:TRUE];
        
        NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:self.cellToEdit];
        [vc setRecordToEdit:record];
        [self setCellToEdit:nil];
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue{
    NewCounterViewController *ncvc = (NewCounterViewController*)[segue sourceViewController];
    [ncvc createOrUpdate];
    [self.counterListTableView reloadData];
    
}


@end
