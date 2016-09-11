//
//  ViewController.m
//  tipCalculator
//
//  Created by Mithun Kumble on 9/10/16.
//  Copyright © 2016 codepath. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;

@end

@implementation TipViewController


- (void)viewDidLoad {
    [super viewDidLoad];
self.title = @"Tip Calculator";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
        [self.billTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)onValueChanged:(UISegmentedControl *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipValues = @[@([defaults floatForKey:@"defaultTipPercentValue"]),@(0.15),@(0.20),@(0.25)];
    float tipPercentValue = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    [self updateValues:tipPercentValue];
}

- (void)updateValues:(float)tipPercentValue {
    //Get Bill amount
    float billAmount =[self.billTextField.text floatValue];
    
    //Calculate tip amount and total amount
    float tipAmount = tipPercentValue * billAmount;
                       float totalAmount = billAmount + tipAmount;
    
    //Update the UI
    self.tipLabel.text =[self getLocalizedAmount:[NSString stringWithFormat:@"%0.2f", tipAmount]];

    self.totalLabel.text =
    [self getLocalizedAmount:[NSString stringWithFormat:@"%0.2f", totalAmount]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float defaultTipPercentValue = [defaults floatForKey:@"defaultTipPercentValue"];
        [self updateValues:defaultTipPercentValue];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self.billTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (NSString *) getLocalizedAmount:(NSString*)amount {
    NSDecimalNumber * decAmount = [NSDecimalNumber decimalNumberWithString:amount];
    NSNumberFormatter *currencyFormat = [[NSNumberFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];

    [currencyFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormat setLocale:locale];
    return [NSString stringWithFormat:@"%@",[currencyFormat stringFromNumber:decAmount]];
}

-(void)textFieldDidChange :(UITextField *) textField{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipValues = @[@([defaults floatForKey:@"defaultTipPercentValue"]),@(0.15),@(0.20),@(0.25)];
    float tipPercentValue = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    [self updateValues:tipPercentValue];
}

@end
