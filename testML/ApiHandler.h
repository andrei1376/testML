//
//  ApiHandler.h
//  testML
//
//  Created by Emiliano Baublys on 5/11/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ApiHandlerDelegate <NSObject>

@optional

-(void)didFinishLoadingIssuers;
-(void)didFinishLoadingInstallments;

@end

@interface ApiHandler : NSObject{
	NSMutableDictionary *paymentMethods;
	NSMutableDictionary *cardIssuers;
	NSMutableDictionary *installments;
	NSString *mpseleccionado;
	UIImage *mp_thumb;
	NSString *bancoseleccionado;
	UIImage *banco_thumb;
	NSString *recommended_message;
	float monto;
	id mediopagoSel;
	id bancoSel;
}

@property (nonatomic, weak) id <ApiHandlerDelegate> delegate;

@property (nonatomic, retain) NSMutableDictionary *paymentMethods;
@property (nonatomic, retain) NSMutableDictionary *cardIssuers;
@property (nonatomic, retain) NSMutableDictionary *installments;
@property (nonatomic, retain) NSString *mpseleccionado;
@property (nonatomic, retain) UIImage *mp_thumb;
@property (nonatomic, retain) NSString *bancoseleccionado;
@property (nonatomic, retain) UIImage *banco_thumb;
@property (nonatomic, retain) NSString *recommended_message;
@property (nonatomic) float monto;
@property (nonatomic) id mediopagoSel;
@property (nonatomic) id bancoSel;

+(ApiHandler *)sharedInstance;

-(void)getPaymentMethods;
-(void)getCardIssuers:(id)paymentMethodId;
-(void)getInstallmentsForIssuer:(id)issuer;

@end
