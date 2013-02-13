//
//  CardGameSetViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CardGameSetViewController.h"
#import "PlayingSetCardDeck.h"
#import "cardMatching.h"
#import "PlayingSetCard.h"
#import "Card.h"

@interface CardGameSetViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic)NSUInteger flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,strong) cardMatching *game;
@end

@implementation CardGameSetViewController


-(NSAttributedString *) drawShading:(PlayingSetCard *)card
{
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc]initWithString:[card contents]];
    NSRange wholeString = NSMakeRange(0, [[card contents] length]);
    if([card.shading isEqualToString:@"solid"])
    {
        [newString addAttributes:@{NSForegroundColorAttributeName:[self getColor:card]} range: wholeString   ];
    }
    else if([card.shading isEqualToString:@"open"])
    {
        UIColor *color = [[self getColor:card] colorWithAlphaComponent:0];
        [newString addAttributes:@{NSStrokeColorAttributeName:[self getColor:card],NSStrokeWidthAttributeName:@-5,NSForegroundColorAttributeName:color} range:wholeString];
    }
    else if([card.shading isEqualToString:@"striped"])
    {
        UIColor *color = [[self getColor:card] colorWithAlphaComponent:0.3];
        [newString addAttributes:@{NSForegroundColorAttributeName:color} range:wholeString];
    }
    
    return newString ;
}

-(UIColor *)getColor:(PlayingSetCard *)card
{
    UIColor *colorname;
    if([card.color isEqualToString:@"red"])
        colorname = [UIColor redColor];
    else if ([card.color isEqualToString:@"green"])
        colorname   = [UIColor greenColor];
    else if([card.color isEqualToString:@"purple"])
        colorname = [UIColor purpleColor];
    
    return colorname;
}

-(void)setFlipCount:(NSUInteger)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text= [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    
}

-(cardMatching *)game
{
    if(!_game)
        _game = [[cardMatching alloc]initWithCardCount:[self cardButtons].count usingDeck:[[PlayingSetCardDeck alloc]init]];
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if([card isKindOfClass:[PlayingSetCard class]]){
        NSAttributedString *cardContents= [self drawShading:(PlayingSetCard *)card];
            [cardButton setAttributedTitle:cardContents forState:UIControlStateSelected];
     
                [cardButton setAttributedTitle:cardContents forState:UIControlStateNormal];
           // [cardButton setAttributedTitle:cardContents forState:UIControlStateSelected| UIControlStateDisabled];
        }
        cardButton.selected = card.isFaceup;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = (card.isUnPlayable)? 0.0:1.0;
        if([cardButton isSelected])
            [ cardButton setBackgroundColor:[UIColor yellowColor]];
        else
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
}

- (IBAction)dealButton{
    self.game =nil;
    
    [self game];
    [self updateUI];
    self.flipCount =0;
    self.labelDescription.text = @"New Game";
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)buttonClick:(UIButton *)sender {

     
    [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender] usingmode:self.tabBarController.selectedIndex];
    
    
     NSMutableAttributedString *descriptionString = [self getDescription];
 //   [descriptionString appendAttributedString:[self getCardContentsFromArray:self.game.selectedCards]];
    
    
    self.labelDescription.attributedText = descriptionString;
    self.flipCount++;
    [self updateUI];
}

-(NSMutableAttributedString *) getDescription
{
    
    NSMutableAttributedString *cards = [[NSMutableAttributedString alloc]init    ];
    NSMutableAttributedString *descriptionString ;;
     cards =[self getCardContentsFromArray:self.game.selectedCards];
    if([self.game.status isEqualToString:@"Match"]){
        
       descriptionString =[[NSMutableAttributedString alloc]initWithString:@"Matched "];
        [descriptionString appendAttributedString:cards];
        [descriptionString appendAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"for %d Points",self.game.deltaScore]]];
        self.game.selectedCards =Nil;
    }
    else if([self.game.status isEqualToString:@"Mismatch"])
    {
         
        descriptionString = [self getCardContentsFromArray:self.game.misMatchCards];
        
         [descriptionString appendAttributedString:[ [NSMutableAttributedString alloc]initWithString:@" don't Match"] ];
        [descriptionString appendAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" -%d Points",self.game.deltaScore]]];
     self.game.misMatchCards =Nil;
    }
    else 
    {
       descriptionString =[[NSMutableAttributedString alloc]initWithString:@"Selected "];
        [descriptionString appendAttributedString:cards];
    }
    NSRange range = NSMakeRange(0, [descriptionString length]);
    [descriptionString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} range:range];
    
    return descriptionString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableAttributedString *)getCardContentsFromArray:(NSArray *)arrayOfCards{
 //   NSMutableArray *cardContents = [[NSMutableArray alloc]init];
    NSMutableAttributedString *desc = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *delimiter = [[NSMutableAttributedString alloc]initWithString:@"&"];
    int count = [arrayOfCards count];
    for(PlayingSetCard *card in arrayOfCards)
    {
        if([card isKindOfClass:[PlayingSetCard class]]){
            [desc appendAttributedString:[self drawShading:card] ];
            if(count >1)
            {
                count--;
                [desc appendAttributedString:delimiter];
            }
        }
    }
    return desc;
}






@end
