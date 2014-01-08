//
//  MSSecondViewController.m
//  FormTesting
//
//  Created by Andrew Beaupre on 12/30/13.
//  Copyright (c) 2013 Andrew Beaupre. All rights reserved.
//

#import "DatePickerPopup.h"

@interface DatePickerPopup ()

@end

@implementation DatePickerPopup

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIDatePicker *dp = [[UIDatePicker alloc]init];
    
    self.datePickerText.inputView = dp;
    
    //self.datePickerText.leftView = self.datePickerSelectButton;
    
    //self.datePickerText.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)datePickerSelectButtonDidTouchUp:(id)sender {
    
    [self.datePickerText resignFirstResponder];
}
@end
