/* Parker Beasley
 * September 19th 2019
 * Section 1
 * Assignment #2, Orderingcpp
 * Due September 26th
 * This project asks to compile a program using methods that we learned in class. Such as if statements
 * Assume that everything in the code works correctly
 * All work below was performed by Parker Beasley */


#include<iostream>
using namespace std;
int main()
{
	double  x, y, z;															//defines the 3 variables that I am using
	char order;																//defines order as a character
	cout<< "Enter 3 numbers: "; 														//tells to enter 3 numbers
	cin>>x>>y>>z;																
		
	
	if (( x==y) && (y==z) && (z=x))														//says that the numbers can't be equal to each other
	{
		cout<<"ERROR. You cannot enter the same number 3 times. Exiting."<<endl;							//exits if you enter the same number 3 times
	}
	else 																	//if you don't enter the same number 3 times, the program proceeds
	{
		cout<<"Enter 'A' if you want the number displayed in ascending order, and 'D' for descending order.";				//Prompts to pick A is desired
		cin>>order;
		
		 if (order == 'A')														//for picking ascending order
 		{
			if(x <= y && y <=z)													//where the order of ascension starts
			{
				cout<<"The order of the numbers is"<<x<<"  "<<y<<"  "<<z<<endl;							//if x is less or equal to y and y is less or equal to z
			}
			else if (x <= z && z <= y)
			{
				cout<<"The order of the numbers is"<<x<<"  "<<z<<"  "<<y<<endl;							//if x is less or equal to z and z is less or equal to z
			}
			else if (z <= x && x <= y)
			{
				cout<<"The order of the numbers is"<<z<<"  "<<x<<"  "<<y<<endl;							//if z is less or equal to x and x is less or equal to y
			}	
			else if (z <= y && y <= x)
			{
				cout<<"The order of the numbers is"<<z<<"  "<<y<<"  "<<x<<endl;							//if z is less or equal to y and y is less or equal to x
			}
			else if (y <= x && x<= z)
			{	
				cout<<"The order of the numbers is"<<y<<"  "<<x<<"  "<<z<<endl;							//if y is less or equal to x and x is less or equal to z
			}
			else 
			{														
				cout<<"The order of the numbers is"<<y<<"  "<<z<<"  "<<x<<endl;							//where the order of ascension stops
			}									
		}
		else if (order == 'D')														//where the order of descension starts
		{
			if (x >= y && y>= z)
			{
				cout<<"The order of the numbers is"<<x<<"  "<<y<<"  "<<x<<endl;							//if x is greater or equal y and y is greater or equal z
			}
			else if (x >= z && z >= y)
			{
				cout<<"The order of the numbers is"<<x<<"  "<<z<<"  "<<y<<endl;							//if x is greater or equal z and z is greater or equal y
			}
			else if (z >= x && x >= y)
			{
				cout<<"The order of the numbers is"<<z<<"  "<<x<<"  "<<y<<endl;							//if z is greater or equal x and x is greater or equal y
			}
			else if (z >= y && y >= x)
			{
				cout<<"The order of the numbers is"<<z<<"  "<<y<<"  "<<x<<endl;							//if z is greater or equal y and y is greater or equal x
			}
			else if (y >= x && x >= z)
			{
				cout<<"The order of the numbers is"<<y<<"  "<<x<<"  "<<z<<endl;							//if y is greater or equal x and x is greater or equal z
			}
			else 
			{
				cout<<"The order of the numbers is"<<y<<"  "<<z<<"  "<<x<<endl;							//where the order of descension stops
			}
		}
		else
		{
			cout<<"ERROR. An invalid character for the order was selected. Exiting."<<endl;						//if you didn't enter A or D, then the program exits
		}
	}

 	return 0;


}	
