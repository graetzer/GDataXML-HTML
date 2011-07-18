//
//  GDataXML_HTMLViewController.m
//  GDataXML-HTML
//
//  Created by Simon Grätzer on 14.07.11.
//  Copyright 2011 Cyber:con GmbH. All rights reserved.
//

#import "GDataXML_HTMLViewController.h"
#import "lib/GDataXMLNode.h"

@implementation GDataXML_HTMLViewController
@synthesize textView;

- (void)dealloc
{
    [textView release];
    [super dealloc];
}

- (void)print:(NSString *)string {
    self.textView.text = [self.textView.text stringByAppendingString:string];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)startXMLParsing:(id)sender {
    self.textView.text = @"";
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xml" ofType:@"xml"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:[NSData dataWithContentsOfFile:path] options:0 error:NULL];
    if (doc) {
        [self print:@"\nParse XML with XPath andd print out every employe:\n\n"];
        NSArray *employees = [doc nodesForXPath:@"//employe" error:NULL];
        for (GDataXMLElement *employe in employees) {
            [self print:[employe stringValue]];[self print:@"\n"];
        }
    }
    [doc release];
}

- (IBAction)startHTMLParsing {
    self.textView.text = @"";
    NSString *path = [[NSBundle mainBundle]pathForResource:@"html" ofType:@"html"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithHTMLData:[NSData dataWithContentsOfFile:path] options:0 error:NULL];
    if (doc) {
        [self print:@"\nLoad non valid HTML file and convert it to valid XML:\n\n"];
        [self print:[[doc rootElement] XMLString]];
    }
    [doc release];
}
@end
