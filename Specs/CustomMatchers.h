#import <CoreGraphics/CoreGraphics.h>


namespace Cedar { namespace Matchers { namespace Comparators {
    template<typename U>
    bool compare_equal(const CGRect & actualValue, const U & expectedValue) {
        return CGRectEqualToRect(actualValue, expectedValue);
    }

    template<typename U>
    bool compare_equal(const CGPoint & actualValue, const U & expectedValue) {
        return CGPointEqualToPoint(actualValue, expectedValue);
    }

    template<typename U>
    bool compare_equal(const CGSize & actualValue, const U & expectedValue) {
        return CGSizeEqualToSize(actualValue, expectedValue);
    }

    template<typename U>
    bool compare_equal(const CGAffineTransform & actualValue, const U & expectedValue) {
        return CGAffineTransformEqualToTransform(actualValue, expectedValue);
    }
}}}

namespace Cedar { namespace Matchers { namespace Stringifiers {
    inline NSString * string_for(const CGRect & value) {
#if TARGET_OS_IPHONE
        return NSStringFromCGRect(value);
#else
        return NSStringFromRect((NSRect)value);
#endif
    }

    inline NSString * string_for(const CGPoint & value) {
#if TARGET_OS_IPHONE
        return NSStringFromCGPoint(value);
#else
        return NSStringFromPoint((NSPoint)value);
#endif

    }

    inline NSString * string_for(const CGSize & value) {
#if TARGET_OS_IPHONE
        return NSStringFromCGSize(value);
#else
        return NSStringFromSize((NSSize)value);
#endif
    }

    inline NSString * string_for(const CGAffineTransform & value) {
#if TARGET_OS_IPHONE
        return NSStringFromCGAffineTransform(value);
#else
        return [NSString stringWithFormat:@"[%f, %f, %f, %f, %f, %f]", value.a, value.b, value.c, value.d, value.tx, value.ty];
#endif
    }
}}}
