//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Ujwal Manjunath on 2/20/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property(nonatomic) NSUInteger rank;
@property(nonatomic,strong) NSString *suit;

@property(nonatomic) BOOL faceUp;
@end
