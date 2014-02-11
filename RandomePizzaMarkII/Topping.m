//
//  Topping.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "Topping.h"

@implementation Topping


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
