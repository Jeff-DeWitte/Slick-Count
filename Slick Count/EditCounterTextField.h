//
//  EditCounterTextField.h
//  Slick Count
//
//  Created by Jeff DeWitte on 12/16/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface EditCounterTextField : UITextField
@property (nonatomic) IBInspectable NSInteger fieldType;

@property (nonatomic) IBInspectable UIColor* counterColor;
-(void)startedEditing;
-(void)stoppedEditing;
-(void)setup:(NSString*)theString;
@end
