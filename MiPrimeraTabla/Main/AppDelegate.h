//
//  AppDelegate.h
//  MiPrimeraTabla
//
//  Created by Jose Trinidad Fajardo Flores on 9/25/17.
//  Copyright © 2017 Jose Trinidad Fajardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

