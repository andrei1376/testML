//
//  Constants.h
//  testML
//
//  Created by Emiliano Baublys on 5/11/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kApiKey @"444a9ef5-8a6b-429f-abdf-587639155d88"

#define kGetPaymentMethods @"https://api.mercadopago.com/v1/payment_methods?public_key="

#define kGetCardIssuers @"https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key="
#define kPaymentMethod @"&payment_method_id="

#define kGetRecommendedMessage @"https://api.mercadopago.com/v1/payment_methods/installments?public_key="
#define kAmount @"&amount="
#define kIssuerID @"&issuer.id="
#endif /* Constants_h */
