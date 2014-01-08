//
//  MSDatePickerControlViewController.m
//  FormTesting
//
//  Created by Andrew Beaupre on 1/2/14.
//  Copyright (c) 2014 Andrew Beaupre. All rights reserved.
//

#import "MSDatePickerControlViewController.h"

@interface MSDatePickerControlViewController ()

@property (nonatomic, strong) NSDate *dateValue;


@end

@implementation MSDatePickerControlViewController

+ (MSDatePickerControlViewController *)datePickerWithValidation:(BOOL (^)(NSDate *, BOOL))validate
{
    MSDatePickerControlViewController *controller = [[MSDatePickerControlViewController alloc] initWithNibName:@"MSDatePickerControlViewController" bundle:nil];
        
    [controller setValidateBlock:validate];
    
    return controller;
}

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
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dateSelectorDayTextField.delegate = self;
    self.dateSelectorMonthTextField.delegate = self;
    self.dateSelectorYearTextField.delegate = self;
    self.birthdateTextField.delegate = self;
    
}


- (IBAction)dateSelectorYearDidChange:(id)sender {
    
    [self processDateFields:sender];
    
}

- (IBAction)dateSelectorMonthDidChange:(id)sender{
    
    [self processDateFields:sender];
    
}

- (IBAction)dateSelectorDayDidChange:(id)sender{
    
    [self processDateFields:sender];
    
}

- (IBAction)resetDate{
    
    self.dateSelectorDayTextField.text = nil;
    self.dateSelectorMonthTextField.text = nil;
    self.dateSelectorYearTextField.text = nil;
    self.birthdateTextField.text = nil;
    self.dateValue = nil;
}


- (void)processDateFields:(UITextField *)field{
    
    [self dateFieldComplete:field];
    
    
    BOOL fieldComplete = self.dateSelectorYearTextField.text.length &&
                        self.dateSelectorMonthTextField.text.length &&
                        self.dateSelectorDayTextField.text.length;
    
    NSDate *textFieldDate;
    
    //make sure each box has been filled out
    if(fieldComplete)
    {
        textFieldDate = [self buildDateFromTextFields:self.dateSelectorYearTextField
                                                   monthField:self.dateSelectorMonthTextField
                                                     dayField:self.dateSelectorDayTextField];
        if(textFieldDate){

            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            df.dateStyle = NSDateFormatterMediumStyle;
            
            self.birthdateTextField.text = [df stringFromDate:self.dateValue];
        }
        
    }

    self.dateValue = textFieldDate;

    UIColor *viewColor = [UIColor clearColor];

    if(self.validateBlock && !self.validateBlock(self.dateValue, fieldComplete)){
        viewColor = [UIColor redColor];
    }

    self.dateSelectorView.backgroundColor = viewColor;

}

- (IBAction)birthdateTextFieldEditingDidBegin:(id)sender {
    
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField == self.birthdateTextField){
        self.dateSelectorView.hidden = NO;
        self.birthdateTextField.hidden = YES;
        
        
        UIView *view = [self.dateSelectorView viewWithTag:1];
        
        if(view){
            [view becomeFirstResponder];
        }
        
        return NO;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField //resign first responder for textfield
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(string.length == 0) return YES;
    
    if(string.length + textField.text.length - range.length > textField.placeholder.length) return NO;
    
    
    NSString * const numericRegex = @"[0-9]+";
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:numericRegex
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        NSLog(@"error %@", error);
    }
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string
                                                        options:0
                                                          range:NSMakeRange(0, [string length])];
    if(numberOfMatches == 0) return NO;
    
    
    return YES;
    
}

- (void)dateFieldComplete: (UITextField *)field
{
    NSInteger nextTag = 0;
    
    if(field.text.length == field.placeholder.length){
        
        NSLog(@"field complete");
        
        nextTag = field.tag + 1;
    }
    
    if(nextTag > 0){
        UIView *view = [field.superview viewWithTag:nextTag];
        
        [field resignFirstResponder];
        
        if(view){
            [view becomeFirstResponder];
        }
        else if(self.dateValue){
            self.dateSelectorView.hidden = YES;
            self.birthdateTextField.hidden = NO;
        }
    }
    
    
}

- (NSDate *)buildDateFromTextFields: (UITextField *)yearField
                         monthField: (UITextField *)monthField
                           dayField: (UITextField *)dayField
{
    
    NSString *concatDate = [NSString stringWithFormat:@"%@/%@/%@",
                            yearField.text,
                            monthField.text,
                            dayField.text];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    [df setLenient:NO];
    
    return [df dateFromString:concatDate];
}
@end
