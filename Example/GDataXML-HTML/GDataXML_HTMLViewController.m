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

- (void)print:(NSString *)string {
    self.textView.text = [self.textView.text stringByAppendingString:string];
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)runXPathTests:(id)sender {
    self.textView.text = nil;
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithHTMLString:@"<doc></doc>" error:NULL];
    [doc nodesForXPath:@"//doc" error:NULL];

    GDataXMLDocument* doc1 = [[GDataXMLDocument alloc] initWithXMLString:@"<doc/>" error:NULL];
    NSAssert([doc1 nodesForXPath:@"//doc" error:NULL].count == 1,@"1.1: Works, 1.2: Works");
    NSAssert([doc1 nodesForXPath:@"/doc" error:NULL].count == 1, @"1.1: Works, 1.2: Works");
    NSAssert([doc1 nodesForXPath:@"doc" error:NULL].count == 1,  @"1.1: Works, 1.2: Fails");
    
    [self print:@"\nNo crash, seems to work"];
}

- (IBAction)startXMLParsing:(id)sender {
    self.textView.text = @"";
    NSString *path = [[NSBundle mainBundle]pathForResource:@"xml" ofType:@"xml"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding  error:NULL];
    if (doc) {
        [self print:@"\nParse XML with XPath and print out every employe:\n\n"];
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
