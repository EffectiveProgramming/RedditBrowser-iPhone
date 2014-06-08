#import <XCTest/XCTest.h>
#import "RBSubredditItem.h"

@interface RBSubredditItemTests : XCTestCase

@end

@implementation RBSubredditItemTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatProperSubredditItemsAreCreatedFromValidJSON {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ListenToThis" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *jsonFeedAsDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    NSArray *items = [RBSubredditItem itemsForJSONFeed:jsonFeedAsDictionary];
    
    NSInteger expectedItemCount = 25;
    XCTAssertEqual([items count], expectedItemCount);
    
    RBSubredditItem *item = items[0];
    XCTAssertEqualObjects(item.title, @"Charanjit Singh - Raga Bhupali [Synthesized Indian Classical Acid House] (1982)");

    item = items[1];
    XCTAssertEqualObjects(item.title, @"Mree -- Such Great Heights [Folk] (2010) Just...Wow Not sure of the genre.");
    
    // ... etc
}

@end
