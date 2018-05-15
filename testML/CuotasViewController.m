//
//  CuotasViewController.m
//  testML
//
//  Created by Emiliano Baublys on 5/15/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import "CuotasViewController.h"
#import "ApiHandler.h"

@interface CuotasViewController () <ApiHandlerDelegate>

@end

@implementation CuotasViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[[ApiHandler sharedInstance]setDelegate:self];
	
	self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:self.activityIndicatorView];
	
	// Do any additional setup after loading the view, typically from a nib.
	monto = [[ApiHandler sharedInstance]monto];
	cuotas = [[NSDictionary alloc]initWithDictionary:[[ApiHandler sharedInstance]installments]];
	
	if (cuotas.count == 0) {
		//esperar hasta tener bancos
		[self.activityIndicatorView startAnimating];
		
	}
	
	self.monto.text = [NSString stringWithFormat:@"$%.02f", monto];
	
	self.mediodepago.text = [[ApiHandler sharedInstance]mpseleccionado];
	[self.mediopago_thumbnail setImage:[[ApiHandler sharedInstance]mp_thumb]];
	
	self.banco.text = [[ApiHandler sharedInstance]bancoseleccionado];
	[self.banco_thumbnail setImage:[[ApiHandler sharedInstance]banco_thumb]];
	
}

-(void)viewDidDisappear:(BOOL)animated{
	[[ApiHandler sharedInstance]setDelegate:nil];}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClick:(id)sender {
	//antes de hacer el pop al rootViewController me guardo el recommended message
	[[ApiHandler sharedInstance]setRecommended_message:self.recommended_message.text];
	[self.navigationController popToRootViewControllerAnimated:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"showAlertView" object:nil];
	
	
}

#pragma mark UIPickerDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
	
	//muestro medio de pago seleccionado
	[self.recommended_message setHidden:NO];
	self.recommended_message.text = [[[cuotas valueForKey:@"Cuotas"]objectAtIndex:row]valueForKey:@"recommended_message"];
	
	//habilito el continuar
	[self.continuar setHidden:NO];
	
	//me guardo el ID
	//idBanco = [[bancos valueForKey:[[bancos allKeys]objectAtIndex:row]]valueForKey:@"id"];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (cuotas.count==0) {
		return @"";
	}
	return [NSString stringWithFormat:@"%@ Cuota/s",[[[[cuotas valueForKey:@"Cuotas"]objectAtIndex:row]valueForKey:@"installments"]stringValue]];
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	if (cuotas.count==0) {
		return 0;
	}
	return [[cuotas valueForKey:@"Cuotas"]count];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//	//antes de hacer el pop al rootViewController me guardo el recommended message
//	[[ApiHandler sharedInstance]setRecommended_message:self.recommended_message.text];
//	
//	[self.navigationController popToRootViewControllerAnimated:YES];
//	
//}
#pragma mark - apidelegate
-(void)didFinishLoadingInstallments{
	[self.activityIndicatorView stopAnimating];
	cuotas = [[NSDictionary alloc]initWithDictionary:[[ApiHandler sharedInstance]installments]];
	[self.pickerCuotas reloadAllComponents];
}

@end

