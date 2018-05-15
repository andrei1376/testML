//
//  popUpViewController.h
//  testML
//
//  Created by Emiliano Baublys on 5/15/18.
//  Copyright © 2018 Emiliano Baublys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *monto;
@property (weak, nonatomic) IBOutlet UILabel *mediopago;
@property (weak, nonatomic) IBOutlet UILabel *banco;
@property (weak, nonatomic) IBOutlet UILabel *recommended_message;

@property (weak, nonatomic) IBOutlet UIImageView *mpThumb;
@property (weak, nonatomic) IBOutlet UIImageView *bancoThumb;

@property (weak, nonatomic) IBOutlet UIButton *dismiss;

- (IBAction)handleButtonClick:(id)sender;

@end
