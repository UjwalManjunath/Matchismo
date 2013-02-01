//
//  Card.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic,strong)NSString *contents;

@property(nonatomic,getter = isFaceup) BOOL faceUp;
@property(nonatomic,getter = isUnPlayable) BOOL unPlayable;

-(int) match:(NSArray *)otherCards;

@end
