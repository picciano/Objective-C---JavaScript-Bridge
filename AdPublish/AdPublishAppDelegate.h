//
//  AdPublishAppDelegate.h
//  AdPublish
//
//  Created by Anthony Picciano on 4/5/11.
//  Copyright 2011 Crispin Porter + Bogusky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdPublishViewController;

@interface AdPublishAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet AdPublishViewController *viewController;

@end
