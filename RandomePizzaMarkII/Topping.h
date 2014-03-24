//
//  Topping.h
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topping : NSObject <NSCoding>
@property (nonatomic,strong) NSString *name; //the name of the topping
//@property (nonatomic,strong)UIImage *toppingImage;
@property (nonatomic) BOOL vegitarian; //vegitarian?
@property (nonatomic) BOOL vegan; //vegan?
@property (nonatomic) BOOL enabled; //is this topping enabled
@property (nonatomic) BOOL wasChecked; //was this topping enabled before a switch was changed

-(instancetype)initWithName:(NSString *)name andVegitarian:(BOOL)vegitarian andVegan:(BOOL)vegan; 
@end
