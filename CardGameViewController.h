//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface CardGameViewController : UIViewController

-(Deck *)createDeck; //abstract
-(NSUInteger) startCardCount; //abstract
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card animate:(BOOL)animate; //abstract
@end
