//
//  CharacterDetail.h
//  MiPrimeraTabla
//
//  Created by Jose Trinidad Fajardo Flores on 9/27/17.
//  Copyright © 2017 Jose Trinidad Fajardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterDetail : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (nonatomic, strong) NSString * age;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (nonatomic, strong) NSString * image;
@end
