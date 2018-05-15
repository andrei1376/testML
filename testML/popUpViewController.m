//
//  popUpViewController.m
//  testML
//
//  Created by Emiliano Baublys on 5/15/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import "popUpViewController.h"
#import "ApiHandler.h"

@interface popUpViewController ()

@end

@implementation popUpViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	//pido la info
	
	self.monto.text = [NSString stringWithFormat:@"$%.02f", [[ApiHandler sharedInstance]monto]];
	self.mediopago.text = [[ApiHandler sharedInstance]mpseleccionado];
	self.banco.text = [[ApiHandler sharedInstance]bancoseleccionado];
	self.recommended_message.text = [[ApiHandler sharedInstance]recommended_message];
	
	[self.mpThumb setImage:[[ApiHandler sharedInstance]mp_thumb]];
	[self.bancoThumb setImage:[[ApiHandler sharedInstance]banco_thumb]];
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonClick:(id)sender{
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
	
}

@end
