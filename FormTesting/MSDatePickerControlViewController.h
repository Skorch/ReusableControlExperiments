//
//  MSDatePickerControlViewController.h
//  FormTesting
//
//  Created by Andrew Beaupre on 1/2/14.
//  Copyright (c) 2014 Andrew Beaupre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSDatePickerControlViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *birthdateTextField;

@property (weak, nonatomic) IBOutlet UIView *dateSelectorView;

@property (weak, nonatomic) IBOutlet UITextField *dateSelectorYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateSelectorMonthTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateSelectorDayTextField;

@property (nonatomic, copy) BOOL (^validateBlock)(NSDate *, BOOL);

- (IBAction)dateSelectorYearDidChange:(id)sender;
- (IBAction)dateSelectorMonthDidChange:(id)sender;
- (IBAction)dateSelectorDayDidChange:(id)sender;
- (IBAction)resetDate;

+ (MSDatePickerControlViewController *)datePickerWithValidation:(BOOL (^)(NSDate *, BOOL))validate;

@end
