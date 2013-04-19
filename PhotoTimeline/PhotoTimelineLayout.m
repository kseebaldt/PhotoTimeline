#import "PhotoTimelineLayout.h"

@interface PhotoTimelineLayout ()
@property (assign, nonatomic) CGFloat itemMargin;
@property (assign, nonatomic) CGFloat itemSpacing;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGRect lineFrame;
@end

@implementation PhotoTimelineLayout

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(50, 50);
        self.itemMargin = 10;
        self.lineFrame = CGRectZero;
        self.lineSpacing = 20;
    }
    return self;
}

#pragma mark - UICollectionViewLayout

- (void)prepareLayout {
    self.itemSpacing = roundf(self.itemSize.width / 2) + 20;
    self.lineFrame = CGRectMake(self.itemMargin, CGRectGetMidY(self.collectionView.bounds) - 2
                                , [self.collectionView numberOfItemsInSection:0] * self.itemSpacing, 4);
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(MAX(([self.collectionView numberOfItemsInSection:0] - 1), 0) * (self.itemSpacing) + (self.itemMargin * 2) + self.itemSize.width, CGRectGetHeight(self.collectionView.bounds));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger startIndex = MAX(floorf(CGRectGetMinX(rect) / self.itemSpacing), 0);
    NSInteger endIndex = MIN(floorf(CGRectGetMaxX(rect) / self.itemSpacing) + 1, [self.collectionView numberOfItemsInSection:0] - 1);
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:endIndex - startIndex];

    [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"Line" atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];

    for (int i = startIndex; i <= endIndex; ++i) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [attributes addObject:attr];

        [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"PhotoLine" atIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat yOffset = (indexPath.row % 2) == 0 ? CGRectGetMinY(self.lineFrame) - self.lineSpacing - self.itemSize.height : CGRectGetMaxY(self.lineFrame) + self.lineSpacing;
    attr.frame = CGRectMake(self.itemMargin + self.itemSpacing * indexPath.row, yOffset, self.itemSize.width, self.itemSize.height);
    return attr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    if ([decorationViewKind isEqualToString:@"Line"]) {
        attrs.frame = self.lineFrame;
    } else if ([decorationViewKind isEqualToString:@"PhotoLine"]) {
        CGFloat yOffset = (indexPath.row % 2) == 0 ? CGRectGetMinY(self.lineFrame) - self.lineSpacing : CGRectGetMaxY(self.lineFrame);
        attrs.frame = CGRectMake(self.itemMargin + self.itemSpacing * indexPath.row + (self.itemSize.width / 2) - 2, yOffset, 4, self.lineSpacing);
    }
    return attrs;
}

@end
