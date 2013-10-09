//
//  ViewController.h
//  CATiledLayerBug
//
//  Created by Shaun Budhram on 10/9/13.
//  Copyright (c) 2013 Shaun Budhram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>


@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;

@end
