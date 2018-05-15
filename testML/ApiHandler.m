//
//  ApiHandler.m
//  testML
//
//  Created by Emiliano Baublys on 5/11/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiHandler.h"
#import "Constants.h"
#import <AFNetworking.h>

@implementation ApiHandler

@synthesize paymentMethods;
@synthesize cardIssuers;
@synthesize monto;
@synthesize mpseleccionado;
@synthesize mp_thumb;
@synthesize bancoseleccionado;
@synthesize banco_thumb;
@synthesize installments;
@synthesize mediopagoSel;
@synthesize bancoSel;
@synthesize recommended_message;

+ (ApiHandler *)sharedInstance
{
	static ApiHandler* instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[ApiHandler alloc] init];
	});
	
	return instance;
}

#pragma mark - Initialization
-(instancetype)init{
	self = [super init];
	if (self) {
		paymentMethods = [[NSMutableDictionary alloc]init];
		cardIssuers = [[NSMutableDictionary alloc]init];
		installments = [[NSMutableDictionary alloc]init];
	}
	
	return self;
}

-(void)getPaymentMethods{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:[NSString stringWithFormat:@"%@%@",kGetPaymentMethods,kApiKey] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		//NSLog(@"%@",[responseObject valueForKey:@"credit_card"]);
		for (NSDictionary *methods in responseObject) {
			NSString *paymentType = [methods objectForKey:@"payment_type_id"];
			if ([paymentType isEqualToString:@"credit_card"]) {
				//NSLog(@"%@", [methods objectForKey:@"name"]);
				[paymentMethods setValue:methods forKey:[methods objectForKey:@"name"]];
			}
		}
		NSLog(@"Payment Methods Cargados");
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		NSLog(@"%@", error);
		
	}];
}


-(void)getCardIssuers:(id)paymentMethodId{
	
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:[NSString stringWithFormat:@"%@%@%@%@",kGetCardIssuers,kApiKey,kPaymentMethod,paymentMethodId] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		NSLog(@"%@",responseObject);
		for (NSDictionary *issuers in responseObject){
			[cardIssuers setValue:issuers forKey:[issuers objectForKey:@"name"]];
		}
		NSLog(@"Card Issuers Cargados");
		if (self.delegate){
			[self.delegate didFinishLoadingIssuers];
		}
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		NSLog(@"%@", error);
		
	}];
	
	
}

-(void)getInstallmentsForIssuer:(id)issuer{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	[manager GET:[NSString stringWithFormat:@"%@%@%@%f%@%@%@%@",kGetRecommendedMessage,kApiKey,kAmount,monto,kPaymentMethod,mediopagoSel,kIssuerID,issuer] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
		NSLog(@"%@",responseObject);
		
		[installments setValue:[[responseObject valueForKey:@"payer_costs"]objectAtIndex:0] forKey:@"Cuotas"];
		
		NSLog(@"Installments Cargados");
		if (self.delegate){
			[self.delegate didFinishLoadingInstallments];
		}
	} failure:^(NSURLSessionTask *operation, NSError *error) {
		NSLog(@"%@", error);
		
	}];
	
	
}



@end
