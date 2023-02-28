/* Parker Beasley
 * October 21st 2019
 * Section 1
 * Assgnment 4 part 1
 * Due October 24th 2019
 * This project is to read in values and print them out backward
 * Assume that the program runs correctly and that user input is correct
 * All work below was performed by Parker Beasley*/

#include<iostream>
#include<cstdlib>
#include<cmath>
using namespace std;

int reverse(int);							//defines reverse as an integer
int value(int);								//defines value as an integer


int main()								//starts the main for the bulk of the functions
{
	
	int num;							//defines num as an integer
	int sum =0;							//sum is equal to zero

	cout<<"Enter the numbers:\n";					//tells user to enter a set of numbers
	do								//starts a do while statement that reads in numbers
	{
		cin>>num;						//enter in a number
		sum=sum+value(num);					//equates the sum 
	}while (num!=0);						//while the number is not zero continue on

	cout<<"The Sum is "<<sum<<endl;					//takes the total value of the sum
	return 0;							
}
int reverse(int num)							//starts reverse as an integer so it can read in num
{
	int rev=0;							//defines rev as zero
	while (num!=0)							//for num is not equal to zero
	{
	rev = rev*10 + num%10;						//will define rev as times ten and plus modulus 10
	num=num/10;							//defines num as a function
	}
	return rev;							//returns the rev value 
}
int value(int num)							//starts value as an integer so it can read in the value that is calculated
{
	if(num!=0) 							//if the number is not equal to zero
	{
	return abs(reverse(num) - rand() % num);			//will return the absolute value of the reverse number minus a random number modulus num
	}
}	
	



