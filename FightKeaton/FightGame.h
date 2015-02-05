//
//  FightGame.h
//  FightKeaton
//
//  Created by Sohail Khanifar on 2/4/15.
//  Copyright (c) 2015 Sohail Khanifar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FightGame : NSObject

@property (nonatomic) NSInteger attackingTeamSoldierCount;
@property (nonatomic) NSInteger defendingTeamSoldierCount;
@property (strong,nonatomic) NSDictionary* turnResults;
-(void)attackDefendingTeam;
-(NSString*)diceResultsFor:(NSString*)teamKey;
-(NSString*)lossFor:(NSString*)teamKey;
@end
