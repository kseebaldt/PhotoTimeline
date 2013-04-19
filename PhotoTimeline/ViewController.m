#import "ViewController.h"
#import "StaticPhotoTimelineDataSource.h"
#import "PhotoTimelineLayout.h"

@interface ViewController ()
@property (strong, nonatomic) StaticPhotoTimelineDataSource *dataSource;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PhotoTimelineLayout *layout = [[PhotoTimelineLayout alloc] init];
    layout.itemSize = CGSizeMake(200, 200);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.dataSource = [[StaticPhotoTimelineDataSource alloc] init];
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
