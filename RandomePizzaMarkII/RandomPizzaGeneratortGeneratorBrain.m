//
//  RandomPizzaGeneratortGeneratorBrain.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "RandomPizzaGeneratortGeneratorBrain.h"

@interface RandomPizzaGeneratortGeneratorBrain ()
@property (nonatomic, strong) NSMutableArray *toppingPoolDictionary;

@end
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
    if (!_toppings)
    {
        _toppings = [self createInitalToppings];
    }
    return _toppings;
}

-(NSDictionary *)toppingsPool
{
    if (!_toppingsPool) {
        _toppingsPool =  [self makeIntoDicionary];
        
    }
    
    return _toppingsPool;
}

//The main generate loop. Returns an array of randomly chosen toppings. Take a desired number of toppings.
-(NSArray *)generateWithNumberOfToppings:(int)number
{
    NSMutableDictionary *temp = [self.toppingsPool mutableCopy]; //create a mutable copy of the toppings array
    NSMutableArray *chosen = [[NSMutableArray alloc]init]; //creates an empty array to add chosen toppings to
    NSMutableArray *keys = [[temp allKeys] mutableCopy];
    
    
    for (int i = 0; i<number; i++) {
        int random = (arc4random()% keys.count)-1; //choose a random index
        [chosen addObject:[temp objectForKey:[keys objectAtIndex:random]]]; //add it to the chosen array
        [keys removeObjectAtIndex:random]; //remove the topping from the temprary array so it will not be chosen again
        
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
    Topping *sausage = [[Topping alloc]initWithName:@"Sausage" andVegitarian:NO andVegan:NO];
    Topping *jalapeno = [[Topping alloc] initWithName:@"Jalapano" andVegitarian:YES andVegan:YES];
    Topping *anchovies = [[Topping alloc]initWithName:@"Anchovies" andVegitarian:NO andVegan:NO];
    Topping *pepperoni = [[Topping alloc]initWithName:@"Pepperoni" andVegitarian:NO andVegan:NO];
    
    
    
    return @[cheese,chicken,olives,bacon,pineapple, sausage, jalapeno, anchovies, pepperoni];
}
-(void)saveState
{
    NSData *model =[NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:model forKey:@"Model"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*
-(void)updateEnabledToppings
{
    if (self.userVegan)
    {
        for (Topping *topping in self.toppings)
        {
            if (!topping.vegan)
            {
                topping.enabled = NO;
                self.top
            }
        }
        
    }
    else if (self.userVegitarian)
    {
        for (Topping *topping in self.toppings) {
            if (!topping.vegitarian) {
                topping.enabled = NO;
            }
        }
    }
}
 */
+(RandomPizzaGeneratortGeneratorBrain *)restoreState
{
    NSData *modelData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Model"];
    RandomPizzaGeneratortGeneratorBrain *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model; 
}

-(NSDictionary *)makeIntoDicionary


{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    for (Topping *topping in self.toppings)
    {
        [temp setObject:topping forKey:topping.name];
    }
    return [temp copy];
    
}


@end
