//
//  AdPublishViewController.h
//  AdPublish
//
//  Created by Anthony Picciano on 4/5/11.
//  Copyright 2011 Crispin Porter + Bogusky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AdPublishViewController : UIViewController <UIWebViewDelegate, CLLocationManagerDelegate> {
    UIWebView *webView;
    UILabel *typeLable;
    UILabel *activeLabel;
    CLLocationManager *locationManager;
    NSString *eventHandlerName;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *typeLable;
@property (nonatomic, retain) IBOutlet UILabel *activeLabel;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSString *eventHandlerName;

@end
