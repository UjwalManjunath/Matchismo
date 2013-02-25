//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/25/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"
@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
