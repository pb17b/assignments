/* Parker Beasley
 * November 30th 2019
 * Section 1
 * Assignment 7 part 2
 * Due December 6th 2019
 * This project asks us to create a snake game with the user input
 * Assume that all user input is correct and that the code runs properly
 * All work below was performed by Parker Beasley*/

#include<iostream>
using namespace std;

char ** createField (int width, int length);						//createField using dynamic memory, length and width are the parameters
void playGame(char ** arr, int width, int length);					//playGame with parameters as a char array of two as a pointer and width and length

int main()
{
	int length, width;								//defining length and width
	cout<<"Enter the number of rows: ";						//prompts user entry
	cin>>width;
	cout<<"Enter the number of columns: ";
	cin>>length;
	
	char ** arr = createField(length, width);					//calls the createField function and stores it as a pointer
	playGame(arr, length, width);							//calls the playGame function
	for(int i=0; i<width; i++)							
		delete [] arr[i];							//deletes the dynamic array
	delete [] arr;
}

char ** createField (int length, int width)						//createField function with length and width as parameters and a 2D array of characters
{
	int N;
	char ** arr = new char * [width];						//dynamic memory allocation
	for(int i = 0; i<width; i++)							//loops through the width
	{
		arr[i] = new char[length];						//the array of the width is a char of length
	}	
	for(int i = 0; i<width; i++)							//this loop prints out a '.' for every spot
	{
		for(int j = 0; j<length; j++)
		{
			arr[i][j]='.';
		}
	}
	for(int c = 0; c<length; c++)							//the next 4 loops allow an iteration through the perimeter of the field and set them to 'W'
	{
		arr[0][c]='W';
	}
	for(int r = 0; r<width; r++)
	{
		arr[r][0]='W';
	}
	for(int c =0; c<length; c++)
	{
		arr[width-1][c]='W';
	}
	for(int r =0; r<width; r++)
	{
		arr[r][length-1]='W';
	}

	cout<<"Enter the number of obstacles: ";					//prompts user input
	cin>>N;	
	int r, c;
	char dummy;
	cout<<"Enter the locations of the obstacles:\n";	
	for(int i=0; i<N; i++)								//loop of the location for obstacles
	{
		cin>>r>>dummy>>c;  							//(personal comment) can also use cin.ignore();	
		arr[r][c]='O';
	}
		
	return arr;									//returns array which then gets sent to playGame and eventual to main
}

void playGame (char ** arr, int length, int width)					//playGame function
{
	int T;
	int r, c, z;
	char x;
	char dummy;
	cout<<"Enter the location of the gate: ";					//prompts user input
	cin>>r>>dummy>>c;
	arr[r][c]='G';									//places 'G' as the gate
	cout<<"Enter the number of turns: ";						//prompts user input
	cin>>T;
	cout<<"Enter the turns:\n";
	//loops the placement of turns for user input

	cin>>x>>z;									//reads in user input
	bool alive = true;								// alive as true
	for(int i =0; i<T; i++)								//loops the amount of turns entered
	{
		bool hit = false;							//sets hit as false
		while(alive){								//loops as long as alive
		for(int k = 0; k<z; k++)						//loops the distance of the direction
		{
			if(!hit)							//if hit is true
			{
				switch (x){						//starts switch statement
					case 'D':					//cases for Down, Up, Left, Right
					for(int j =0; j<z; j++)
					{
						if(arr[r+1][c] == 'O')			//for all of the cases, if snake runs into 'O', it goes to the next direction input
							hit = true;
						else if(arr[r+1][c] == 'S'){		//for all of the cases, if snake runs into 'S'/itself, it prints the array
							alive = false; hit = true;}
						else
							arr[++r][c] = 'S';		//if neither of the above two conditions, then it prins 'S', the snake
					}
					cin>>x>>z;					//reads in the next user input, so it can go back to the loops and check initial conditions with directions
					break;						//goes back to the top to check conditions

					case 'R':
					for(int j =0; j<z; j++)
					{
						if(arr[r][c+1] == 'O')
							hit = true;
						else if(arr[r][c+1] == 'S'){
							alive = false; hit = true;}
						else
							arr[r][++c] = 'S';
					}
					cin>>x>>z;
					break;
				

					case 'U':
					for(int j =0; j<z; j++)
					{
						if(arr[r-1][c] == 'O')
							hit = true;
						else if(arr[r-1][c] == 'S'){
							alive = false; hit = true;}
						else
							arr[--r][c] = 'S';
					}
					cin>>x>>z;
					break;
			

					case 'L':
					for(int j =0; j<z; j++)
					{
						if(arr[r][c-1] == 'O')
							hit = true;
						else if(arr[r][c-1] == 'S'){
							alive = false; hit = true;}
						else
							arr[r][--c] = 'S';
					}
					cin>>x>>z;
					break;
					}
				}
			}
		}
	}

	//print
	cout<<"The field is:\n";
	for(int i = 0; i<width; i++)							//loop that prints out the array, which is the field
	{
		for(int j = 0; j<length; j++)
		{
			cout<<arr[i][j];
		}
		cout<<endl;
	}
}
