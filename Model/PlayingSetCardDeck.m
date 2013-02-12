//
//  PlayingSetCardDeck.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PlayingSetCardDeck.h"
#import "PlayingSetCard.h"

@implementation PlayingSetCardDeck


-(id)init
{
    self = [super init];
    if(self)
    {
        for(NSString *symbol in [PlayingSetCard validSymbol])
        {
            for(NSString *color in [PlayingSetCard validColor]){
                for(NSString *shading in [PlayingSetCard validShading]){
                    for(NSUInteger number=1;number<= [PlayingSetCard maxNumber];number++)
                    {
                        PlayingSetCard *card = [[PlayingSetCard alloc]init];
                        card.number= number;
                        card.symbol = symbol;
                        card.color = color;
                        card.shading=shading;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
        
    }
    return self;
}

@end
