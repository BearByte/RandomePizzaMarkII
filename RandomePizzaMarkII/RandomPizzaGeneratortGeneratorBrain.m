//
//  RandomPizzaGeneratortGeneratorBrain.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "RandomPizzaGeneratortGeneratorBrain.h"

@implementation RandomPizzaGeneratortGeneratorBrain


//Lazy Instansations for the toppings variable
-(NSArray *)toppings
{
    if (!_toppings) {
        _toppings = [self createInitalToppings];
    }
    return _toppings;
}

//The main generate loop. Returns an array of randomly chosen toppings. Take a desired number of toppings.
-(NSArray *)generateWithNumberOfToppings:(int)number
{
    
    NSMutableArray *temp = [self.toppings mutableCopy]; //create a mutable copy of the toppings array
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



@end
