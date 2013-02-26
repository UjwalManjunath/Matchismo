//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

#import "cardMatching.h"
@interface CardGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property(nonatomic,strong) cardMatching *game;
-(Deck *)createDeck; //abstract
-(NSUInteger) startCardCount; //abstract
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card animate:(BOOL)animate; //abstract
-(NSString *) reuseIdentifier; //abstract
@end
