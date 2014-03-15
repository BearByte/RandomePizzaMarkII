//
//  RandomPizzaGeneratorToppingViewController.m
//  RandomePizzaMarkII
//
//  Created by James Owens on 1/30/14.
//  Copyright (c) 2014 James Owens. All rights reserved.
//

#import "RandomPizzaGeneratorToppingViewController.h"

@interface RandomPizzaGeneratorToppingViewController ()

@property (nonatomic, strong) NSMutableDictionary *currentlySelectedToppings; //the toppings that are checked in the table view
@property (nonatomic, strong) NSMutableDictionary *cellForTopping; //holds the index path based on the topping name which is the key.
@property (nonatomic, strong) NSMutableArray *disabledVegitarian;
@property (nonatomic, strong) NSMutableArray *disabledVegan;
@end

@implementation RandomPizzaGeneratorToppingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.currentlySelectedToppings = [self.brain.toppingsPool mutableCopy];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self disableSpeicalCells];
    self.currentlySelectedToppings = [self.brain.toppingsPool mutableCopy];
    
    
}
- (IBAction)testButtonPressed:(id)sender
{
    /*
    for (RandomPizzaGeneratorCell *cell in self.disabledVegan) {
        cell.userInteractionEnabled = YES;
        cell.textLabel.enabled = YES;
    }
    for (RandomPizzaGeneratorCell *cell in self.disabledVegitarian) {
        cell.userInteractionEnabled = YES;
        cell.textLabel.enabled = YES;
    }
     */
    NSLog(@"%lu",(unsigned long)[self.currentlySelectedToppings count]);
    for (NSString *key in self.currentlySelectedToppings) {
        NSLog(@"%@",key);
    }
    
}

-(NSMutableArray *)disabledVegan
{
    if (!_disabledVegan)
    {
        _disabledVegan = [[NSMutableArray alloc]init];
    }
    return _disabledVegan;
}

-(NSMutableArray *)disabledVegitarian
{
    if (!_disabledVegitarian)
    {
        _disabledVegitarian = [[NSMutableArray alloc]init];
        
    }
    return _disabledVegitarian;
}

-(NSMutableDictionary *)currentlySelectedToppings
{
    if(!_currentlySelectedToppings)
    {
        _currentlySelectedToppings = [[NSMutableDictionary alloc]init];
        
    }
    return _currentlySelectedToppings;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelection = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableDictionary *)cellForTopping
{
    if (!_cellForTopping) {
        _cellForTopping = [[NSMutableDictionary alloc]init];
    }
    return _cellForTopping;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.brain.toppings count];
}

- (RandomPizzaGeneratorCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RandomPizzaGeneratorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Topping *toppingAtIndex = self.brain.toppings[indexPath.row];
   
    
    NSLog(@"%@",toppingAtIndex.name);
    if ([self.currentlySelectedToppings objectForKey:toppingAtIndex.name])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    cell.textLabel.text = toppingAtIndex.name;
    cell.cellsTopping = toppingAtIndex;
    if (![self.cellForTopping objectForKey:toppingAtIndex.name])
    {
        [self.cellForTopping setObject:cell forKey:toppingAtIndex.name];
        
    }
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.brain saveState];
    
    RandomPizzaGeneratorViewController *destination = [segue destinationViewController];
    
    destination.brain = self.brain;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[tableView cellForRowAtIndexPath:indexPath ] accessoryType] == UITableViewCellAccessoryCheckmark)
    {
        
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
        RandomPizzaGeneratorCell *toppingCell = (RandomPizzaGeneratorCell *)[tableView cellForRowAtIndexPath:indexPath];
        [self.currentlySelectedToppings removeObjectForKey:toppingCell.cellsTopping.name];
        
         
        
    }
    else
    {
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];//add a check mark
        
        //add the toppping in the cell to the dictionary of currently selected toppings
        RandomPizzaGeneratorCell *toppingCell = (RandomPizzaGeneratorCell *)[tableView cellForRowAtIndexPath:indexPath];//
        [self.currentlySelectedToppings setObject:toppingCell.cellsTopping forKey:toppingCell.cellsTopping.name];
        
    }
    self.brain.toppingsPool = [self.currentlySelectedToppings copy];
    [self.brain saveState];


    
}

//disables the cells that don't comply if the user is vegitarian or vegan
-(void)disableSpeicalCells
{
    if (self.brain.userVegan)
    {
        for (Topping *topping in self.brain.toppings)
        {
            if (!topping.vegan)
            {
                RandomPizzaGeneratorCell *cell = [self.cellForTopping objectForKey:topping.name];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.userInteractionEnabled = NO;
                cell.textLabel.enabled = NO;
                [self.disabledVegan addObject:cell];
            }
        }
        
    }
    else if (self.brain.userVegitarian)
    {
        NSLog(@"User is just veg");
        for (Topping *topping in self.brain.toppings)
        {
            if (!topping.vegitarian)
            {
                RandomPizzaGeneratorCell *cell = [self.cellForTopping objectForKey:topping.name];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                cell.userInteractionEnabled = NO;
                cell.textLabel.enabled = NO;
                [self.disabledVegan addObject:cell];
            }
        }
        
    }
}


-(void)makeIntoDicionary

{
    NSLog(@"Making dictionary...."); 
    for (Topping *topping in self.brain.toppingsPool) {
        [self.currentlySelectedToppings setObject:topping forKey:topping.name];
    }
}


@end
