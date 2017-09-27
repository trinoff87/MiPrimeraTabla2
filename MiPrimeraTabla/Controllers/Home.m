//
//  ViewController.m
//  MiPrimeraTabla
//
//  Created by Jose Trinidad Fajardo Flores on 9/25/17.
//  Copyright © 2017 Jose Trinidad Fajardo Flores. All rights reserved.
//

#import "Home.h"
#import "CellMainTable.h"
#import "CharacterDetail.h"

@interface Home ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;
@property NSMutableArray *userDesc;
@property NSString *name;
@property NSString *age;
@property NSString *selectedAge;
@property NSString * selectedImg;
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
    
    self.userDesc  = [[NSMutableArray alloc] initWithObjects: @"Hijo de Tywin Lannister, la mano de Daenerys Targaryen", @"La heredera al trono, la unica Targaryen sobreviviente", @"El rey del norte, bastardo de Ned Stark", @"La hija menor de los stark, se convirtio en una asesina.", @"La reina de los 7 reinos, hija de Tywin Lannister", nil];
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
    self.selectedAge = self.userDesc[indexPath.row];
    self.selectedImg =  self.userImages[indexPath.row];
    [self performSegueWithIdentifier:@"segueID" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CharacterDetail *detailController = segue.destinationViewController;
    detailController.age = self.selectedAge;
    detailController.image = self.selectedImg;
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
        [self handleImageGallery];
        [self.userImages addObject:@"/Users/trinof/Documents/MiPrimeraTabla/MiPrimeraTabla/imgs/myfile.jpg"];
        [self.userNames addObject:self.name];
        [self.userAges addObject:self.age];
        [self.userDesc addObject:[NSString stringWithFormat:@"%@ is a new game of thrones character and is %@ years old", self.name, self.age]];
        [self.tblMain reloadData];
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
    [self.tblMain reloadData];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];    
}

@end
