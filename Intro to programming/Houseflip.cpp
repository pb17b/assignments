/* Parker Beasley
 * November 17th 2019
 * Section 1
 * Assigment 6 part 3
 * Due November 22nd 2019
 * This project has us print a house both forward and backward
 * Assume that all user input and the code is correct
 * All work below was performed by Parker Beasley*/


#include<iostream>
#include<string>
using namespace std;

string flipHouse();

int main()
{
	cout<<flipHouse();						//prints out the entire function 

	return 0;
}

string flipHouse()							//flipHouse function defined
{									//prompting and gathering
	int n;
	cout<<"Enter the number of lines: ";
	cin>> n;
	string arr[n];
	cin.ignore();							//reads up to \n(cin) and discards the trailing new line(ignore)
	string s, s2;
	int maxW = 0;
	cout<<"Enter the house image:\n";
	
	for(int j = 0; j<n; j++)					
	{
		getline(cin, s, '\n');
									//flipping characters and reversing
										//reversing here
		for(int i =0; i<s.length()/2; i++)
		{
			swap(s[i], s[s.length() -1 -i]);
		}
		
										//flipping here. different characters that is
		for(int k = 0; k<s.length(); k++)
		{
			if (s[k] == '\\')
			{
				s[k] = '/';
			}
			else if (s[k] == '/')
			{	
				s[k] = '\\';
			}
			else if (s[k] == '[')
			{
				s[k] = ']';
			}
			else if (s[k] == ']')
			{
				s[k] = '[';
			}
		}								//end of flipping
	
		arr[j] =s;						//sets the string s as array
		if(s.length()>maxW)					//if the length of the string is bigger
			maxW = s.length();				//than the previous line, then store that new value
		
	}								//end of first line loop
	cout<<"The mirrored house is:\n";				//c outs the mirrored image

	for(int i =0; i<n; i++)						//start of second line loop
	{
		int spaces = maxW - arr[i].length();			//defines spaces as the maximum width of the line minus the length of the arr of i that was defined at the top
		while(spaces--)						
			arr[i] = ' ' + arr[i];
		s2+= arr[i] + '\n';					//s2 equals s2 plus the array of i, plus a new line
	}
	return s2;							//returns s2, which is the reversed image
}
