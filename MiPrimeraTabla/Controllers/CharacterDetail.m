//
//  CharacterDetail.m
//  MiPrimeraTabla
//
//  Created by Jose Trinidad Fajardo Flores on 9/27/17.
//  Copyright © 2017 Jose Trinidad Fajardo Flores. All rights reserved.
//

#import "CharacterDetail.h"

@interface CharacterDetail ()
@end

@implementation CharacterDetail

@synthesize lblAge;
@synthesize age;
@synthesize imgUser;
@synthesize image;

- (void)viewDidLoad {
    [super viewDidLoad];
    lblAge.text = self.age;
    imgUser.image      = [UIImage imageNamed:self.image];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBackPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
