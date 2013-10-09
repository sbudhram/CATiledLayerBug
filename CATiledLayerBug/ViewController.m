//
//  ViewController.m
//  CATiledLayerBug
//
//  Created by Shaun Budhram on 10/9/13.
//  Copyright (c) 2013 Shaun Budhram. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 4.1;
    _scrollView.zoomScale = 2;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    self.contentView = [[UIView alloc] initWithFrame:_scrollView.bounds];
    _contentView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:_contentView];

    CGFloat tileSize = 20.0f;
    CGFloat tileSpacing = 4.0f;

    for (int i = 0; i < 30; i++) {
        for (int j = 0; j < 30; j++) {

            CATiledLayer *tLayer = [CATiledLayer layer];
            tLayer.bounds = CGRectMake(0, 0, tileSize, tileSize);
            tLayer.position = CGPointMake(tileSize/2 + i*(tileSpacing+tileSize), tileSize/2 + j*(tileSpacing+tileSize));
            tLayer.delegate = self;
            tLayer.contentsGravity = kCAGravityResize;
            tLayer.contentsScale = [[UIScreen mainScreen] scale];
            tLayer.masksToBounds = NO;
            tLayer.opacity = 1.0f;
            tLayer.backgroundColor = [UIColor colorWithRed:.2 green:.2 blue:.8 alpha:.5].CGColor;
            tLayer.levelsOfDetail = 3;
            tLayer.levelsOfDetailBias = 3;
            tLayer.tileSize = CGSizeMake(1024., 1024.);
            [_contentView.layer addSublayer:tLayer];

        }
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"Zoom: %f", scrollView.zoomScale);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _contentView;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIImage *drawImage = nil;
    if (_scrollView.zoomScale < 2) {
        drawImage = [UIImage imageNamed:@"low.png"];
        NSLog(@"Drawing - Low");
    }
    else if (_scrollView.zoomScale < 4) {
        drawImage = [UIImage imageNamed:@"med.png"];
        NSLog(@"Drawing - Med");
    }
    else {
        drawImage = [UIImage imageNamed:@"high.png"];
        NSLog(@"Drawing - Hi");
    }
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -layer.bounds.size.height);
    CGContextDrawImage(ctx, layer.bounds, [drawImage CGImage]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"*****************   MEMORY WARNING   *********************");
}



@end
