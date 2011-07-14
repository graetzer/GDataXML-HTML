//
//  GDataXML_HTMLAppDelegate.h
//  GDataXML-HTML
//
//  Created by Simon Grätzer on 14.07.11.
//  Copyright 2011 Cyber:con GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDataXML_HTMLViewController;

@interface GDataXML_HTMLAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GDataXML_HTMLViewController *viewController;

@end
