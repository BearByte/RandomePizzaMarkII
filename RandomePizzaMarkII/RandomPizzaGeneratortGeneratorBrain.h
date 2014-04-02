//
//  RandomPizzaGeneratortGeneratorBrain.h
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topping.h"

@interface RandomPizzaGeneratortGeneratorBrain : NSObject<NSCoding> 
@property (nonatomic,strong)NSArray *toppings; //all of the possible toppings
@property (nonatomic, strong) NSDictionary *toppingsPool; //the toppings to be selected from when generate pressed
@property (nonatomic) BOOL userVegitarian;
@property (nonatomic) BOOL userVegan;




-(NSArray *)generateWithNumberOfToppings:(int)number;
-(void)saveState;
-(void)updateForVegChanged;
-(void)updateForVeganChanged;


+(RandomPizzaGeneratortGeneratorBrain *)restoreState;



@end
