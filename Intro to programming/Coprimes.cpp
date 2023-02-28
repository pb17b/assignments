/* Parker Beasley
 * October 7th 2019
 * Section 1
 * Assignment #3, part 2
 * Due October 9th 2019
 * This project tells the user to enter a number and then the program will print out the numbers that are coprime to the number that the user entered.
 * Assume correct user input, and assume that the program will run correctly
 * All work below was performed by Parker Beasley*/


#include<iostream>
using namespace std;
int main()
{
	int num;							//defines num as an integer
	cout<<"Enter the  number:";					//Enter the number
	cin>>num;							//reads out the number
	bool coprimes = true;						//defines coprimes as a true boolian statement

	if(num >= 2)							//if the number is less than or equal to 2
	{	
		cout<<"The coprime numbers are:\n";			//Reads out what the coprime numbers are
	
		for (int i=2; i<=num; i++)				//defines i, and its restrictions
		{
			for(int j=2; j<=i; j++)				//for loop inside of the for loop defining i
			{
				
			if(i % j == 0 && num%j ==0)			//if i modulus j and the number entered modulus j are equal to zero, then coprimes will carry out to be false
			{
				coprimes = false;			//reflects that the statement is false
			}
			}
			if (coprimes == true)				//states that if coprimes is true, then it carries out the next line
					
			{
			cout<<i<<", ";					//will run the value of i if the coprimes statement is true
			}
			coprimes = true;				//
		}
	}
	else								//else statement if the number is less than or equal to 2
	{
		cout<<"Number is too small. Goodbye.\n";		//states that the number is too small. exiting program
	}
	cout<<endl;							//puts an end to the line after listing all of the coprime numbers
	return 0;
}
