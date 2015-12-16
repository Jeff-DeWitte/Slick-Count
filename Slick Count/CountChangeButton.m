//
//  CountChangeButton.m
//  Slick Count
//
//  Created by Jeff DeWitte on 11/21/15.
//  Copyright © 2015 AFP. All rights reserved.
//

#import "CountChangeButton.h"
#include <QuartzCore/QuartzCore.h>

@implementation CountChangeButton

@synthesize fillColor;
@synthesize isAddButton;

-(id)initWithCoder:(NSCoder *)aDecoder{ //called BEFORE IBInspectable is applied
    self = [super initWithCoder:aDecoder];
    self.fillColor = [UIColor blackColor];
    self.isAddButton = false;
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.clipsToBounds = YES;
    return self;
}

/*-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat valueWidth = self.bounds.size.width*0.5;
    CGFloat valueHeight = self.bounds.size.height*0.5;
    
    CGFloat valueX =  self.bounds.size.width/2 - valueWidth/2;
    CGFloat valueY = self.bounds.size.height/2 - valueHeight/1.85 +0.5;
    
    return CGRectMake(valueX, valueY, valueWidth, valueHeight);
}*/
- (void)awakeFromNib {//called AFTER IBInspectable is applied
    [self setupTitle];
}


-(void)setupTitle{
    
    
    
    //valueLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.titleLabel.numberOfLines = 1;
    
    [self.titleLabel setAdjustsFontSizeToFitWidth:YES];
    self.titleLabel.textColor = [UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1.0];
    //self.titleLabel.text = @"1";
    //self.titleLabel.layer.borderColor = [UIColor whiteColor].CGColor;
   // self.titleLabel.layer.borderWidth = 1.0f;
    
    
 //   [self setNeedsLayout];
    
   // [self layoutIfNeeded];
    
    
}

-(void)drawRect:(CGRect)rect{ //called AFTER IBInspectable is applied
    
    [self circleShape:rect];
   
    
}

-(void)circleShape:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [fillColor setFill];
    [path fill];
}

/*-(void)drawMinusLine:(CGRect)rect{
    
    CGFloat minusHeight = 3.0;
    CGFloat minusWidth = MIN(self.bounds.size.width, self.bounds.size.height) * 0.2;
    CGRect titleLabelRect = [self titleRectForContentRect:self.titleLabel.bounds];
    
    CGFloat minusPointRightX = titleLabelRect.origin.x;
    CGFloat minusPointRightY = self.bounds.size.height/2;
    CGFloat minusPointLeftX = minusPointRightX-minusWidth;
    CGFloat minusPointLeftY = self.bounds.size.height/2;
    
    UIBezierPath *plusPath = [[UIBezierPath alloc] init];
    plusPath.lineWidth = minusHeight;
    
    [plusPath moveToPoint:CGPointMake(minusPointRightX, minusPointRightY)];
    [plusPath addLineToPoint:CGPointMake(minusPointLeftX, minusPointLeftY)];
    
 
  //  [plusPath moveToPoint:CGPointMake(self.bounds.size.width/4 - minusWidth/2 + 0.5, self.bounds.size.height/2 + 0.5)];
    
   // [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/4 + minusWidth/2 + 0.5, self.bounds.size.height/2 + 0.5)];
    
    [[UIColor whiteColor] setStroke];
    [plusPath stroke];
    
}

-(void)drawPlusLine:(CGRect)rect{
    
    
    CGFloat plusHeight = 3.0;
    CGFloat plusWidth = MIN(self.bounds.size.width, self.bounds.size.height) * 0.2;
    
    UIBezierPath *plusPath = [[UIBezierPath alloc] init];
    plusPath.lineWidth = plusHeight;
    
    [plusPath moveToPoint:CGPointMake(self.bounds.size.width/4 + 0.5, self.bounds.size.height/2 -plusWidth/2 + 0.5)];
    
    [plusPath addLineToPoint:CGPointMake(self.bounds.size.width/4 + 0.5, self.bounds.size.height/2 + plusWidth/2 + 0.5)];
    
    [[UIColor whiteColor] setStroke];
    [plusPath stroke];
}*/


@end
