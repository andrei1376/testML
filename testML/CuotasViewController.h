//
//  CuotasViewController.h
//  testML
//
//  Created by Emiliano Baublys on 5/15/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuotasViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	NSDictionary *cuotas;
	float monto;
	id idBanco;
}

@property (weak, nonatomic) IBOutlet UILabel *monto;
@property (weak, nonatomic) IBOutlet UILabel *mediodepago;
@property (weak, nonatomic) IBOutlet UILabel *banco;
@property (weak, nonatomic) IBOutlet UILabel *recommended_message;
@property (weak, nonatomic) IBOutlet UIButton *continuar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCuotas;
@property (weak, nonatomic) IBOutlet UIImageView *mediopago_thumbnail;
@property (weak, nonatomic) IBOutlet UIImageView *banco_thumbnail;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

- (IBAction)handleButtonClick:(id)sender;


#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED;
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED;

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;


@end
