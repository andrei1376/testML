//
//  MediosDePagoViewController.m
//  testML
//
//  Created by Emiliano Baublys on 5/11/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import "MediosDePagoViewController.h"
#import "ApiHandler.h"
#import <MBProgressHUD.h>

@interface MediosDePagoViewController () <ApiHandlerDelegate>

@end

@implementation MediosDePagoViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[[ApiHandler sharedInstance]setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
	monto = [[ApiHandler sharedInstance]monto];
	medioPago = [[NSDictionary alloc]initWithDictionary:[[ApiHandler sharedInstance]paymentMethods]];
	
	self.monto.text = [NSString stringWithFormat:@"$%.02f", monto];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)loadThumbnail:(NSString*)url{
	//sync
//	NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//	[_thumbnail setImage:[UIImage imageWithData: imageData]];
	
	//async
	dispatch_async(dispatch_get_global_queue(0,0), ^{
		NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
		if ( data == nil )
			return;
		dispatch_async(dispatch_get_main_queue(), ^{
			_thumbnail.image = [UIImage imageWithData: data];
		});
	});
}

- (IBAction)handleButtonClick:(id)sender{
	
	//agregar wait
	
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	
	[[ApiHandler sharedInstance]getCardIssuers:idMedioPago];
	[[ApiHandler sharedInstance]setMediopagoSel:idMedioPago];
	[[ApiHandler sharedInstance]setMpseleccionado:self.mediodepago.text];
	[[ApiHandler sharedInstance]setMp_thumb:self.thumbnail.image];
}

#pragma mark UIPickerDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
	//obtengo el url del thumbnail para el medio de pago
	NSString *url = [[medioPago valueForKey:[[medioPago allKeys]objectAtIndex:row]]valueForKey:@"secure_thumbnail"];
	
	//cargo la imagen
	[self loadThumbnail:url];
	
	//muestro medio de pago seleccionado
	[self.mediodepago setHidden:NO];
	self.mediodepago.text = [[medioPago allKeys]objectAtIndex:row];
	
	//habilito el continuar
	[self.continuar setHidden:NO];
	
	//me guardo el ID
	idMedioPago = [[medioPago valueForKey:[[medioPago allKeys]objectAtIndex:row]]valueForKey:@"id"];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[medioPago allKeys]objectAtIndex:row];
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return medioPago.count;
}

#pragma mark - apidelegate
-(void)didFinishLoadingIssuers{
	//quitar wait
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	
	[self performSegueWithIdentifier:@"toBancos" sender:self];
}

-(void)handleError{

		UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
																	   message:@"Ha ocurrido un problema!"
																preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
															  handler:^(UIAlertAction * action) {}];
		
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
}

@end
