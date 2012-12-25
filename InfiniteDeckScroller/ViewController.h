//
//  ViewController.h
//  InfiniteDeckScroller
//
//  Created by Wibbitz on 12/24/12.
//  Copyright (c) 2012 Cohen72. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDeckViewController.h"

@interface ViewController : UIViewController <CardDeckDataSource, CardDeckDelegate, UIScrollViewDelegate>

@end
