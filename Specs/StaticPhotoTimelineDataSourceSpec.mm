#import "StaticPhotoTimelineDataSource.h"
#import "PhotoTimelineLayout.h"
#import "PhotoTimelineCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(StaticPhotoTimelineDataSourceSpec)

describe(@"StaticPhotoTimelineDataSource", ^{
    __block StaticPhotoTimelineDataSource *dataSource;
    __block UICollectionView *collectionView;
    __block UICollectionViewFlowLayout *layout;

    beforeEach(^{
        dataSource = [[[StaticPhotoTimelineDataSource alloc] init] autorelease];
        layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
        collectionView = [[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 120, 90) collectionViewLayout:layout] autorelease];
        [dataSource registerCellsOnCollectionView:collectionView];
        collectionView.dataSource = dataSource;
    });
    
    it(@"should have 10 photos", ^{
        [dataSource collectionView:collectionView numberOfItemsInSection:0] should equal(10);
    });
    
    it(@"should return a cell with an image", ^{
        PhotoTimelineCell *cell = (PhotoTimelineCell *)[dataSource collectionView:collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        cell should be_instance_of([PhotoTimelineCell class]);
        cell.image should_not be_nil;
    });
});

SPEC_END
