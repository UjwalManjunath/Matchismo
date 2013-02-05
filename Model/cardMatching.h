//
//  cardMatching.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/31/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface cardMatching : NSObject

//designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck;
-(NSString *) flipCardAtindex:(NSUInteger)index
usingmode:(NSUInteger)gameMode;

-(Card *) cardAtIndex:(NSUInteger)index ;

@property(readonly,nonatomic)int score;
@end
