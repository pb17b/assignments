/* Parker Beasley
 * November 30th 2019
 * Section 1
 * Assignment 7 part 3
 * Due December 6th 2019
 * This project has us create a dungeons and dragons code 
 * Assume that the code written and used is correct and works properly
 * All work below was performed by Parker Beasley*/

#include<fstream>
#include<cstring>
using namespace std;

struct Move								//move as a structure so you can pull these variables in main
{
	int damage;							//defines variables
	char name[50];
};

struct Character							//character as a structure so you can pull variables in main
{
	char name[50];							//defines all the variables
	char char_class[50];
	int hitPoints, armorClass;
	bool isAlive = true;
	char moveName[50];
};									//have to close struct with a semicolon

int main()
{
	ifstream character;						//input of character, and session, output of alive
	ifstream session;
	ofstream alive;
	int numMoves, numChar, numAttacks;				//defining
	Move* M;							//dynamic memory
	Character* C;


	character.open("character.txt");				//opens character, session, and alive files
	session.open("session.txt");	
	alive.open("alive.txt");
	if(character)							//starts the character input
	{
		character>>numMoves;					//reads in number of moves

		M = new Move[numMoves]; 				//dynamic array of the move 
		for(int i =0; i<numMoves; i++)				//loops through the moves
		{
			character.getline(M[i].name, 50, '\t');		//sets the character array as name of character, 50 spaces, tab as delimeter
			character>>M[i].damage;				//reads in damage
			character.ignore();
		}
		character>>numChar;					//reads in character
		character.ignore();
		C = new Character[numChar];				//dynamic memory of character
		for(int i =0; i<numChar; i++)				//loops through characters
		{
			character.getline(C[i].name, 50, '\t');		//reads in the name, char_class, hitPoints, armorClass
			character.getline(C[i].char_class, 50, '\t');
			character>>C[i].hitPoints;
			character>>C[i].armorClass;
			character.ignore();
			character.getline(C[i].moveName, 50);		//reads the moveName
		}
	}							
	if(session)							//starts the intput for session
	{
		session>>numAttacks;					//the number of attacks read in
		session.ignore();
		for(int i =0; i<numAttacks; i++)			//loops the attacks
		{
			char attacker[50], move[50], target[50];	//sets variables
			int roll;
			session.getline(attacker, 50, '\t');		//able to read in the attacker, move, and target
			session.getline(move, 50, '\t');
			session.getline(target, 50, '\t');
			session>>roll;					//reads the roll int

			int a, t, m;					//ints to store
			for(int i=0; i<numChar; i++)			//loops the characters
			{
				if(strcmp(C[i].name, attacker) == 0)	//compares name and attacker
					a = i;				//stores a as the character
				if(strcmp(C[i].name, target) == 0)	//same thing as above but with target
					t = i;
			}
			for(int  i =0; i<numMoves; i++)			//loops the moves
			{
				if(strcmp(M[i].name, move) == 0)	//compares name of move and the move
					m = i;				//stores as m
			}
			bool signature = false;				//sets sig and armor as false
			bool armorcheck = false;

			if(strcmp(C[a].name, move) ==0)			//compares name of attack and move
				signature = true;			//if same, true

			if(roll>=C[t].armorClass)			//compares roll to armor
				armorcheck = true;			//if armor is greater than class, true

			C[t].hitPoints -= M[m].damage;			//takes damage from the target
			if(C[t].hitPoints < 0)				//defines when character is dead
				C[t].isAlive = false;			//sets alive to false
		}
	}	
	
	if(alive)							//output is into alive	
	{
		for(int i =0; i<numChar; i++)				//loops the characters
		{	
			if(C[i].isAlive)				//if character is alive, it prints out the character with health
				alive<<C[i].name<<'\t' <<C[i].hitPoints<<endl;
		}
	}
	alive.close();							//closes the structures
	session.close();
	character.close();
	delete [] M;							//deletes dynamic memory so it doesn't leak
	delete [] C;
	
	return 0;	
}



