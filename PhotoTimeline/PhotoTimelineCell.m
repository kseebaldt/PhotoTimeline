#import "PhotoTimelineCell.h"

@interface PhotoTimelineCell ()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation PhotoTimelineCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

@end
