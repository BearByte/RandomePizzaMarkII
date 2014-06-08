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

@property (weak, nonatomic) IBOutlet UIImageView *pizzaView;

@property (nonatomic, strong) NSArray *pizzaLayers; //A list of all the toppings subviews of the pizza pictures
@property (weak, nonatomic) IBOutlet UIImageView *toppingView;
@end

@implementation RandomPizzaGeneratorViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self sliderChanged:Nil];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Model"])
    {
        NSLog(@"Brain found"); 
        self.brain = [RandomPizzaGeneratortGeneratorBrain restoreState];
    }
    [self setUpScreen];
    self.numberOfToppings = [NSNumber numberWithFloat:(self.slider.value * ([self.brain.toppingsPool count]-1)+1)];
    
    self.numberOfToppingsLabel.text  = [NSString stringWithFormat:@"%i",self.numberOfToppings.intValue];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sliderChanged:nil];
    
}



-(void)setUpScreen
{
    if(self.brain.userVegan)
    {
        [self.veganSwitch setOn:YES];
        [self.vegitarianSwitch setOn:YES];
        self.vegitarianSwitch.enabled = NO;
    }
    else
    {
        [self.veganSwitch setOn:NO];
        if (self.brain.userVegitarian) {
            [self.vegitarianSwitch setOn:YES];
            
        }
        else
        {
            [self.vegitarianSwitch setOn:NO];
        }
    }
    
    
}
-(RandomPizzaGeneratortGeneratorBrain *)brain //lazy instantation for the model

{
    if (!_brain)
    {
        _brain = [[RandomPizzaGeneratortGeneratorBrain alloc]init];
    }
    return _brain;
}

- (NSArray *)pizzaLayers
{
    if (!_pizzaLayers) {
        _pizzaLayers = [[NSArray alloc]init];
    }
    return _pizzaLayers;
}

- (IBAction)generatePressed:(id)sender
{
    if ([self.brain.toppingsPool count]==0)
    {
        [[[UIAlertView alloc]initWithTitle:@"You can't do that" message:@"Please select at least one topping" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil]show];
        
    }
    else
    {
    
        NSArray *result = [self.brain generateWithNumberOfToppings:[self.numberOfToppings intValue]];
        [self displayToppings:result];
        [self resetPizzaPicture];
        self.pizzaLayers = [self createPizzaImage:result];
    }
}
- (IBAction)sliderChanged:(id)sender
{
    //update the desired number of toppings
    if ([self.brain.toppingsPool count] == 0)
    {
        self.numberOfToppingsLabel.text = @"0";
        
    }
   
    else
    {
    self.numberOfToppings = [NSNumber numberWithFloat:(self.slider.value * ([self.brain.toppingsPool count]-1)+1)];
    
    self.numberOfToppingsLabel.text  = [NSString stringWithFormat:@"%i",self.numberOfToppings.intValue]; //update the label with the current number of toppings selected
    }
    
    
}
//Displays the UITextView containing the topping name *note* does NOT set up the actual image
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
    UIAlertView *toppingsAlert=  [[UIAlertView alloc]initWithTitle:@"Pizza Generated" message:toppingsString delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
    [toppingsAlert show];

                                
}
//Give the pass the model to the table view controller so it can access the nesscessary data and refreash it based on the users desire
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    UIViewController *destination = [segue destinationViewController];
    
    
    if ([destination isMemberOfClass:[RandomPizzaGeneratorToppingViewController class]])
    {
        [(RandomPizzaGeneratorToppingViewController *) destination setBrain:self.brain]; 
    }
    
    
}

- (IBAction)vegitarianSwitchChanged
{
    self.brain.userVegitarian = self.vegitarianSwitch.on;
    [self.brain updateForVegChanged];
    [self sliderChanged:nil];
    [self.brain saveState];
    
    
}

- (IBAction)veganSwitchChanged
{
    self.brain.userVegan = self.veganSwitch.on;
    if (self.veganSwitch.on)
    {
        [self.vegitarianSwitch setOn:YES];
        self.vegitarianSwitch.enabled = NO;
    }
    else
    {
        self.vegitarianSwitch.enabled = YES;
    }
    
    [self.brain updateForVeganChanged];
    [self sliderChanged:nil];
    [self.brain saveState];
    

}


-(NSArray *)createPizzaImage:(NSArray *)toppings
{
   
    NSMutableArray *toppingViews = [[NSMutableArray alloc]init];
    
    for (Topping *topping in toppings)
    {
        if ([topping.name  isEqualToString:@"Cheese"] ) {
            UIImageView *cheeseImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:topping.image]];
            [self.pizzaView addSubview:cheeseImage];
            [toppingViews addObject:cheeseImage]; 
        }
    }
    
    for (Topping *topping in toppings)
    {
        if (![topping.name isEqualToString:@"Cheese"])
        {
        
            UIImageView *pizzaLayer = [[UIImageView alloc]initWithFrame:[self.toppingView bounds]];
            pizzaLayer.clipsToBounds = YES;
            pizzaLayer.contentMode = UIViewContentModeScaleAspectFit;
            pizzaLayer.image = [UIImage imageNamed:topping.image];
            [toppingViews addObject:pizzaLayer];
            [self.toppingView addSubview:pizzaLayer];
        }
        
    }
    
    return [toppingViews copy];
}
-(void)resetPizzaPicture
{
    for (UIImageView *layer in self.toppingView.subviews) {
        [layer removeFromSuperview];
    }
    for (UIImageView *otherLayer in self.pizzaView.subviews)
    {
        [otherLayer removeFromSuperview]; 
    }
    
}
- (IBAction)testMethod
{

}
@end
