//
//  SetCardView.h
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/25/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

//@property (nonatomic) NSUInteger symbol, number, shading, color; // 1..3
@property (nonatomic) NSUInteger number;
@property (nonatomic,strong) NSString *symbol;
@property (nonatomic,strong) NSString *shading;
@property (nonatomic,strong) NSString *color;
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic) CGFloat cornerRadius;
@end
