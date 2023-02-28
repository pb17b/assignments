/* Parker Beasley
 * October 22nd 2019
 * Section 1
 * Homework 4 part 2
 * Due October 24th 2019
 * The project has a goal to write a mclaurin series based on given input
 * Assume that the code is written correctly and that the user input is correct
 * All work below was performed by Parker Beasley*/



#include<iostream>
#include<cstdlib>
#include<cmath>
#include<iomanip>
using namespace std;


double factorial(double, double);				//defines factorial as a double with 2 values
double sum(double, double);					//defines sum as a double with 2 values

int main()							//starts int main
{
	double x, n;						//states x and n as doubles
	cout<<"Enter the value of x: ";				//prompts user to enter in a value for x
	cin>>x;							//reads out x
	cout<<"Enter the number of terms: ";			//prompts user to enter the number of terms that they wish
	cin>>n;							//reads out n
	cout<<fixed<<setprecision(3);				//sets a fixed amount of decimals. 3
	cout<<"sin("<<x<<")= "<<sum(n, x)<<endl;		//reads out 'sin' of the x value and that equal to the sum of n and x function
	return 0;
}
double factorial(double m, double facts)			//defines m and facts as doubles because factorial is used already and it needs to be read in differently
{
	for(int i=1; i<=(2*m+1) ;i++)				//for loop starting at 1 for factorial values
	{
		facts = facts * i;				//facts is the factorial amount multiplied by the i value
	}
	return facts;						//returns the facts value
}
double sum(double n, double x)					//defines n and x as doubles for the double sum 
{
	double term1;						//defines double for term 1 2 and 3
	double term2;
	double term3;
	double finalsum = 0;					//finalsum as a double that starts at 0
	for (int j=0; j<=n; j++)				//j which is the k value in the mclaurin series is less than n, the number of terms
	{
	term1=(-1,j);						//first part of mclaurin series. numerator
	term2=(factorial (n,1));				//second part of mclaurin series. denominator
	term3=pow(x,2*j+1); 					//third part of mclaurin series. part multiplied
	finalsum = finalsum + term1/term2 * term3;		//final sum are the terms put in order that equal the mclaurin series
	}
	return finalsum;					//returns the final sum of mclaurin series
}	
