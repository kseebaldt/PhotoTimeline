#import "StaticPhotoTimelineDataSource.h"
#import "PhotoTimelineCell.h"

static NSString * const photoCellIdentifier = @"PhotoCell";

@implementation StaticPhotoTimelineDataSource

- (void)registerCellsOnCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[PhotoTimelineCell class] forCellWithReuseIdentifier:photoCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTimelineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", indexPath.item + 1];
    cell.image = [UIImage imageNamed:imageName];
    return cell;
}

@end
