//
//  RandomPizzaGeneratortGeneratorBrain.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "RandomPizzaGeneratortGeneratorBrain.h"

@implementation RandomPizzaGeneratortGeneratorBrain

-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [self init];
    if (self) {
        self.toppings = [aDecoder decodeObjectForKey:@"Toppings"];
        self.toppingsPool = [aDecoder decodeObjectForKey:@"ToppingsPool"];
        self.userVegitarian = [aDecoder decodeBoolForKey:@"UserVegitarian"];
        self.userVegan = [aDecoder decodeBoolForKey:@"UserVegan"];
    }
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.toppings forKey:@"Toppings"];
    [aCoder encodeObject:self.toppingsPool forKey:@"ToppingsPool"];
    [aCoder encodeBool:self.userVegitarian forKey:@"UserVegitarian"];
    [aCoder encodeBool:self.userVegan forKey:@"UserVegan"]; 

    

}
//Lazy Instansations for the toppings variable
-(NSArray *)toppings
{
    if (!_toppings) {
        _toppings = [self createInitalToppings];
    }
    return _toppings;
}

-(NSArray *)toppingsPool
{
    if (!_toppingsPool) {
        _toppingsPool = self.toppings;
        NSLog(@"This shouldn't ever be shown");
    }
    
    return _toppingsPool;
}

//The main generate loop. Returns an array of randomly chosen toppings. Take a desired number of toppings.
-(NSArray *)generateWithNumberOfToppings:(int)number
{
    NSLog(@"%lu",(unsigned long)[self.toppingsPool count]);
    NSMutableArray *temp = [self.toppingsPool mutableCopy]; //create a mutable copy of the toppings array
    NSMutableArray *chosen = [[NSMutableArray alloc]init]; //creates an empty array to add chosen toppings to
    
    for (int i = 0; i<number; i++) {
        int random = (arc4random()% temp.count); //choose a random index
        [chosen addObject:[temp objectAtIndex:random]]; //add it to the chosen array
        [temp removeObjectAtIndex:random]; //remove the topping from the temprary array so it will not be chosen again
        
    }
    return [chosen copy]; //return the chosen toppings as an NSArray (immuatable)
}

-(NSArray *)createInitalToppings
{
    
    //Create the toppings list
    Topping *cheese = [[Topping alloc]initWithName:@"Cheese" andVegitarian:YES andVegan:NO];
    Topping *chicken = [[Topping alloc]initWithName:@"Chicken" andVegitarian:NO andVegan:NO];
    Topping *olives = [[Topping alloc]initWithName:@"Olives" andVegitarian:YES andVegan:YES];
    Topping *bacon = [[Topping alloc]initWithName:@"Bacon" andVegitarian:NO andVegan:NO];
    Topping *pineapple = [[Topping alloc]initWithName:@"Pineapple" andVegitarian:YES andVegan:YES];
    
    return @[cheese,chicken,olives,bacon,pineapple];
}
-(void)saveState
{
    NSData *model =[NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:model forKey:@"Model"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(RandomPizzaGeneratortGeneratorBrain *)restoreState
{
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Model"];
    RandomPizzaGeneratortGeneratorBrain *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model; 
}



@end
