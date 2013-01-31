//
//  Deck.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

-(void) addCard: (Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;

@end
