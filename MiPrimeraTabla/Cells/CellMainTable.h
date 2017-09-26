//
//  CellMainTable.h
//  MiPrimeraTabla
//
//  Created by Jose Trinidad Fajardo Flores on 9/26/17.
//  Copyright © 2017 Jose Trinidad Fajardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMainTable : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;

@end
