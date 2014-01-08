//
//  SliderViewController.m
//  FormTesting
//
//  Created by Andrew Beaupre on 1/6/14.
//  Copyright (c) 2014 Andrew Beaupre. All rights reserved.
//

#import "SliderViewController.h"
#import "MSSliderViewController.h"

@interface SliderViewController ()

@property (nonatomic, strong) MSSliderViewController *slider1;
@property (nonatomic, strong) MSSliderViewController *slider2;
@property (nonatomic, strong) MSSliderViewController *slider3;
@end

@implementation SliderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"slider1"]){
        _slider1 = segue.destinationViewController;
        
        _slider1 = [self setupSlider:segue.destinationViewController
                            minColor:[UIColor whiteColor]
                            maxColor:[UIColor blueColor]
                            minValue:@0
                            maxValue:@100
                        initialValue:@30];

        
        [self.slider1 setValueChangeBlock:^(NSNumber *newValue) {
            NSLog(@"Value Change Block 1: %@", newValue);
        }];
    }
    else if([segue.identifier  isEqual: @"slider2"]){

        _slider2 = [self setupSlider:segue.destinationViewController
                            minColor:[UIColor whiteColor]
                            maxColor:[UIColor redColor]
                            minValue:@0
                            maxValue:@1
                        initialValue:@0.6];
        
        [self.slider2 setValueChangeBlock:^(NSNumber *newValue) {
            NSLog(@"Value Change Block 2: %@", newValue);
        }];
        
    }
    else if([segue.identifier  isEqual: @"slider3"]){
        
        _slider3 = [self setupSlider:segue.destinationViewController
                            minColor:[UIColor whiteColor]
                            maxColor:[UIColor purpleColor]
                            minValue:@0
                            maxValue:@1000
                        initialValue:@800];
        
        [self.slider3 setValueChangeBlock:^(NSNumber *newValue) {
            NSLog(@"Value Change Block 3: %@", newValue);
        }];
        
    }
    

}

-(MSSliderViewController *)setupSlider:(MSSliderViewController *)slider
                              minColor:(UIColor *)minColor
                              maxColor:(UIColor *)maxColor
                              minValue:(NSNumber *)minValue
                              maxValue:(NSNumber *)maxValue
                          initialValue:(NSNumber *)initialValue
{
    slider.minColor = minColor;
    slider.maxColor = maxColor;
    slider.minValue = minValue;
    slider.maxValue = maxValue;
    slider.currentValue = initialValue;
    
    return slider;
}
@end
