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
@property (nonatomic, strong)NSMutableArray *removedVeganToppings;
@property (nonatomic, strong) NSMutableArray *removedVegitarianToppings;


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
        _toppingsPool =  [[NSDictionary alloc]init]; 
        
    }
    
    return _toppingsPool;
}

-(NSMutableArray *)removedVeganToppings
{
    if (!_removedVeganToppings) {
        _removedVeganToppings = [[NSMutableArray alloc]init];
    }
    return _removedVeganToppings;
}
-(NSMutableArray *)removedVegitarianToppings
{
    if (!_removedVegitarianToppings)
    {
        _removedVegitarianToppings = [[NSMutableArray alloc]init];
    }
    return _removedVegitarianToppings;
}

//The main generate loop. Returns an array of randomly chosen toppings. Take a desired number of toppings.
-(NSArray *)generateWithNumberOfToppings:(int)number
{
    NSMutableDictionary *temp = [self.toppingsPool mutableCopy]; //create a mutable copy of the toppings array
    
    NSMutableArray *chosen = [[NSMutableArray alloc]init]; //creates an empty array to add chosen toppings to
    NSMutableArray *keys = [[temp allKeys] mutableCopy];
    
    
    for (int i = 0; i<number; i++)
    {
        int random = 1.*rand()/RAND_MAX * [keys count]; //choose a random index
        [chosen addObject:[temp objectForKey:[keys objectAtIndex:random]]]; //add it to the chosen array
        [keys removeObjectAtIndex:random]; //remove the topping from the temprary array so it will not be chosen again
        
    }
    return [chosen copy]; //return the chosen toppings as an NSArray (immuatable)
}

-(NSArray *)createInitalToppings
{
    
    //Create the toppings list
    Topping *cheese = [[Topping alloc]initWithName:@"Cheese" andVegitarian:YES andVegan:NO andImageName:@"Cheese.png"];
    Topping *chicken = [[Topping alloc]initWithName:@"Chicken" andVegitarian:NO andVegan:NO andImageName:@"Chicken.png"];
    Topping *olives = [[Topping alloc]initWithName:@"Olives" andVegitarian:YES andVegan:YES andImageName:@"Olives.png"];
    Topping *bacon = [[Topping alloc]initWithName:@"Bacon" andVegitarian:NO andVegan:NO andImageName:@"Bacon.png"];
    Topping *pineapple = [[Topping alloc]initWithName:@"Pineapple" andVegitarian:YES andVegan:YES andImageName:@"Pineapple.png"];
    Topping *sausage = [[Topping alloc]initWithName:@"Sausage" andVegitarian:NO andVegan:NO andImageName:@"Sausage.png"];
    Topping *jalapeno = [[Topping alloc] initWithName:@"Jalapano" andVegitarian:YES andVegan:YES andImageName:@"Jalp.png"];
    Topping *anchovies = [[Topping alloc]initWithName:@"Anchovies" andVegitarian:NO andVegan:NO andImageName:@"Anchovies.png"];
    Topping *pepperoni = [[Topping alloc]initWithName:@"Pepperoni" andVegitarian:NO andVegan:NO andImageName:@"roni.png"];
    Topping *shrooms = [[Topping alloc]initWithName:@"Mushrooms" andVegitarian:YES andVegan:YES andImageName:@"Shrroms.png"];
    Topping *arugula =[[Topping alloc]initWithName:@"Aruglua" andVegitarian:YES andVegan:YES andImageName:@"Arug.png"];
    Topping *canadianBacon = [[Topping alloc]initWithName:@"Canadian Bacon" andVegitarian:NO andVegan:NO andImageName:@"CaBacon.png"];
    Topping *eggPlant = [[Topping alloc] initWithName:@"Eggplant" andVegitarian:YES andVegan:YES andImageName:@"Eggplant.png"];
    Topping *burgers = [[Topping alloc]initWithName:@"Hamburger" andVegitarian:NO andVegan:NO andImageName:@"Hamburger.png"];
    Topping *onion = [[Topping alloc]initWithName:@"Onions" andVegitarian:YES andVegan:YES andImageName:@"Onion.png"];
    Topping *redPeppers = [[Topping alloc]initWithName:@"Red Peppers" andVegitarian:YES andVegan:YES andImageName:@"RedPeppers.png"];
    Topping *spinich = [[Topping alloc]initWithName:@"Spinich" andVegitarian:YES andVegan:YES andImageName:@"Spinich.png"]; 
    
    
    
    return @[cheese,chicken,olives,bacon,pineapple, sausage, jalapeno, anchovies, pepperoni, shrooms,arugula,canadianBacon];
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

-(NSDictionary *)makeIntoDicionary


{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    for (Topping *topping in self.toppings)
    {
        [temp setObject:topping forKey:topping.name];
    }
    return [temp copy];
    
}
-(void)removeVeganTopppings
{
    NSMutableDictionary *mutableToppingsPool = [self.toppingsPool mutableCopy];
    for (NSString *key in self.toppingsPool)
    {
        if (![[self.toppingsPool objectForKey:key] vegan])
        {
            Topping *topping = [mutableToppingsPool objectForKey:key];
            if (topping.vegitarian)
            {
                [self.removedVeganToppings addObject:topping];
            }
            else
            {
                [self.removedVeganToppings addObject:topping];
            }
            
            [mutableToppingsPool removeObjectForKey:key];
            [[self.toppingsPool objectForKey:key] setWasChecked:YES];
            
        
        }
    }
    self.toppingsPool = [mutableToppingsPool copy];
    
}

-(void)removeVegitarianToppings
{

    NSMutableDictionary *mutableToppingsPool = [self.toppingsPool mutableCopy];
    for (NSString *key in self.toppingsPool) {
        if (![[self.toppingsPool objectForKey:key] vegitarian])
        {
            
            [mutableToppingsPool removeObjectForKey:key];
            [[self.toppingsPool objectForKey:key] setWasChecked:YES];
            [self.removedVegitarianToppings addObject:[self.toppingsPool objectForKey:key]];
            
        }
    }
    self.toppingsPool = [mutableToppingsPool copy];
}

-(void)enableVeganToppings

{
    NSMutableDictionary *mutableToppingsPool = [self.toppingsPool mutableCopy];
    for (Topping *topping  in self.removedVeganToppings)
    {
        [mutableToppingsPool setObject:topping forKey:topping.name];
        
    }
    self.toppingsPool = [mutableToppingsPool copy];
    self.removedVeganToppings = [[NSMutableArray alloc]init];
}

-(void)enableVegitarianToppings
{
    NSLog(@"ReEnabling Vegitarian toppings...");

    NSMutableDictionary *mutableToppingsPool = [self.toppingsPool mutableCopy];
    
    for (Topping *topping in self.removedVegitarianToppings)
    {
        [mutableToppingsPool setObject:topping forKey:topping.name];
        
    }
    self.toppingsPool = [mutableToppingsPool copy];
    self.removedVegitarianToppings = [[NSMutableArray alloc]init];
    
    
}

-(void)updateForVeganChanged
{
    if (self.userVegan)
    {
        [self removeVeganTopppings];
    }
    else
    {
        [self enableVeganToppings];
    }
        
}

-(void)updateForVegChanged
{
    if (self.userVegitarian)
    {
        [self removeVegitarianToppings];
    }
    else
    {
        [self enableVegitarianToppings]; 
    }
}

@end
