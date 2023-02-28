#include<iostream>
#include<cstdlib>
#include<cmath>
using namespace std;


int reverse(int);					//reverse statement from part 1 of hw intialization
int main()
{
	int num1;					//defines num1
	bool primes=true;				//initializes the statment as true
	cout<<"Please enter the upper limit: ";		//prompts user to enter the upper limit
	cin>>num1;					//reads out the upper limit
	if(num1<=1)					//if num is less than one
	{
	return 0;					//doesnt run
	}
	else
	{
	for(int i=2; i<=num1; i++)			//if num is not less than one it runs
	{
		for(int j=2; j<i/2; j++)		//for j is starting at 2, and i is divided by 2
		{
		if(i%j==0)				//if its modulus is equal to zero
		{
		primes=false;				//it is false
		}
		}
		if(primes==true)			//if its true continues on
		{
		if(reverse(i) == i)			//it reverses i 
		{
		cout<<i<<" ";				//reads out the value
		}
		}
		primes=true;				//then primes is true
		}
	}
	cout<<endl;
	return 0;					//returns
}
int reverse(int num2)					//second function
{
	int rev=0;					//defines rev as equal to zero
	while(num2!=0)					//while the num is not equal to zero
	{
	rev= rev*10+num2%10;				//it will run this function
	num2=num2/10;					//and then plug in the value to this function
	}
	return rev;					//returns the reverse as rev
}

