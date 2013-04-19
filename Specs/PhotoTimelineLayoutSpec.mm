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
    __block CGFloat topY, bottomY;

    beforeEach(^{
        layout = [[PhotoTimelineLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 250, 300) collectionViewLayout:layout];
        dataSource = [[PhotoTimelineLayoutSpecDataSource alloc] init];
        dataSource.numberOfCells = 10;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Spec"];
        collectionView.dataSource = dataSource;
        [layout prepareLayout];
        topY = CGRectGetMidY(collectionView.bounds) - layout.itemSize.height - 20 - 2;
        bottomY = CGRectGetMidY(collectionView.bounds) + 20 + 2;
    });

    it(@"should return the bounds of all cells in a horizontal flow", ^{
        layout.collectionViewContentSize should equal(CGSizeMake(750, 300));
    });

    describe(@"layoutAttributesForElementsInRect:", ^{
        describe(@"at the leftmost edge of the view", ^{
            __block NSArray *attributes;
            beforeEach(^{
                attributes = [layout layoutAttributesForElementsInRect:collectionView.bounds];
            });

            describe(@"cell attributes", ^{
                __block NSArray *cellAttributes;
                beforeEach(^{
                    cellAttributes = [attributes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"representedElementCategory = %d", UICollectionElementCategoryCell]];
                });

                it(@"should return attributes for the visible cells", ^{
                    cellAttributes.count should equal(5);
                });

                it(@"should set the frame for the first visible cell", ^{
                    [cellAttributes[0] frame] should equal(CGRectMake(10, topY, 100, 100));
                });

                it(@"should set the frame for the second visible cell", ^{
                    [cellAttributes[1] frame] should equal(CGRectMake(10 + 70, bottomY, 100, 100));
                });

                it(@"should set the frame for the last visible cell", ^{
                    [cellAttributes[4] frame] should equal(CGRectMake(10 + (70 * 4), topY, 100, 100));
                });
            });

            describe(@"decoration attributes", ^{
                __block NSArray *cellAttributes;
                beforeEach(^{
                    cellAttributes = [attributes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"representedElementCategory = %d", UICollectionElementCategoryDecorationView]];
                });

                it(@"should return attributes for the visible decorations", ^{
                    cellAttributes.count should equal(5 + 1);
                });

                it(@"should set the frame for the horizontal timeline", ^{
                    [cellAttributes[0] representedElementKind] should equal(@"Line");
                    [cellAttributes[0] frame] should equal(CGRectMake(10, 148, 700, 4));
                });

                it(@"should set the frame for the first vertical line", ^{
                    [cellAttributes[1] representedElementKind] should equal(@"PhotoLine");
                    [cellAttributes[1] frame] should equal(CGRectMake(10 + 50 - 2, 128, 4, 20));
                });

                it(@"should set the frame for the second vertical line", ^{
                    [cellAttributes[2] representedElementKind] should equal(@"PhotoLine");
                    [cellAttributes[2] frame] should equal(CGRectMake(10 + 50 + 70 - 2, 152, 4, 20));
                });
            });


        });
    });

    describe(@"layoutAttributeForItemAtIndexPath:", ^{
        it(@"should set the frame for the first cell", ^{
            UICollectionViewLayoutAttributes *attrs = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            attrs.frame should equal(CGRectMake(10, topY, 100, 100));
        });

        it(@"should set the frame for the second cell", ^{
            UICollectionViewLayoutAttributes *attrs = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
            attrs.frame should equal(CGRectMake(10 + 70, bottomY, 100, 100));
        });

        it(@"should set the frame for the last cell", ^{
            UICollectionViewLayoutAttributes *attrs = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:9 inSection:0]];
            attrs.frame should equal(CGRectMake(10 + (70 * 9), bottomY, 100, 100));
        });

    });
});

SPEC_END
