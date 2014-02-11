//
//  RandomPizzaGeneratorViewController.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/27/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "RandomPizzaGeneratorViewController.h"
#import "RandomPizzaGeneratorToppingViewController.h"

@interface RandomPizzaGeneratorViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *vegitarianSwitch;//the outlet for the vegitarian switch
@property (weak, nonatomic) IBOutlet UISwitch *veganSwitch; //the outlet for the vegan switch

@property (weak, nonatomic) IBOutlet UISlider *slider; //outlet for topping selection slider
@property(nonatomic,strong) NSNumber* numberOfToppings; //an NSNumber that contains the desired number of toppings for the pizza
@property (weak, nonatomic) IBOutlet UILabel *numberOfToppingsLabel; //the outlet for the number of toppings display label

@end

@implementation RandomPizzaGeneratorViewController


-(RandomPizzaGeneratortGeneratorBrain *)brain //lazy instantation for the model

{
    if (!_brain) {
        _brain = [[RandomPizzaGeneratortGeneratorBrain alloc]init];
    }
    return _brain;
    
}


- (IBAction)generatePressed:(id)sender
{
    NSLog(@"Called");
 
    NSArray *result = [self.brain generateWithNumberOfToppings:[self.numberOfToppings intValue]];
    /*
    for (Topping *topping in result) {
        NSLog(@"%@",topping.name);
    }
    */
    [self displayToppings:result];
    
    
}
- (IBAction)sliderChanged:(id)sender
{
    //update the desired number of toppings
    self.numberOfToppings = [NSNumber numberWithFloat:(self.slider.value *10)];
    
    self.numberOfToppingsLabel.text  = [NSString stringWithFormat:@"%i",self.numberOfToppings.intValue]; //update the label with the current number of toppings selected
    
    
    
}

-(void)displayToppings:(NSArray *)toppings
{
    NSLog(@"called");
    NSMutableArray *mutableToppings = [toppings mutableCopy];
    Topping *firstToping = [mutableToppings objectAtIndex:0];
    NSString *toppingsString = [NSString stringWithFormat:@"%@",firstToping.name];
    [mutableToppings removeObjectAtIndex:0];
    for (Topping *topping in mutableToppings) {

        toppingsString =[toppingsString stringByAppendingString:[NSString stringWithFormat:@", %@",topping.name]];
    }
    UIAlertView *toppingsAlert=  [[UIAlertView alloc]initWithTitle:@"Piza Generated" message:toppingsString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [toppingsAlert show];

                                
}
//Give the pass the model to the table view controller so it can access the nesscessary data and refreash it based on the users desire
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RandomPizzaGeneratorToppingViewController *destination = [segue destinationViewController];
    destination.brain = self.brain;
    
    
}



@end
