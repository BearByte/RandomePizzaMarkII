//
//  Topping.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "Topping.h"

@implementation Topping

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        
    
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.vegitarian = [aDecoder decodeBoolForKey:@"Vegitarian"];
        self.vegan = [aDecoder decodeBoolForKey:@"Vegan"];
        self.enabled = [aDecoder decodeBoolForKey:@"Enabled"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeBool:self.vegitarian forKey:@"Vegitarian"];
    [aCoder encodeBool:self.vegan forKey:@"Vegan"];
    [aCoder encodeBool:self.enabled forKey:@"Enabled"];

}

//designated init
-(instancetype)initWithName:(NSString *)name andVegitarian:(BOOL)vegitarian andVegan:(BOOL)vegan

{
    self = [super init];
    self.name = name;
    //self.toppingImage = image;
    self.vegitarian = vegitarian;
    self.vegan = vegan;
    self.enabled = YES; 
    return self;
}

@end
