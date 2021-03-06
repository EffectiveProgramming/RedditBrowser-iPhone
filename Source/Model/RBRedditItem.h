#import <Foundation/Foundation.h>

@interface RBRedditItem : NSObject

@property (nonatomic) NSString *subreddit;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *permalink;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *uuid;

+ (NSArray *)itemsForJSONFeed:(NSDictionary *)jsonDictionary;

@end
