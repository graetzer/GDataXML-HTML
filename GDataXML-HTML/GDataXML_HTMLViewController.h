//
//  GDataXML_HTMLViewController.h
//  GDataXML-HTML
//
//  Created by Simon Grätzer on 14.07.11.
//  Copyright 2011 Cyber:con GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDataXML_HTMLViewController : UIViewController {
    
    UITextView *textView;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;

- (IBAction)startXMLParsing:(id)sender;
- (IBAction)startHTMLParsing;

@end
