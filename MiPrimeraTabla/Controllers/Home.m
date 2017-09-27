//
//  ViewController.m
//  MiPrimeraTabla
//
//  Created by Jose Trinidad Fajardo Flores on 9/25/17.
//  Copyright © 2017 Jose Trinidad Fajardo Flores. All rights reserved.
//

#import "Home.h"
#import "CellMainTable.h"

@interface Home ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;
@property NSString *name;
@property NSString *age;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIAlertController *alertController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation Home
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------------------
- (void)initController {
    self.userNames  = [[NSMutableArray alloc] initWithObjects: @"Tyrion Lannister", @"Daenerys Targaryen", @"Jon Snow", @"Arya Stark", @"Cersei Lannister", nil];
    
    self.userAges  = [[NSMutableArray alloc] initWithObjects: @"38 años", @"22 años", @"25 años", @"16 años", @"42 años", nil];
    
    self.userImages = [[NSMutableArray alloc] initWithObjects: @"tyrion.jpg", @"daenerys.jpg", @"jon.jpg", @"arya.jpg", @"cersei.jpg", nil];
}

/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    CellMainTable *cell = (CellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"CellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"CellMainTable" bundle:nil] forCellReuseIdentifier:@"CellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellMainTable"];
    }
    //Fill cell with info from arrays
    cell.lblName.text       = self.userNames[indexPath.row];
    cell.lblAge.text        = self.userAges[indexPath.row];
    cell.imgUser.image      = [UIImage imageNamed:self.userImages[indexPath.row]];
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Pending
}
/**********************************************************************************************/
#pragma mark - Action methods
/**********************************************************************************************/
- (IBAction)btnAddPressed:(id)sender {
    /*[self.userNames addObject:@"Walter"];
    [self.userAges addObject:@"37 años"];
    [self.userImages addObject:@"jon.jpg"];
    [self.tblMain reloadData];*/
    self.alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Agregar nuevo personaje" preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Nombre";
        //textField.secureTextEntry = YES;
    }];
    [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Edad";
        //textField.secureTextEntry = YES;
    }];
    
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Elige foto..."
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self handleImageGallery];
                                   }];
    [self.alertController addAction:imageGallery];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Agregar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.name = [[self.alertController textFields][0] text];
        self.age = [[self.alertController textFields][1] text];
        NSLog(@"Nombre %@", [[self.alertController textFields][0] text]);
        NSLog(@"Edad %@", [[self.alertController textFields][1] text]);
        //compare the current password and do action here
        
    }];
    
    [self.alertController addAction:confirmAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Canelled");
    }];
    
    [self.alertController addAction:cancelAction];
    [self presentViewController:self.alertController animated:YES completion:nil];
}

- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"image picked!");
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    [self.imageView setImage:img];
    NSData * binaryImageData = UIImagePNGRepresentation(img);
    [binaryImageData writeToFile:[@"/Users/trinof/Documents/MiPrimeraTabla/MiPrimeraTabla/imgs" stringByAppendingPathComponent:@"myfile.jpg"] atomically:YES];
    //[self.userNames addObject:self.name];
    //[self.userAges addObject:self.age];
    //[self.userImages addObject:@"myfile.jpg"];
    //[self.tblMain reloadData];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    //[self presentViewController:self.alertController animated:YES completion:nil];
    
}

@end
