//
//  CoreDataInteractor.h
//  marvelproj
//
//  Created by Andre Nogueira on 12/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataInteractor : NSObject

@property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;

//- (id)initWithCompletionBlock:(CallbackBlock)callback;

@end
