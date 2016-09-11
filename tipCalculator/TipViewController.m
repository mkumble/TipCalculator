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
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      NSArray *tipValues = @[@([defaults floatForKey:@"defaultTipPercentValue"]),@(0.15),@(0.20),@(0.25)];
    float tipPercentValue = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    [self updateValues:tipPercentValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipValues = @[@([defaults floatForKey:@"defaultTipPercentValue"]),@(0.15),@(0.20),@(0.25)];
    float tipPercentValue = [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    [self updateValues:tipPercentValue];
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
                       float totatlAmount = billAmount + tipAmount;
    
    //Update the UI
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totatlAmount];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float defaultTipPercentValue = [defaults floatForKey:@"defaultTipPercentValue"];
        [self updateValues:defaultTipPercentValue];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

@end
