#Design Specification: Random Pizza Generator


##Introduction
============

The **Random Pizza Generator** is an iPhone app that will help the user make the ever so difficult choice of choosing toppings for their delicious Italian treat. **The Random Pizza Generator** is written entirely in Objective C and should only be edited using the xcode SDK.


This design Specification will cover: 

* The setup of the MVC
* Data Storage
* Test Strategy 
* Deployment 
* Bug Reports 
 
##MVC design
==========


###Model

The model is shared between both of view controllers and contains all of the major data as well as most of the methods. The instance of the model is passed between the view controllers using the prepareForSegue method.

####Toppings Pool

This instance variable is the most important instance variables. It is a dictionary of the of the toppings selected by the user. The keys are the toppings names of the toppings. This the is the variable that the random function uses to choose the toppings for the pizza.

###Views

The views are made entirely using storyboards. The full details of the views can be found in the functional specification. 

###Controller 

These classes control the views. While the model takes care of the the calculations and data the view controller updates the view based on information provided by the model. 

##Data Storage
==============

###The Toppings Class

Objects are stored as toppings objects: a subclass of NSObject. The data about each toppings are stored in the instance variables of the toppings object.

* **Name**- the name of the object stored as a string
* **Vegetarian**- Boolean that stores if the toppings is Vegetarian or not
* **Vegan**- Boolean that stores if the toppings is Vegan or not
* **Enabled**- Boolean that stores if this toppings is enabled or not
* **wasChecked**- Boolean that stores if the topping was checked before the vegetarian and/or vegan switch was changed  


##Test Strategy
===============

###Test Flight

I will use test flight to send my app to friends to make sure there are bugs. Testflight makes it easy for others to use an app in beta before it is released. 

###Apple 

Then when I send it to apple they will also check it over to make sure there is nothing wrong with it. 

##Deployment
============

Apple makes deployment very easy. The only way to release an iPhone app is on the Apple app store. It is as simple as sending the app to apple and they will put it on the app store. 

##Bug Reports
=============

Again Apple make this easy. There is a bug report button on the app store. This will send me an email an email whenever a user finds an bug in the program. 




