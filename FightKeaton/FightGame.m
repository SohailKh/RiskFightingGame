//
//  FightGame.m
//  FightKeaton
//
//  Created by Sohail Khanifar on 2/4/15.
//  Copyright (c) 2015 Sohail Khanifar. All rights reserved.
//

#import "FightGame.h"

@implementation FightGame

- (id)init
{
    self = [super init];
    if (self) {
        _attackingTeamSoldierCount = arc4random_uniform(29) + 1;
        _defendingTeamSoldierCount = arc4random_uniform(29) + 1;
    }
    return self;
}

-(void)attackDefendingTeam
{
    NSInteger attackingDiceCount = [self numberOfAllowedAttackingDice];
    NSInteger defendingDiceCount = [self numberOfAllowedDefendingDice];
    
    NSArray* attackingDiceResults = [self returnDiceResults:attackingDiceCount];
    NSArray* defendingDiceResults = [self returnDiceResults:defendingDiceCount];
    
    NSInteger defenseLoss = 0;
    NSInteger attackLoss = 0;
    if (defendingDiceResults[0] >= attackingDiceResults[0]){
        attackLoss = attackLoss + 1;
        
    } else {defenseLoss = defenseLoss + 1;}
    
    if (defendingDiceResults.count > 1 && attackingDiceResults.count > 1){
        if (defendingDiceResults[1] >= attackingDiceResults[1]){
            attackLoss = attackLoss + 1;
        } else {
            defenseLoss = defenseLoss + 1;}}

    self.attackingTeamSoldierCount = self.attackingTeamSoldierCount - attackLoss;
    self.defendingTeamSoldierCount = self.defendingTeamSoldierCount - defenseLoss;
    
    self.turnResults = @{@"attack":
                                  @{@"roll": attackingDiceResults,
                                    @"loss":[NSNumber numberWithInteger:attackLoss]},
                              @"defense":
                                  @{@"roll":defendingDiceResults,
                                    @"loss": [NSNumber numberWithInteger:defenseLoss]}
                              };
    
}



-(NSInteger)numberOfAllowedAttackingDice
{
    if (self.attackingTeamSoldierCount > 3){
        return 3;
    } else if (self.attackingTeamSoldierCount == 3) {
        return 2;
    } else if (self.attackingTeamSoldierCount == 2) {
        return 1;
    } else {
        return 0;
    }
}

-(NSInteger)numberOfAllowedDefendingDice
{
    if (self.defendingTeamSoldierCount >= 2){
        return 2;
    } else if (self.defendingTeamSoldierCount == 1) {
        return 1;
    } else {
        return 0;
    }
    
}

-(NSArray*)returnDiceResults:(NSInteger)numOfDice
{
    NSArray* diceResults = [NSArray array];
    for (int i = 0; i < numOfDice; i++){
        diceResults = [diceResults arrayByAddingObject:[self rollDice]];
    }
    return [self sortDiceResultArray:diceResults];
}

-(NSArray*)sortDiceResultArray:(NSArray*)diceResultsarray
{
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
    return [diceResultsarray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
}
-(NSNumber*)rollDice
{
    NSInteger result = arc4random_uniform(5) + 1; // + 1 is so we don't get 0 dice results
    return [NSNumber numberWithInteger:result];
}

-(NSString*)diceResultsFor:(NSString*)teamKey
{
    NSArray* diceResultsArray = [[self.turnResults objectForKey:teamKey] objectForKey:@"roll"];
    NSString* resultString = @"";
    
    for (NSNumber* num in diceResultsArray) { // Combine diceresults array to string
        resultString = [NSString stringWithFormat:@" %@ %@", resultString, num.stringValue];
    }
    return resultString;
}

-(NSString*)lossFor:(NSString*)teamKey
{
    NSNumber* loss = [[self.turnResults objectForKey:teamKey] objectForKey:@"loss"];
    return loss.stringValue;
}


@end
