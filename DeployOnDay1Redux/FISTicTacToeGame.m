//
//  FISTicTacToeGame.m
//  DeployOnDay1Redux
//
//  Created by Timothy Clem on 9/22/15.
//  Copyright © 2015 The Flatiron School. All rights reserved.
//

#import "FISTicTacToeGame.h"

@interface FISTicTacToeGame ()

@property (nonatomic, strong) NSMutableArray *board;

@end


@implementation FISTicTacToeGame

-(instancetype)init
{
    self = [super init];
    if(self) {
        // Do initialization of your game here, inside this if statement.
        // Leave the rest of this method alone :)
        
        //represent 3x3 grid by using nested array
        //numbers represent the positions in the tic tac toe grid that the players will use to specify their positions... perhaps use if statement to match values (convert to integerValue)
        /*NSArray *ticTacToeGrid = @[ [@[ @" ", @" ", @" " ] mutableCopy],
                                    [@[ @" ", @" ", @" " ] mutableCopy],
                                    [@[ @" ", @" ", @" " ] mutableCopy] ]; */
        
        self.board = [[NSMutableArray alloc] init];
        for(NSUInteger i=0; i < 3; i++){
            [self.board addObject:[@[ @"", @"", @"" ] mutableCopy]];
            // NSLog(@"%@", self.board);
        }
    }

    return self;
}

-(void)resetBoard
{
    NSUInteger rows = [self.board count];
    //rows count is equal to 3, so when you run it, columns will go out of bounds!! so need to add minus 1 b/c index only goes up to 2
    // NSUInteger columns = [self.board[rows-1] count];
    
    for(NSUInteger i = 0; i < rows; i++){
        self.board[i] = [@[ @"", @"", @"" ] mutableCopy];
        //need to set this to an EMPTY ARRAY FOR ROW, not an empty string!! if not, will cause errors b/c there is nothing to index through
    }
}

-(NSString *)playerAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    // is called to determine what player has a piece at the given position. It should return a string representing which player (if any) has a piece at the given position. Valid return values are "X", "O", and "" (the empty string, for a space with no piece).
    
    NSString *placeValue = self.board[row][column];
    
    return placeValue;
}

-(BOOL)canPlayAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    // is called before placing a piece at the given location. It should return YES if the given position is a valid place to play a piece, and NO if not.
    
    NSString *columnCheck = [self playerAtColumn:column row:row];
    if([columnCheck isEqualToString:@""]){
        return YES;
    }
    
    return NO;
}

-(void)playXAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    self.board[row][column] = @"X";
    // can you call on a previous method to get the value and set it equal to x?
}

-(void)playOAtColumn:(NSUInteger)column row:(NSUInteger)row
{
    self.board[row][column] = @"O";
}

-(NSString *)winningPlayer
{
    NSString *winner = @"";
    
    //winning row combinations
    for(NSArray *row in self.board){
        if([row isEqualToArray:@[@"X", @"X", @"X"]]){
            winner = @"X";
        }
        else if ([row isEqualToArray:@[@"O", @"O", @"O"]]){
            winner = @"O";
        }
    }
    
    //winning column combinations
        //  NOTE: I originally set self.board[row][column] isEqualToString self.board[next row][next column] but it was giving me problems where the "winner" screen does not pop up right away and/or the wrong "winner" pops up for columns 0 & 1, but worked fine for column 2. This could be due to the fact that the game is checking column 2 first before checking columns 0 and 1. Need to refactor code at another time. In the code below, it only works when I use the return winner = @"winner here". It does not work without the return statement, so it could also be an issue of when it "leaves" the if statement
    
    if([self.board[0][0] isEqualToString:@"X"] && [self.board[2][0] isEqualToString:@"X"] && [self.board[1][0] isEqualToString:@"X"]){
        return winner = @"X";
    }
    else if([self.board[0][0] isEqualToString:@"O"] && [self.board[2][0] isEqualToString:@"O"] && [self.board[1][0] isEqualToString:@"O"]){
        return winner = @"O";
    }
    else if([self.board[0][1] isEqualToString:@"X"] && [self.board[1][1] isEqualToString:@"X"] && [self.board[2][1] isEqualToString:@"X"]){
        return winner = @"X";
    }
    else if([self.board[0][1] isEqualToString:@"O"] && [self.board[1][1] isEqualToString:@"O"] && [self.board[2][1] isEqualToString:@"O"]){
        return winner = @"O";
    }
    else if([self.board[0][2] isEqualToString:@"X"] && [self.board[1][2] isEqualToString:@"X"] && [self.board[2][2] isEqualToString:@"X"]){
        return winner = @"X";
    }
    else if([self.board[0][2] isEqualToString:@"O"] && [self.board[1][2] isEqualToString:@"O"] && [self.board[2][2] isEqualToString:@"O"]){
        return winner = @"O";
    }
    
    
    //winning diagonal combinations
    if([self.board[0][0] isEqualToString:self.board[1][1]] && [self.board[1][1] isEqualToString:self.board[2][2]]){
        winner = self.board[0][0];
    }
    
    if([self.board[0][2] isEqualToString:self.board[1][1]] && [self.board[1][1] isEqualToString:self.board[2][0]]){
        winner = self.board[0][2];
    }
    
    return winner;
}

-(BOOL)isADraw
{
    NSUInteger rows = [self.board count];
    NSUInteger columns = [self.board[rows-1] count];
    
    NSString *checkWinner = [self winningPlayer];
    NSInteger emptyPlaceCount = 9;
    
    for(NSUInteger i = 0; i < rows; i++){
        for(NSUInteger j = 0; j < columns; j++){
            if(![self.board[i][j] isEqualToString:@""]){ //if there isn't an empty string in that space
                emptyPlaceCount--; //decrement with each play that a player makes
            }
        }
    }
    
    //if there is no winner chosen from the previous method and no empty spaces left on the grid, then the game is a draw
    if([checkWinner isEqualToString:@""] && emptyPlaceCount == 0){
        return YES;
    }
    
    return NO;
}

@end



//    ----- CODE THAT IS NOT BEING USED -----
//    NSMutableArray *playerX = [[NSMutableArray alloc] init];
//    NSMutableArray *playerO = [[NSMutableArray alloc] init];
//    NSArray *key = @[ ]; // write out all diff winning combinations and compare them to what the grid currently has for X's & O's
//
//    another idea: points for every adjacent letter... but this presents a problem if there are 2 adjacent letters that make a line
//     NSInteger playerXPoints = 0;
//     NSInteger playerOPoints = 0;
//
//
//    for(NSUInteger i = 0; i < rows; i++){
//        for(NSUInteger j = 0; j < columns; j++){
//            if([self.board[i][j] isEqualToString:@"X"]){
//                // NSLog(@"PLAYER X -- i: %lu, j: %lu", i, j);
//                [playerX addObject:@[@(i), @(j)]];
//
//            }
//            else if ([self.board[i][j] isEqualToString:@"O"]){
//                // NSLog(@"PLAYER O -- i: %lu, j: %lu", i, j);
//                [playerO addObject:@[@(i), @(j)]];
//            }
//        }
//    }
