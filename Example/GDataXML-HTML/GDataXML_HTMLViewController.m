/* Copyright (c) 2011 Simon Grätzer simon@graetzer.org

 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#import "GDataXML_HTMLViewController.h"
#import "GDataXMLNode.h"

@implementation GDataXML_HTMLViewController
@synthesize textView;


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
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding  error:NULL];
    if (doc) {
        [self print:@"\nParse XML with XPath andd print out every employe:\n\n"];
        NSArray *employees = [doc nodesForXPath:@"//employe" error:NULL];
        for (GDataXMLElement *employe in employees) {
            [self print:[employe stringValue]];[self print:@"\n"];
        }
    }
}

- (IBAction)startHTMLParsing {
    self.textView.text = @"";
    NSString *path = [[NSBundle mainBundle]pathForResource:@"html" ofType:@"html"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithHTMLData:[NSData dataWithContentsOfFile:path] error:NULL];
    if (doc) {
        [self print:@"\nLoad non valid HTML file and convert it to valid XML:\n\n"];
        [self print:[[doc rootElement] XMLString]];
    }
}
@end
