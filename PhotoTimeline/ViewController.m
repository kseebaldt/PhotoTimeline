#import "ViewController.h"
#import "PhotoTimelineDataSource.h"

@interface ViewController ()
@property (strong, nonatomic) PhotoTimelineDataSource *dataSource;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.dataSource = [[PhotoTimelineDataSource alloc] init];
    [self.dataSource registerCellsOnCollectionView:self.collectionView];
    self.collectionView.dataSource = self.dataSource;
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
