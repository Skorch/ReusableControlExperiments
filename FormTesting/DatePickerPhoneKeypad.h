//
//  MSFirstViewController.h
//  FormTesting
//
//  Created by Andrew Beaupre on 12/30/13.
//  Copyright (c) 2013 Andrew Beaupre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerPhoneKeypad : UIViewController

@property (weak, nonatomic) IBOutlet UIView *datePickerControl;

- (IBAction)resetButtonTouchUpInside:(id)sender;

@end
