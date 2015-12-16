//
//  NewCounterViewController.m
//  Slick Count
//
//  Created by Jeff DeWitte on 11/22/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import "NewCounterViewController.h"

@interface NewCounterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *countField;
@property (weak, nonatomic) IBOutlet UITextField *incField;
@property (weak, nonatomic) IBOutlet UITextField *decField;
@property (weak, nonatomic) IBOutlet UICollectionView *BGColorCollection;
@property (weak, nonatomic) IBOutlet UIView *sampleCellView;
@property (nonatomic, strong) UIColor *currentCellColor;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation NewCounterViewController
@synthesize nameField;
@synthesize countField;
@synthesize incField;
@synthesize decField;
@synthesize BGColorCollection;
@synthesize sampleCellView;
@synthesize managedObjectContext;


@synthesize scrollView;
@synthesize contentView;
@synthesize saveButton;

@synthesize recordToEdit;

-(void)viewWillDisappear:(BOOL)animated{
    [self dismissKeyboard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (!self.isEditing) {
        [saveButton setEnabled:NO];
        self.incField.text = @"+1";
        self.decField.text = @"-1";
        [self setCellColor:[UIColor flatRedColor]];
        self.navigationItem.title = @"New Counter";
    }
    else{
        self.nameField.text = [self.recordToEdit valueForKey:@"title"];
        self.incField.text = [NSString stringWithFormat:@"+%d", [[self.recordToEdit valueForKey:@"increment"] intValue]];
        self.decField.text = [NSString stringWithFormat:@"-%d", [[self.recordToEdit valueForKey:@"decrement"] intValue]];
        self.countField.text = [NSString stringWithFormat:@"%d", [[self.recordToEdit valueForKey:@"count"] intValue]];
        NSData *colorData = [self.recordToEdit valueForKey:@"color"];
        UIColor *counterColor = (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        [self setCellColor:counterColor];
        self.navigationItem.title = @"Edit Counter";
    }
    
    
    self.decField.tag = 1;
    self.incField.tag = 2;
    self.nameField.tag = 3;
    self.countField.tag = 4;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.delegate = self;
    [tap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

- (IBAction)textChanged:(id)sender {
    if ([self.decField.text length] != 0 && [self.incField.text length] != 0 && [self.nameField.text length] != 0 && [self.countField.text length] != 0) {
        [self.saveButton setEnabled:YES];
    }
    else {
        [self.saveButton setEnabled:NO];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.BGColorCollection] && ([self.incField isFirstResponder] || [self.decField isFirstResponder] || [self.countField isFirstResponder] || [self.nameField isFirstResponder])) {
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}


- (IBAction)editingChanged {
    
}

-(void)dismissKeyboard{
    [self.nameField resignFirstResponder];
    [self.countField resignFirstResponder];
    [self.incField resignFirstResponder];
    [self.decField resignFirstResponder];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    if (textField.tag == 1) {
        
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    else if (textField.tag == 2) {
        
        textField.text = [textField.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
    }
}



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSMutableString* incDecWithSymbol = [NSMutableString stringWithString:textField.text];
    if (textField.tag == 1) { //dec
        [incDecWithSymbol insertString:@"-" atIndex:0];
        textField.text = [NSString stringWithString:incDecWithSymbol];
    }
    else if (textField.tag == 2){ //inc
        [incDecWithSymbol insertString:@"+" atIndex:0];
        textField.text = [NSString stringWithString:incDecWithSymbol];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(void)setCellColor:(UIColor*)cellColor{
    self.nameField.textColor = cellColor;
    self.nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.nameField.text attributes:@{NSForegroundColorAttributeName: cellColor}];
    self.nameField.layer.borderColor = cellColor.CGColor;
    
    self.countField.textColor = cellColor;
    self.countField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.nameField.text attributes:@{NSForegroundColorAttributeName: cellColor}];
    self.countField.layer.borderColor = cellColor.CGColor;
    
    self.incField.textColor = cellColor;
    self.incField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.nameField.text attributes:@{NSForegroundColorAttributeName: cellColor}];
    self.incField.layer.borderColor = cellColor.CGColor;
    
    self.decField.textColor = cellColor;
    self.decField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.nameField.text attributes:@{NSForegroundColorAttributeName: cellColor}];
    self.decField.layer.borderColor = cellColor.CGColor;
    
    self.sampleCellView.layer.borderWidth = 4.0f;
    self.sampleCellView.layer.borderColor = cellColor.CGColor;
    self.currentCellColor = cellColor;
    
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (NSIndexPath *ip in [self.BGColorCollection indexPathsForVisibleItems]) {
        [self customCellDeSelect:[self.BGColorCollection cellForItemAtIndexPath:ip]];
    }

    [self customCellSelect:[self.BGColorCollection cellForItemAtIndexPath:indexPath]];
    switch (indexPath.row
            ) {
        case 0:
            [self setCellColor:[UIColor flatRedColor]];
            break;
        case 1:
            [self setCellColor:[UIColor flatOrangeColor]];
            break;
        case 2:
            [self setCellColor:[UIColor flatGreenColor]];
            break;
        case 3:
            [self setCellColor:[UIColor flatBlueColor]];
            break;
        case 4:
            [self setCellColor:[UIColor flatPurpleColor]];
            break;
        default:
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
    
    switch (indexPath.row
            ) {
        case 0:
           [cell setBackgroundColor:[UIColor flatRedColor]];
            break;
        case 1:
            [cell setBackgroundColor:[UIColor flatOrangeColor]];
            break;
        case 2:
            [cell setBackgroundColor:[UIColor flatGreenColor]];
            break;
        case 3:
            [cell setBackgroundColor:[UIColor flatBlueColor]];
            break;
        case 4:
            [cell setBackgroundColor:[UIColor flatPurpleColor]];
            break;
        default:
            break;
    }
    
    if (self.isEditing) {
        NSData *colorData = [self.recordToEdit valueForKey:@"color"];
        NSData *backgroundColorData = [NSKeyedArchiver archivedDataWithRootObject:cell.backgroundColor];
        if ([colorData isEqualToData:backgroundColorData]) {
            [self customCellSelect:cell];
        }
    }
    else{
        if (indexPath.row == 0) {
            [self customCellSelect:cell];
        }
    }
    
    return cell;
}


-(void)customCellSelect:(UICollectionViewCell*)cell{
    cell.contentView.layer.borderColor = [UIColor flatWhiteColor].CGColor;
    cell.contentView.layer.borderWidth = 6.0f;
}

-(void)customCellDeSelect:(UICollectionViewCell*)cell{
    cell.contentView.layer.borderWidth = 0.0f;
}

- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createOrUpdate{
    NSString *incFieldText = [self.incField.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
    NSString * decFieldText = [self.decField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *name = self.nameField.text;
    NSString *countString = self.countField.text;
    NSNumber *count = [NSNumber numberWithInt:[countString intValue]];
    NSNumber *increment = [NSNumber numberWithInt:[incFieldText intValue]];
    NSNumber *decrement = [NSNumber numberWithInt:[decFieldText intValue]];
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:self.currentCellColor];
    if(name && name.length && countString && countString.length && increment>0 && decrement > 0) {
        // Create Entity
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Counter" inManagedObjectContext:self.managedObjectContext];
        
        
        if (!self.isEditing) {
            NSManagedObject *record = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
            [record setValue:[NSDate date] forKey:@"datecreated"];
            [record setValue:name forKey:@"title"];
            [record setValue:count forKey:@"count"];
            [record setValue:increment forKey:@"increment"];
            [record setValue:decrement forKey:@"decrement"];
            [record setValue:colorData forKey:@"color"];
        }
        else{
            [self.recordToEdit setValue:name forKey:@"title"];
            [recordToEdit setValue:count forKey:@"count"];
            [recordToEdit setValue:increment forKey:@"increment"];
            [recordToEdit setValue:decrement forKey:@"decrement"];
            [recordToEdit setValue:colorData forKey:@"color"];
        }
        
        
        
        
            
        NSError *error = nil;
        if ([self.managedObjectContext save:&error]) {
            // Dismiss View Controller
           // [self dismissViewControllerAnimated:YES completion:nil];
          //  [self performSegueWithIdentifier:@"backToList" sender:self];
            
        } else {
            if (error) {
                NSLog(@"Unable to save record.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            }
            
            // Show Alert View
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your counter could not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
    else{ //Should never get called.
        NSString *errorMessage = [self determineErrorMessageFromName:name andCount:countString andInc:increment andDec:decrement];
        [[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your counter could not be saved. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    
    
}

-(NSString*)determineErrorMessageFromName:(NSString*)name andCount:(NSString*)countString andInc:(NSNumber*)increment andDec:(NSNumber*)decrement{
    NSString* message = @"";
    
    if (!(name && name.length)) {
        message = @"Please enter a name for your counter.";
    }
    else if (!(countString && countString.length)){
        message = @"Please enter a value of 0 or greater for the starting count.";
    }
    else if(increment <= 0){
        message = @"Please enter a value of 1 or greater for the increment (+) button.";
    }
    else if(decrement <= 0){
        message = @"Please enter a value of 1 or greater for the decrement (-) button.";
    }
    else{
        message = @"An error occurred. Please correct any errors or missing information and try again.";
    }
    
    return message;
}
@end
