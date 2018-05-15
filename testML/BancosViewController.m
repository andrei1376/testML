//
//  BancosViewController.m
//  testML
//
//  Created by Emiliano Baublys on 5/15/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import "BancosViewController.h"
#import "ApiHandler.h"

@interface BancosViewController () <ApiHandlerDelegate>

@end

@implementation BancosViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[[ApiHandler sharedInstance]setDelegate:self];
	
	self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:self.activityIndicatorView];
	
	// Do any additional setup after loading the view, typically from a nib.
	monto = [[ApiHandler sharedInstance]monto];
	bancos = [[NSDictionary alloc]initWithDictionary:[[ApiHandler sharedInstance]cardIssuers]];
	
	if (bancos.count == 0) {
		//esperar hasta tener bancos
		[self.activityIndicatorView startAnimating];
		
	}
	
	self.monto.text = [NSString stringWithFormat:@"$%.02f", monto];
	self.mediodepago.text = [[ApiHandler sharedInstance]mpseleccionado];
	[self.mediopago_thumbnail setImage:[[ApiHandler sharedInstance]mp_thumb]];
	
}

//-(void)viewDidDisappear:(BOOL)animated{
//	[[ApiHandler sharedInstance]setDelegate:nil];}

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
			_banco_thumbnail.image = [UIImage imageWithData: data];
		});
	});
}

- (IBAction)handleButtonClick:(id)sender{
	[self performSegueWithIdentifier:@"toCuotas" sender:self];
}

#pragma mark UIPickerDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
	//obtengo el url del thumbnail para el medio de pago
	NSString *url = [[bancos valueForKey:[[bancos allKeys]objectAtIndex:row]]valueForKey:@"secure_thumbnail"];
	
	//cargo la imagen
	[self loadThumbnail:url];
	
	//muestro medio de pago seleccionado
	[self.banco setHidden:NO];
	self.banco.text = [[bancos allKeys]objectAtIndex:row];
	
	//habilito el continuar
	[self.continuar setHidden:NO];
	
	//me guardo el ID
	idBanco = [[bancos valueForKey:[[bancos allKeys]objectAtIndex:row]]valueForKey:@"id"];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (bancos.count==0) {
		return @"";
	}
	return [[bancos allKeys]objectAtIndex:row];
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	if (bancos.count==0) {
		return 0;
	}
	return bancos.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	//antes de hacer el push a la siguiente view, pido los bancos
	
	[[ApiHandler sharedInstance]getInstallmentsForIssuer:idBanco];
	[[ApiHandler sharedInstance]setBancoseleccionado:self.banco.text];
	[[ApiHandler sharedInstance]setBanco_thumb:self.banco_thumbnail.image];
}
#pragma mark - apidelegate
-(void)didFinishLoadingIssuers{
	[self.activityIndicatorView stopAnimating];
	bancos = [[NSDictionary alloc]initWithDictionary:[[ApiHandler sharedInstance]cardIssuers]];
	[self.pickerBancos reloadAllComponents];
}

@end
