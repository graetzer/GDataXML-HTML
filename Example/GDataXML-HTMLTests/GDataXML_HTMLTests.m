#import "GDataXMLNode.h"
#import <XCTest/XCTest.h>

@interface GDataXML_HTMLTests : XCTestCase

@end

@implementation GDataXML_HTMLTests

- (void)testGDataXMLNodeXPathShouldWork
{
    NSString* xml = @"<doc>                         \
    <node attr=\"val1\"/>       \
    <node attr=\"val2\"/>       \
    </doc>";
    
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithXMLString:xml error:NULL];
    XCTAssertNotNil(doc,@"Document should be created");
    
    NSError* error;
    NSArray* nodes = [doc nodesForXPath:@"//node[@attr=\"val1\"]" error:&error];
    XCTAssertNil(error,@"There should be no errors");
    XCTAssertNotNil(nodes,@"XPath should fidn a node");
    XCTAssertEqual(nodes.count, (NSUInteger)1,@"There should be only one node found");
    NSString* foundValue = [[nodes[0] attributeForName:@"attr"] stringValue];
    XCTAssertEqualObjects(foundValue, @"val1",@"Value should be right for attribute");
}

- (void)testGDataXMLNodeXPathForHTMLShouldWork
{
    NSString* docString = @"<doc aa>                         \
    <node attr=\"val1\"/>        \
    <node attr=\"val2\"/>        \
    <node attr=\"val3\">         \
    </doc>";
    
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithXMLString:docString error:NULL];
    XCTAssertNil(doc,@"String is not valid XML, creating document should fail");
    doc = [[GDataXMLDocument alloc] initWithHTMLString:docString error:NULL];
    XCTAssertNotNil(doc,@"Document should be created");
    
    NSError* error;
    NSArray* nodes = [doc nodesForXPath:@"//node[@attr=\"val1\"]" error:&error];
    XCTAssertNil(error,@"There should be no errors");
    XCTAssertNotNil(nodes,@"XPath should fidn a node");
    XCTAssertEqual(nodes.count, (NSUInteger)1,@"There should be only one node found");
    NSString* foundValue = [[nodes[0] attributeForName:@"attr"] stringValue];
    XCTAssertEqualObjects(foundValue, @"val1",@"Value should be right for attribute");
}
- (void)testGDataXMLNodeXPathShouldReturnRoot
{
    // XML
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithXMLString:@"<doc/>" error:NULL];
    XCTAssertEqual([doc nodesForXPath:@"//doc" error:NULL].count,(NSUInteger)1,@"1.1: Works, 1.2: Works");
    XCTAssertEqual([doc nodesForXPath:@"/doc" error:NULL].count,(NSUInteger)1, @"1.1: Works, 1.2: Works");
    XCTAssertEqual([doc nodesForXPath:@"doc" error:NULL].count,(NSUInteger)1,  @"1.1: Works, 1.2: Fails");
    
    // HTML
    doc = [[GDataXMLDocument alloc] initWithHTMLString:@"<html/>" error:NULL];
    XCTAssertEqual([doc nodesForXPath:@"//html" error:NULL].count,(NSUInteger)1,@"1.1: Works, 1.2: Works");
    XCTAssertEqual([doc nodesForXPath:@"/html" error:NULL].count,(NSUInteger)1, @"1.1: Fails, 1.2: Fails");
    XCTAssertEqual([doc nodesForXPath:@"html" error:NULL].count,(NSUInteger)1,  @"1.1: Fails, 1.2: Fails");
}


@end
