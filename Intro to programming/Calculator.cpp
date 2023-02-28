/*	Name:Parker Beasley
 *	Date:September 10th, 2019
 *	Section:1
 *	Assignment:1
 *	Due Date:September 13th, 2019
 *	About this project:This homework tells to build a calculator for the Krusty Krab so that Squidward can calculate the prices of Krabby Patties, Kelp Shakes and Fries
 *	Assumptions: That everything works :)
 *	ALL work below was performed by Parker Beasley */

#include<iostream>
#include<iomanip>
using namespace std;
int main()

{
	cout<< "Welcome to the Krusty Krab" << endl;   //Welcome message 

	int numPatty;    //Declaring Variables	
	int numShake;
	int numFries;
	int numChecks;
	double totalKrabby;
	double totalKelpS;
	double totalFry;
	double subTotal;
	double salesTax;
	double Total; 
	double endTotal;
	
	const double KrabbyPatty = 3.69;  						 	         //price for a Krabby Patty
	const double KelpShake = 2.65;  								 //price for a Kelp Shake
	const double Fries = 1.89;  									 //price for an order of Fries
	
	cout << "Enter the number of Krabby Patties you want: ";   					 //Allows user to pick amount of food items
	cin >> numPatty;                                           					 //User enters in the amount of that food item
	cout << "Enter the number of Kelp Shakes you want: ";
	cin >> numShake;
	cout << "Enter the number of Fries you want: ";
	cin >> numFries;
	cout << "Enter the amount of checks with this order: ";
	cin>> numChecks;

	//This is the amount of food items the customer wants

	totalKrabby = KrabbyPatty * numPatty;  								 //Total amount for Krabby Patties
	totalKelpS = KelpShake * numShake;
	totalFry = Fries * numFries;

	//Total for each of the items in terms of the amount that they order for the customer

	subTotal = totalKrabby + totalKelpS + totalFry;  						 //Total of all food without tax

	salesTax = subTotal * 0.018; 									 //Total amount of tax
	
	Total = salesTax + subTotal; 									 //Total amount for food and tax

	endTotal = Total / numChecks;									 //Total amount per check
	cout << fixed;
	cout <<setprecision(2);
	cout<<"Your total per check is $ "<<endTotal<<endl;
	
	return 0;
}































