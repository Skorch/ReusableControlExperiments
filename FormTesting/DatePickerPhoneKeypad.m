//
//  MSFirstViewController.m
//  FormTesting
//
//  Created by Andrew Beaupre on 12/30/13.
//  Copyright (c) 2013 Andrew Beaupre. All rights reserved.
//

#import "DatePickerPhoneKeypad.h"
#import "MSDatePickerControlViewController.h"

@interface DatePickerPhoneKeypad()

@property (nonatomic, strong) MSDatePickerControlViewController *birthdateController;

@end

@implementation DatePickerPhoneKeypad

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"datePicker"])
    {
        _birthdateController = segue.destinationViewController;
        [self.birthdateController setValidateBlock:^BOOL(NSDate *date, BOOL completed) {
            return !completed || date != nil;
        }];
    }
}

- (IBAction)resetButtonTouchUpInside:(id)sender {
    [self.birthdateController resetDate];
    
    
}


@end
