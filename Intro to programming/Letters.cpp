/* Parker Beasley
 * October 8th 2019
 * Section 1
 * Assignment 3, part 3
 * Due October 9th 2019
 * This project tells the user to enter a letter size, and then will print out a letter in that size. The letters are restricted to S, O, and P
 * Assume that the user entered in the correct input, however, they will be notified if done incorrectly. Assume that the code is in the correct format and works properly. 
 * All work below was performed by Parker Beasley*/


#include<iostream>
using namespace std;
int main()
{
	int size;											//integer size
	char choice;											//defines choice as a character
	char letter;											//defines letter as a character

	
	cout<<"Welcome to the letter printer.\n";							//Prints a welcmoe message
	
	do												//start of a very long loop
	{
		cout<<"Enter the size:";								//enter the size
		cin>>size;

		while(size<5 || size%2==0)								//requirements for the size
		{
		cout<<"Invalid size. Enter the size again:";						//asked to enter size again if invalid
		cin>>size;
		continue;										//once valid size, it continues
		}
	
		cout<<"Enter the letter:";								//enter a lettter
		cin>>letter;										//reads in a letter

		while(letter != 'O' && letter != 'P' && letter != 'S')					//if letter arent valid ones, will print an error message
		{
		cout<<"Invailid letter. Enter the letter again:";
		cin>>letter;
		continue;										//continues if valid letter
		}
		if(letter =='O')									//if O
		{
			for(int i=0; i<size; i++)							//defines first integer for O
			{
				cout<<"*";								//prints out *
				for(int j=0; j<size-2; j++)						//defines second integer for O
				{			
					if(i==0 || i==size-1)						//if i is something
					{
						cout<<"*";						//prints out *
					}
					else								
					{
						cout<<" ";						//if anything else prints nothing
					}
				}
				cout<<"*"<<endl;							//prints a *
			}
		}
	
	
		else if(letter == 'S')									//for letter S
		{
			for(int i=0; i<size; i++)							//defines first integer for S
			{
				for(int j=0; j<size-1; j++)						//defines second integer for S
				{
					if(i==0 || i== size/2 || i==size-1)				//specific requirements for i
					{
						cout<<"*";						//prints * if met
					}
					else if(i>size/2)
					{
						cout<<" ";						//if anything else prints nothing
					}
				}
				cout<<"*";								// prints a *
				cout<<endl;								//end line
			}
			cout<<endl;
		}

	
		else if (letter == 'P')									//for letter P
		{
			for(int i=0; i<size; i++)							//defines first integer for P
			{
				cout<<"*";								//prints a *
				for(int j=0; j<size-2; j++)						//defines second integer for P
				{
					if(i==0 || i==size/2)						//requirements for i
					{
						cout<<"*";						//prints a *
					}
					else if(i<size/2)						//if size/2
					{
						cout<<" ";						//prints nothing
					}
			}
			if(i<=size/2)									//if i is less than or equal to size/2
			{
				cout<<"*";								//prints a *
			}
			cout<<endl;
			}
		}
	
		cout<<"Would you like to continue?";							//asks if user wants to conitinue
		cin>>choice;										//reads out the choice
	
	}while (choice == 'Y');										//if answer is Y, continues back to the top
	
	 


	return 0;
}
