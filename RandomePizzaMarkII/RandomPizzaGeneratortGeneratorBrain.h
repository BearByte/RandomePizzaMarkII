//
//  RandomPizzaGeneratortGeneratorBrain.h
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topping.h"

@interface RandomPizzaGeneratortGeneratorBrain : NSObject
@property (nonatomic,strong)NSArray *toppings;

-(NSArray *)generateWithNumberOfToppings:(int)number; 
@end
