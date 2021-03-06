#import "RBSubredditViewController.h"

#import "RBSubredditRouter.h"
#import "RBSubredditModel.h"
#import "RBSubredditView.h"
#import "RBSubredditManager.h"
#import "RBNetworkService.h"
#import "RBPersistenceService.h"
#import "RBPersistenceServiceFactory.h"

@interface RBSubredditViewController ()

@property (nonatomic) RBSubredditRouter *subredditRouter;
@property (nonatomic) RBSubredditModel *subredditModel;
@property (nonatomic) RBSubredditView *subredditView;

@end

@implementation RBSubredditViewController

- (void)loadView {
    [super loadView];
    
    RBPersistenceServiceFactory *persistenceServiceFactory = [RBPersistenceServiceFactory persistenceServiceFactory];
    RBNetworkService *networkService = [RBNetworkService networkService];
    RBSubredditManager *feedManager = [[RBSubredditManager alloc] initWithNetworkService:networkService
                                                                 persistenceServiceFactory:persistenceServiceFactory];
    _subredditModel = [[RBSubredditModel alloc] initWithSubredditManager:feedManager];
    _subredditView = [[RBSubredditView alloc] initWithFrame:self.view.bounds navigationItem:self.navigationItem];
    _subredditRouter = [[RBSubredditRouter alloc] initWithModel:_subredditModel view:_subredditView];
    
    [self.view addSubview:_subredditView];
}

@end
