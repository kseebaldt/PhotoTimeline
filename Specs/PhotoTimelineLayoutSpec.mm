#import "PhotoTimelineLayout.h"
#import "StaticPhotoTimelineDataSource.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface PhotoTimelineLayoutSpecDataSource : NSObject <UICollectionViewDataSource>
@property (assign, nonatomic) NSInteger numberOfCells;
@end

@implementation PhotoTimelineLayoutSpecDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfCells;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Spec" forIndexPath:indexPath];
    return cell;
}

@end

SPEC_BEGIN(PhotoTimelineLayoutSpec)

describe(@"PhotoTimelineLayout", ^{
    __block PhotoTimelineLayout *layout;
    __block UICollectionView *collectionView;
    __block PhotoTimelineLayoutSpecDataSource *dataSource;

    beforeEach(^{
        layout = [[PhotoTimelineLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 250, 200) collectionViewLayout:layout];
        dataSource = [[PhotoTimelineLayoutSpecDataSource alloc] init];
        dataSource.numberOfCells = 10;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Spec"];
        collectionView.dataSource = dataSource;
    });

    it(@"should return the bounds of all cells in a horizontal flow", ^{
        layout.collectionViewContentSize should equal(CGSizeMake(1000, 200));
    });

    describe(@"layoutAttributesForElementsInRect:", ^{
        describe(@"at the leftmost edge of the view", ^{
            __block NSArray *attributes;
            beforeEach(^{
                attributes = [layout layoutAttributesForElementsInRect:collectionView.bounds];
            });

            it(@"should return attributes for the visible cells", ^{
                attributes.count should equal(3);
            });

            it(@"should set the frame for the first visible cell", ^{
                [attributes[0] frame] should equal(CGRectMake(0, 0, 100, 100));
            });

            it(@"should set the frame for the second visible cell", ^{
                [attributes[1] frame] should equal(CGRectMake(100, 0, 100, 100));
            });

            it(@"should set the frame for the third visible cell", ^{
                [attributes[2] frame] should equal(CGRectMake(200, 0, 100, 100));
            });
        });
    });

    describe(@"layoutAttributeForItemAtIndexPath:", ^{
        it(@"should set the frame for the first cell", ^{
            UICollectionViewLayoutAttributes *attrs = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            attrs.frame should equal(CGRectMake(0, 0, 100, 100));
        });

        it(@"should set the frame for the second cell", ^{
            UICollectionViewLayoutAttributes *attrs = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
            attrs.frame should equal(CGRectMake(100, 0, 100, 100));
        });

        it(@"should set the frame for the last cell", ^{
            UICollectionViewLayoutAttributes *attrs = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:9 inSection:0]];
            attrs.frame should equal(CGRectMake(900, 0, 100, 100));
        });

    });
});

SPEC_END
