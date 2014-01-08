//
//  MSSliderViewController.m
//  FormTesting
//
//  Created by Andrew Beaupre on 1/6/14.
//  Copyright (c) 2014 Andrew Beaupre. All rights reserved.
//

#import "MSSliderViewController.h"

@interface MSSliderViewController ()

@property CGFloat normalWidth; //the real amount of width to play with after taking into account the button width
@property NSNumberFormatter *valueLabelFormatter;

@property (weak, nonatomic) IBOutlet UIView *sliderButton;
@property (weak, nonatomic) IBOutlet UIView *sliderBackground;
@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
- (IBAction)handleButtonSwipe:(id)sender;

@end

@implementation MSSliderViewController

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
    
    self.sliderBackground.backgroundColor = [UIColor clearColor];
    _valueLabelFormatter = [[NSNumberFormatter alloc] init];
    self.valueLabelFormatter.formatterBehavior = NSNumberFormatterDecimalStyle;
    self.valueLabelFormatter.maximumSignificantDigits = 4;
    self.valueLabelFormatter.maximumFractionDigits = 1;
    self.valueLabelFormatter.minimumIntegerDigits = 1;

}

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
    _normalWidth = self.sliderBackground.frame.size.width - self.sliderButton.frame.size.width;

    self.sliderBackground.backgroundColor = self.minColor;
    
    self.gradientView.backgroundColor = self.maxColor;
    
    CGFloat valueRatio = MIN([self.currentValue doubleValue] / [self.maxValue doubleValue], [self.maxValue doubleValue]);
    
    NSNumber *newXPoation = @(self.normalWidth - self.normalWidth * valueRatio);
    
    [self setGradientViewFrame:self.gradientView atLocation:newXPoation withOffset:self.sliderButton.frame.size.width];

    [self moveSliderButton:self.sliderButton toPosition:newXPoation];
    
    self.currentValueLabel.text = [self.valueLabelFormatter stringFromNumber:self.currentValue];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonSwipe:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint backgroundLocation = [recognizer locationInView:self.sliderBackground];
    
    CGPoint velocity = [recognizer velocityInView:self.sliderBackground];
    
    CGRect buttonFrame = self.sliderButton.frame;

    NSLog(@"swipe action: x=%f, y=%f", backgroundLocation.x, backgroundLocation.y);
    
    if(
       //reached the far left
       (velocity.x < 0 && buttonFrame.origin.x > 0) ||
       //reached the far right
       (velocity.x > 0 && buttonFrame.origin.x < self.normalWidth))
    {
        NSNumber *newButtonX = @(backgroundLocation.x - buttonFrame.size.width/2);

        [self moveSliderButton:self.sliderButton
                    toPosition:newButtonX];
        
        [self setGradientViewFrame:self.gradientView atLocation:newButtonX withOffset:buttonFrame.size.width];
        
        CGFloat sliderRatio = [self sliderValueRatio:[newButtonX doubleValue] max:self.normalWidth];
        
        self.currentValue =  @([self.maxValue doubleValue] * sliderRatio);
        
        
        
    }
}

- (void)setCurrentValue:(NSNumber *)currentValue
{
    _currentValue = currentValue;
    
    if(self.valueChangeBlock)
    {
        self.valueChangeBlock(currentValue);
    }
    
    
    self.currentValueLabel.text = [self.valueLabelFormatter stringFromNumber:currentValue];
}

- (void)moveSliderButton: (UIView *)sliderButton
              toPosition: (NSNumber *) newXPosition
{
    sliderButton.frame = CGRectMake([newXPosition doubleValue],
                                    sliderButton.frame.origin.y,
                                    sliderButton.frame.size.width,
                                    sliderButton.frame.size.height);
    
}

- (void)setGradientViewFrame: (UIView *)gradientView
                  atLocation: (NSNumber *)newXPosition
                  withOffset: (CGFloat)offset
{

    CGRect gradientFrame = gradientView.frame;
    
    gradientView.frame = CGRectMake(
                                     [newXPosition doubleValue] + offset,
                                     gradientFrame.origin.y,
                                     self.normalWidth - [newXPosition doubleValue],
                                     gradientFrame.size.height);

    CGFloat newAlpha = [self sliderValueRatio:[newXPosition doubleValue] max: self.normalWidth];
    
    
    NSLog(@"New Alpha: %f", newAlpha);
    
    gradientView.backgroundColor = [self colorByChanging:gradientView.backgroundColor alphaTo:newAlpha];
}

- (CGFloat)sliderValueRatio: (CGFloat) currentPosition max: (CGFloat)sliderWidth
{
    //keep the bounds between 0 and 1
    return 1 - MAX( 0.0, MIN(sliderWidth, currentPosition)) / sliderWidth;
}

- (UIColor *)colorByChanging: (UIColor *) color alphaTo:(CGFloat)newAlpha;
{
    CGFloat hue, saturation, brightness, alpha ;
    BOOL ok = [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha ] ;
    if ( !ok ) {
        // handle error
    }
    // ... adjust components..
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:newAlpha ] ;

}
@end
