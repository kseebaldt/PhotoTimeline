#import "PhotoTimelineCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(PhotoTimelineCellSpec)

describe(@"PhotoTimelineCell", ^{
    __block PhotoTimelineCell *cell;

    beforeEach(^{
        cell = [[PhotoTimelineCell alloc] initWithFrame:CGRectMake(0, 0, 100, 120)];
    });
    
    it(@"should have an image if you set it", ^{
        UIImage *image = [UIImage imageNamed:@"image1.jpg"];
        cell.image = image;
        [[cell subviews] lastObject] should be_instance_of([UIImageView class]);
        UIImageView *imageView = [[cell subviews] lastObject];
        imageView.image should equal(image);
    });
});

SPEC_END
