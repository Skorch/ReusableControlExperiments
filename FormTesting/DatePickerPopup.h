//
//  MSSecondViewController.h
//  FormTesting
//
//  Created by Andrew Beaupre on 12/30/13.
//  Copyright (c) 2013 Andrew Beaupre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerPopup : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *datePickerText;
@property (weak, nonatomic) IBOutlet UIButton *datePickerSelectButton;
- (IBAction)datePickerSelectButtonDidTouchUp:(id)sender;

@end
