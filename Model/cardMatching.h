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
-(void ) flipCardAtindex:(NSUInteger)index
usingmode:(NSUInteger)gameMode;
-(NSUInteger)getIndexOfCard:(Card *)card;

-(Card *) cardAtIndex:(NSUInteger)index ;
-(void)deleteCardAtIndexes:(NSIndexSet *)indexSet;
-(NSUInteger)noIfCardsInPlay;
-(void) addCardsFromDeck:(Deck *)deck;
@property (nonatomic,strong) NSString *status;
@property(readonly,nonatomic)int score;
@property(readonly,nonatomic)int deltaScore;
@property(nonatomic,strong) NSArray *selectedCards;
@property(nonatomic,strong)
NSArray *misMatchCards;
@end
