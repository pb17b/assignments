#include<iostream>
using namespace std;


	const int ROWCAP = 100; 										//declares a global variable for a max of 100 per row
	const int COLCAP = 100;											//declares a global variable for a max of 100 per column

	void readValues(double mat[ROWCAP][COLCAP], int rows, int cols);					//sets the arguments for readvalues
	void printValues(double mat[ROWCAP][COLCAP], int rows, int cols);					//sets arguments for next two lines
	void matrixSearch(double mat[ROWCAP][COLCAP], int rows, int cols, double key, int &rpos, int &cpos);
	void findNorm(double mat[ROWCAP][COLCAP], int rows, int cols);	
	
int main()
{
	int ro;													//defines integers
	int co;
	double matrix[ROWCAP][COLCAP];										//defines doubles

	cout<<"Enter the number of rows: ";									//prompts user to enter in values 
	cin>>ro;
	cout<<"Enter the number of columns: ";
	cin>>co;
	cout<<"Enter the matrix:\n";
	readValues(matrix, ro, co);										//puts in the values from the readValues function

	cout<<"The matrix entered was:\n";
	printValues(matrix, ro, co);										//printValue from the function in later parts

	cout<<"The Maximum Absolute Column Sum Norm is: ";
	findNorm(matrix, ro, co);										//findNorm function calculates the norm of the matrix

	return 0;
}

void readValues(double mat[ROWCAP][COLCAP], int r, int c)							//sets arguments for the readvalues function
{
	for(int i=0; i<r; i++)											//initial for loop for i is less than rows
	{
		for(int j=0; j<c; j++)										//secondary loop for j is less than the number of columns
		{
			cin>>mat[i][j];										//reads out i and j in matrix
		}	
	}
}

void printValues(double mat[ROWCAP][COLCAP], int r, int c)							//sets arguments for the printValues function
{
	for(int i =0; i<r; i++)											//initial for loop for i is less than rows
	{
		for(int j=0; j<c; j++)										//secondary loop for j is less than the number of columns
		{
			cout<<mat[i][j]<<" ";									//prints out the ij matrix and then a blank space
		}
		cout<<endl;
	}
}

void findNorm(double mat[ROWCAP][COLCAP], int r, int c)								//sets arguments for the finNorm function
{
	int sum = 0;												//sets integers as equal to zero
	int normsum = 0;
	int columnnum = -1;											//the column num is set to -1 
	for(int i = 0; i<c; i++)										//initial for loop for i is less than the amount of columns
	{
		sum = 0;											//re initializes sum = 0 so that it resets per column
		for(int j = 0; j<r; j++)									//for loop looks at values for each row in a given column
		{
			sum += mat[j][i];									//sum is 0 plus the matrix value
			if (sum>normsum)									//if the sum is less than the normsum then we keep the value
			{
				normsum = sum;
				columnnum = i;
			}
		}
	}

	cout<<normsum<<endl;											//prints out the largest normsum value
}
