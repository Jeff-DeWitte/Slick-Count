//
//  EditCounterTextField.m
//  Slick Count
//
//  Created by Jeff DeWitte on 12/16/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import "EditCounterTextField.h"
#import <ChameleonFramework/Chameleon.h>

@implementation EditCounterTextField
@synthesize fieldType; // 1 = title, 2 = count, 3 = inc/dec
@synthesize counterColor;


-(id)initWithCoder:(NSCoder *)aDecoder{ //called BEFORE IBInspectable is applied
    self = [super initWithCoder:aDecoder];
    
    return self;
}


- (void)drawRect:(CGRect)rect {
    
}

-(void)setup:(NSString*)theString{
    self.layer.borderWidth = 0.0f;
    self.layer.backgroundColor = self.counterColor.CGColor;
    NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theString];
  //  self.attributedText = [self fieldStringForText:theAttributedString andIsTyping:NO andIsPlaceholder:NO];
    self.attributedPlaceholder = [self fieldStringForText:theAttributedString andIsTyping:NO andIsPlaceholder:YES];
    
}

-(void)startedEditing{
    NSString *labelText = self.placeholder;
    // [cell.nameLabel setText:[record valueForKey:@"title"]];
    NSAttributedString *attributedLabelText = [self fieldStringForText:self.attributedText andIsTyping:YES andIsPlaceholder:NO];
    
    self.attributedText = attributedLabelText;
    
    self.layer.backgroundColor = [UIColor flatWhiteColor].CGColor;
    self.layer.borderColor = self.counterColor.CGColor;
    self.layer.borderWidth = 2.0f;
}
-(void)stoppedEditing{
    self.layer.borderWidth = 0.0f;
    self.layer.backgroundColor = self.counterColor.CGColor;
    
}

-(NSAttributedString*)fieldStringForText:(NSAttributedString*)fieldString andIsTyping:(BOOL)isTyping andIsPlaceholder:(BOOL)isPlaceHolder{
    
    int underline = 0;
    UIFont *font = [[UIFont alloc] init];
    
    if (isTyping) {
        underline = 1;
    }
    else if (isPlaceHolder) {
        underline = 1;
    }
    else{
        
    }
    
    switch (self.fieldType) {
        case 1: //title
            font = [UIFont systemFontOfSize:36];
            break;
        case 2: //count
            font = [UIFont systemFontOfSize:79];
            break;
        case 3: //inc/dec
            font = [UIFont systemFontOfSize:38];
            break;
        default:
            break;
    }
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    
    /*switch (self.fieldType) {
        case 1: //title
            
            break;
        case 2: //count
            
            break;
        case 3: //inc/dec
            
            break;
        default:
            break;
    }*/
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     font, NSFontAttributeName,
                                     underline, NSUnderlineStyleAttributeName,
                                     self.counterColor, NSUnderlineColorAttributeName,
                                     paragraphStyle, NSParagraphStyleAttributeName,
                                     nil];
    
    return fieldString;
}

- (void)awakeFromNib {//called AFTER IBInspectable is applied
    
}
@end
