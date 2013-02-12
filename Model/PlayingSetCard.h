//
//  PlayingSetCard.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "Card.h"

@interface PlayingSetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic,strong) NSString *symbol;
@property (nonatomic,strong) NSString *shading;
@property (nonatomic,strong) NSString *color;
+(NSArray *)validSymbol;
+(NSUInteger)maxNumber;
+(NSArray *)validShading;
+(NSArray *)validColor;
@end
