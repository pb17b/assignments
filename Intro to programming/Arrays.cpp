#include<iostream>
using namespace std;

	const int CAPACITY = 100;									//declares capacity as 100 and a global constant

	void remove(double arr[CAPACITY], int pos, int size);						//declares constants for the functions remove, insert, cyclicshift and sort
	void insert(double arr[CAPACITY], double num, int pos, int size);				//this states them as function that can be called upon
	void cyclicShift(double arr[CAPACITY], int size);
	void sort(double arr[CAPACITY], int size);


int main()
{
	double array[CAPACITY];										//declares variables as integers
	int opt, shift, pos;
	double num;
	int size = 0;
	cout<<"Enter the number of elements you want to enter (Max 100): ";				//tells the user to enter in the elements and size
	cin>>size;
	cout<<"Enter "<<size<<" numbers"<<endl;
	for(int i=0; i<size; i++)
		cin>>array[i];
do {
	cout<<"1. Insert an element \n";								//this is the menu that the user can choose options from
	cout<<"2. Remove an element \n";
	cout<<"3. Print the array \n";
	cout<<"4. Cyclic Right Shift \n";
	cout<<"5. Sort the array \n";
	cout<<"6. Exit \n";
	cout<<"Enter your option: ";
	cin>>opt;
	switch(opt)											//starts the switch statement for entering in a certain option
	{
		case 1: 
			cout<<"Enter the number: ";							//case one is the insert statement that tells the user what to do, will insert a value
			cin>>num;
			cout<<"Enter the position: ";
			cin>>pos;
			cout<<"Element inserted.\n";
			insert(array, num, pos, size++);
			break;
		case 2:
			cout<<"Enter the element: ";							//case two will remove a number from the array where user chooses
			cin>>pos;
			cout<<"Element deleted \n";
			remove(array, pos, size--);	
			break;
		case 3:
			cout<<"\nThe array is: \n";							//case three will print out what the array is currently at that instant
			for(int i=0; i<size; i++)
				cout<<array[i]<<"\t";
			cout<<endl;
			break;
		case 4:
			cout<<"Elements shifted.\n";							//will shift the array one to the right and the last element is now the first
			cyclicShift(array, size);
			break;
		case 5:
			cout<<"The array is:\n ";							//will sort the array in terms of smallest to largest
			sort(array, size);
			break;
		case 6:
			cout<<"Goodbye!"<<endl;								//will say goodbye to the user when they choose exit
			break;
		default: cout<<"Invalid Choice."<<endl;							//defaults to an invalid option if 1-6 is not entered
	}
	}while (opt != 6);										//if option is not 6, returns


	return 0;
}

void cyclicShift(double arr[CAPACITY], int size)							//sets parameters for the shift function
{
	int last = arr[size-1];										//takes the last number in array and sets it to the front
	for(int i=size-1; i>0; i--)									//sets it as a 0 index
	{
		arr[i] = arr[i-1];									//shifts to the right
	}
	arr[0] = last;											//moves last term to the first
}

void sort(double arr[CAPACITY], int size)								//sets arguments for sort function
{
	for(int i = 0; i<size-1; i++)									//sets as 0 index for the size of the array
	{
		for(int j = 0; j<size-i-1; j++)								//compares the element to every other element
		{
			if(arr[j]>arr[j+1])								//if j is less than j+1 then it proceeds and sets that terms order 
			{
				int temp = arr[j];							//looks at the element and moves it accordingly in order of smallest to largest
				arr[j] = arr[j+1];
				arr[j+1] = temp;
			}
		}
	}
}

void remove(double arr[CAPACITY], int pos, int size)							//sets arguments for the remove function
{
	for(int i=pos; i<size-1; i++)									//sets i as the position, and for pos is less than the size minus one 
		arr[i] = arr[i+1];									//the array of the position is equal to the array plus one 
}													//this is because we are adding one spot to the array where we removed a spot

void insert(double arr[CAPACITY], double num, int pos, int size)					//sets arguments for the insert function
{
	for(int i=size; i>pos; i--)									//for i is greater than the pos it inserts the number chosen by the user in the given position
		arr[i] = arr[i-1];									//moves the arr to the right and leaves a spot for the number to be inserted
	arr[pos] = num;
}
