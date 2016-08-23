// CBScrollViewDelegate.m
// Copyright (c) 2016 陈超邦.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CBScrollViewDelegate.h"

@implementation CBScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_realDelegate scrollViewDidScroll:scrollView];
    }
    if (_cb_scrollViewDidScrollBlock) {
        _cb_scrollViewDidScrollBlock(scrollView);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_realDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
    if (_cb_scrollViewDidEndScrollingAnimationBlock) {
        _cb_scrollViewDidEndScrollingAnimationBlock(scrollView);
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_realDelegate scrollViewWillEndDragging:scrollView
                                    withVelocity:velocity
                             targetContentOffset:targetContentOffset];
    }
    if (_cb_scrollViewWillEndDraggingBlock) {
        _cb_scrollViewWillEndDraggingBlock(scrollView, velocity, targetContentOffset);
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [_realDelegate scrollViewDidZoom:scrollView];
    }
    if (_cb_scrollViewDidZoomBlock) {
        _cb_scrollViewDidZoomBlock(scrollView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_realDelegate scrollViewWillBeginDragging:scrollView];
    }
    if (_cb_scrollViewWillBeginDraggingBlock) {
        _cb_scrollViewWillBeginDraggingBlock(scrollView);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_realDelegate scrollViewDidEndDragging:scrollView
                                 willDecelerate:decelerate];
    }
    if (_cb_scrollViewDidEndDraggingBlock) {
        _cb_scrollViewDidEndDraggingBlock(scrollView, decelerate);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [_realDelegate scrollViewWillBeginDecelerating:scrollView];
    }
    if (_cb_scrollViewWillBeginDeceleratingBlock) {
        _cb_scrollViewWillBeginDeceleratingBlock(scrollView);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_realDelegate scrollViewDidEndDecelerating:scrollView];
    }
    if (_cb_scrollViewDidEndDeceleratingBlock) {
        _cb_scrollViewDidEndDeceleratingBlock(scrollView);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    UIView *view;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        view = [_realDelegate viewForZoomingInScrollView:scrollView];
    }else {
        if (_cb_viewForZoomingInScrollViewBlock) {
            view = _cb_viewForZoomingInScrollViewBlock(scrollView);
        }
    }
    return view;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view  {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [_realDelegate scrollViewWillBeginZooming:scrollView
                                         withView:view];
    }
    if (_cb_scrollViewWillBeginZoomingBlock) {
        _cb_scrollViewWillBeginZoomingBlock(scrollView, view);
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [_realDelegate scrollViewDidEndZooming:scrollView
                                      withView:view
                                       atScale:scale];
    }
    if (_cb_scrollViewDidEndZoomingBlock) {
        _cb_scrollViewDidEndZoomingBlock(scrollView, view, scale);
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    BOOL should = YES;
    
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        should = [_realDelegate scrollViewShouldScrollToTop:scrollView];
    }
    
    if (_cb_scrollViewShouldScrollToTopBlock) {
        should &= _cb_scrollViewShouldScrollToTopBlock(scrollView);
    }
    
    return should;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_realDelegate && [_realDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_realDelegate scrollViewDidScrollToTop:scrollView];
    }
    if (_cb_scrollViewDidScrollToTopBlock) {
        _cb_scrollViewDidScrollToTopBlock(scrollView);
    }
}

@end
