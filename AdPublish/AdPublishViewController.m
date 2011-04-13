//
//  AdPublishViewController.m
//  AdPublish
//
//  Created by Anthony Picciano on 4/5/11.
//  Copyright 2011 Crispin Porter + Bogusky. All rights reserved.
//

#import "AdPublishViewController.h"

@implementation AdPublishViewController
@synthesize webView, typeLable, activeLabel;
@synthesize locationManager, eventHandlerName;

- (void)dealloc
{
    [webView release];
    [typeLable release];
    [activeLabel release];
    [locationManager release];
    [eventHandlerName release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = [[request URL] absoluteString];
    
    static NSString *urlPrefix = @"register://";
    
    if ([url hasPrefix:urlPrefix]) {
        NSString *paramsString = [url substringFromIndex:[urlPrefix length]];
        NSArray *paramsArray = [paramsString componentsSeparatedByString:@"&"];
        int paramsAmount = [paramsArray count];
        
        for (int i = 0; i < paramsAmount; i++) {
            NSArray *keyValuePair = [[paramsArray objectAtIndex:i] componentsSeparatedByString:@"="];
            NSString *key = [keyValuePair objectAtIndex:0];
            NSString *value = nil;
            if ([keyValuePair count] > 1) {
                value = [keyValuePair objectAtIndex:1];
            }
            
            if (key && [key length] > 0) {
                if (value && [value length] > 0) {
                    if ([key isEqualToString:@"type"]) {
                        [typeLable setText:value];
                    }
                    if ([key isEqualToString:@"active"]) {
                        [activeLabel setText:value];
                    }
                    if ([key isEqualToString:@"handler"]) {
                        self.eventHandlerName = value;
                    }
                }
            }
        }
        
        [self performSelector:@selector(updateLocationManager)];
        
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    [self performSelector:@selector(sendEventWithText:) withObject:[newHeading description]];
}

#pragma mark - JS communications

- (void)sendEventWithText:(NSString *)text {
    NSString* script = [NSString stringWithFormat:@"%@('%@');",self.eventHandlerName , text];
    [webView stringByEvaluatingJavaScriptFromString:script];
}

- (void)updateLocationManager {
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    
    if ([typeLable.text isEqualToString:@"compass"]) {
        BOOL active = [[activeLabel.text uppercaseString] isEqualToString:@"TRUE"];
        if (active) {
            [locationManager startUpdatingLocation];
            [locationManager startUpdatingHeading];
        } else {
            [locationManager stopUpdatingLocation];
            [locationManager stopUpdatingHeading];
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
	NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
