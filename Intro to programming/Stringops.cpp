/* Parker Beasley
 * November 19th 2019
 * Section 1
 * Assignment 6 part 1
 * Due November 22nd
 * This project has the user enter in a string. sentences. and then it prints out the words, vowels, and punctuations count
 * Assume the user input is correct and that the code is correct
 * All work below was performed by Parker Beasley */



#include<iostream>
#include<cctype>
#include<cstring>
using namespace std;

void wordCount(char str[1000]);								//initializes the functions
void vowelCount(char str[1000]); 								
void puncCount(char str[1000]);
void findSubString(char str[1000]);

int main()
{
	char str[1000];									//sets the string to a max of 1000 characters
	cout<<"Enter the string: ";							//prompts user to enter in a string
	cin.getline(str, 1000);							//string is entered
	while (strcmp(str, "quit")){
		cout<<"Number of words: ";							
		wordCount(str);									//calls the word count function
		cout<<"\nNumber of vowels:\n";
		vowelCount(str);								//calls the vowel count function
		cout<<"Number of punctuations: ";
		puncCount(str);									//calls the punctuation count function
		findSubString(str);
		cout<<endl;
		cout<<"Enter the string: ";							//prompts user to enter in a string
		cin.getline(str, 1000);							//string is entered
	}

	return 0;
}

void wordCount(char str[1000])								//start of the word count function
{
	int words = 1;
	for(int i=0; i<strlen(str); i++)						//loops each element of the string
	{
		if(str[i] == ' ')							//if its a white space, iterate
		{
			++words;
		}
	}
	cout<<words;									//reads out words
}

void vowelCount(char str[1000])								//start of the vowel count function
{
	int a = 0;									//sets each vowel equal to zero, initially
	int e = 0;
	int i = 0;
	int o = 0;
	int u = 0;

	for(int x=0; x<strlen(str); x++)						//loops through each element in the string
	{
		if(str[x] == 'a' || str[x] == 'A')					//this sets the conditions for each vowel
		{
			a++;								//if the string comes across any of these vowels, it iterates and counts them
		}
		if(str[x] == 'e' || str[x] == 'E')
		{
			e++;
		}
		if(str[x] == 'i' || str[x] == 'I')
		{
			i++;
		}
		if(str[x] == 'o' || str[x] == 'O')
		{
			o++;
		}
		if(str[x] == 'u' || str[x] == 'U')
		{
			u++;
		}
	}
	cout<<"A: "<<a<<endl;								//reads out the amount of each vowel
	cout<<"E: "<<e<<endl;
	cout<<"I: "<<i<<endl;
	cout<<"O: "<<o<<endl;
	cout<<"U: "<<u<<endl;
}

void puncCount(char str[1000])
{											//starts the punctuation count function
	for(int  i = 0; i<strlen(str); i++)						//loops through the string
	{	if(ispunct(str[i]))
			punc++;								//if a punctuation is found, it iterates
	}			
	cout<<punc<<endl;								//reads out the punctuation amount
}

void findSubString(char str[1000])							//starts the find sub string function
{
	char word[]= "word";								//sets word as an array with the characters that spell 'word'
	char *ptr = strstr(str, word);							//sets a pointer equal to substring of the string. meaning
	//that if 'word' is found in ptr it is stored 
	if(ptr)
	{
		cout<<"\"word\" is a part of this string.";		//reads out that word is not a part of the string
	}
	else
	{
		cout<<"\"word\" is not a part of this string.";		//reads out that word is not a part of the string
	}
}

