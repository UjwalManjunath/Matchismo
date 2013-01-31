//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/31/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@interface PlayingCardDeck()

@end

@implementation PlayingCardDeck

-(id)init
{
    self = [super init];
    if(self){
        for(NSString *suit in [PlayingCard validSuits])
            for(NSUInteger rank=1;rank <=[PlayingCard maxRank];rank++)
            {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
    }
    return self;
}





@end
