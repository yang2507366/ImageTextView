//
//  ImageTextView.m
//  ImageTextView
//
//  Created by yangzexin on 6/20/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "ImageTextView.h"

@interface ImageTextView () <UITextViewDelegate>

@property(nonatomic, assign)id<UITextViewDelegate> customDelegate;
@property(nonatomic, retain)UIScrollView *imageScrollView;

@end

@implementation ImageTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.imageScrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
    self.imageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.imageScrollView];
    
    return self;
}

- (void)insertImage:(UIImage *)image code:(NSString *)code
{
    NSMutableString *blanks = [NSMutableString string];
    NSInteger numOfBlanks = (self.font.lineHeight + 2) / 4;
    for(NSInteger i = 0; i < numOfBlanks; ++i){
        [blanks appendString:@" "];
    }
    NSRange range = NSMakeRange(self.text.length, blanks.length);
    [self insertText:blanks];
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate
{
    [super setDelegate:self];
    self.customDelegate = delegate;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([self.customDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]){
        return [self.customDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if([self.customDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]){
        return [self.customDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.customDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]){
        [self.customDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([self.customDelegate respondsToSelector:@selector(textViewDidEndEditing:)]){
        [self.customDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([self.customDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
        return [self.customDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if([self.customDelegate respondsToSelector:@selector(textViewDidChange:)]){
        [self.customDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if([self.customDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]){
        [self.customDelegate textViewDidChangeSelection:textView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.customDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [self.customDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if([self.customDelegate respondsToSelector:@selector(scrollViewDidZoom:)]){
        [self.customDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([self.customDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [self.customDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if([self.customDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]){
        [self.customDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if([self.customDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        [self.customDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return nil;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
}

@end
