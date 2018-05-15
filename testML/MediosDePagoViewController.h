//
//  MediosDePagoViewController.h
//  testML
//
//  Created by Emiliano Baublys on 5/11/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediosDePagoViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	NSDictionary *medioPago;
	float monto;
	id idMedioPago;
}

@property (weak, nonatomic) IBOutlet UILabel *monto;
@property (weak, nonatomic) IBOutlet UILabel *mediodepago;
@property (weak, nonatomic) IBOutlet UIButton *continuar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerMP;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

- (IBAction)handleButtonClick:(id)sender;

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED;
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED;

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

#pragma mark - ApiDelegate
-(void)didFinishLoadingIssuers;

@end
