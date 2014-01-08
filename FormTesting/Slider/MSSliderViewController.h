//
//  MSSliderViewController.h
//  FormTesting
//
//  Created by Andrew Beaupre on 1/6/14.
//  Copyright (c) 2014 Andrew Beaupre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSSliderViewController : UIViewController


@property (nonatomic, strong) NSNumber *currentValue;
@property (nonatomic, strong) NSNumber *maxValue;
@property (nonatomic, strong) NSNumber *minValue;

@property (nonatomic, strong) UIColor *minColor;
@property (nonatomic, strong) UIColor *maxColor;

@property (nonatomic, copy) void(^valueChangeBlock)(NSNumber *);


@end
