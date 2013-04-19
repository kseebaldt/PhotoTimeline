#import "ViewController.h"
#import "StaticPhotoTimelineDataSource.h"
#import "PhotoTimelineLayout.h"
#import "LineView.h"

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
    [layout registerClass:[LineView class] forDecorationViewOfKind:@"Line"];
    [layout registerClass:[LineView class] forDecorationViewOfKind:@"PhotoLine"];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.bounds), 600) collectionViewLayout:layout];
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
