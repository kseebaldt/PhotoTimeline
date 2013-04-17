#import "PhotoTimelineDataSource.h"
#import "PhotoTimelineCell.h"

static NSString * const photoCellIdentifier = @"PhotoCell";

@implementation PhotoTimelineDataSource

- (void)registerCellsOnCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[PhotoTimelineCell class] forCellWithReuseIdentifier:photoCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTimelineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", indexPath.item + 1]];
    return cell;
}

@end
