#import "PhotoTimelineLayout.h"

@implementation PhotoTimelineLayout

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(50, 50);
    }
    return self;
}

#pragma mark - UICollectionViewLayout

- (CGSize)collectionViewContentSize {
    return CGSizeMake([self.collectionView numberOfItemsInSection:0] * self.itemSize.width, CGRectGetHeight(self.collectionView.bounds));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger startIndex = MAX(floorf(CGRectGetMinX(rect) / self.itemSize.width), 0);
    NSInteger endIndex = MIN(floorf(CGRectGetMaxX(rect) / self.itemSize.width), [self.collectionView numberOfItemsInSection:0]);
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:endIndex - startIndex];
    for (int i = startIndex; i <= endIndex; ++i) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [attributes addObject:attr];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(self.itemSize.width * indexPath.row, 0, self.itemSize.width, self.itemSize.height);
    return attr;
}

@end
