//
//  LoginViewModel.h
//  Behavior
//
//  Created by keymon on 2018/7/6.
//  Copyright © 2018 keymon. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <UIKit/UIKit.h>

@import UIKit;

@interface LoginViewModel : NSObject
@property (nonatomic, weak) IBOutlet UIViewController *ownerVC;
@property (nonatomic, weak) IBOutlet UITextField *phoneTF;
@property (nonatomic, weak) IBOutlet UITextField *pwdTF;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)loginAction:(id)sender;

@end
