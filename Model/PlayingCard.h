//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (nonatomic,strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
