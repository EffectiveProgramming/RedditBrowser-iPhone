#import "RBSubredditView.h"
#import "RBSubredditTableViewCell.h"
#import "RBRedditItem.h"

@interface RBSubredditView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *redditItems;
@property (nonatomic) NSString *feedName;

@end

@implementation RBSubredditView

@synthesize delegateForView;

static NSString *kRBSubredditViewCellReuseIdentifier = @"RBSubredditViewCellReuseIdentifier";

- (id)initWithFrame:(CGRect)frame navigationItem:(UINavigationItem *)navigationItem {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNavigationItem:navigationItem];
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.rowHeight = [RBSubredditTableViewCell heightForRow];
        _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [_tableView registerClass:[RBSubredditTableViewCell class] forCellReuseIdentifier:kRBSubredditViewCellReuseIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return self;
}

#pragma mark - API

- (void)setItems:(NSArray *)items forSubreddit:(NSString *)feedName {
    _feedName = feedName;
    _redditItems = items;
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Listen To This";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_redditItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:kRBSubredditViewCellReuseIdentifier];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    RBRedditItem *item = _redditItems[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", item.author];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RBRedditItem *item = _redditItems[indexPath.row];
    [self.delegateForView itemWasSelected:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)refreshButtonWasTapped:(UIBarButtonItem *)refreshButton {
    [self.delegateForView refreshButtonWasTapped];
}

#pragma mark - Private

- (void)setupNavigationItem:(UINavigationItem *)navigationItem {
    navigationItem.title = NSLocalizedString(@"SubredditViewController.Title", nil);
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                   target:self
                                                                                   action:@selector(refreshButtonWasTapped:)];
    navigationItem.rightBarButtonItem = refreshButton;
}

@end
