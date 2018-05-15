//
//  ViewController.m
//  testML
//
//  Created by Emiliano Baublys on 5/11/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import "ViewController.h"
#import "ApiHandler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"showAlertView" object:nil];
	
	//pido los medios de pago
	[[ApiHandler sharedInstance]getPaymentMethods];
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
	//oculto el teclado
	[self.monto resignFirstResponder];
	
}

-(void)dataReceived:(NSNotification *)noti
{
	[self performSegueWithIdentifier:@"popOver" sender:self];
}

- (IBAction)handleButtonClick:(id)sender{
	[self performSegueWithIdentifier:@"toMedioPago" sender:self];
}


#pragma mark - TextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	//borro el textfield cada vez que lo edito
	textField.text = @"";
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
	[[ApiHandler sharedInstance]setMonto:[self.monto.text floatValue]];
	
	//luego de tipear el monto, habilito el continuar y paso a mostrar los medios de pago
	[self.continuar setHidden:NO];
}


@end
