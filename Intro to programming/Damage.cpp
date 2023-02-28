/* Parker Beasley
 * September 21st 2019
 * Section 1 
 * Assignment #3
 * Due September 27th
 * This project is about prompting a user to enter in numbers and make choices that will ultimately calcluate the damage meter of a sharknado
 * Assume that all code in this script works correctly
 *
 * All work below was performed by Parker Beasley */



#include<iostream>
#include<iomanip>
using namespace std;
int main ()

{
	
	char choice;																	//defines choice as a character
	double windspeed, duration, totalspeed, damage;													//The weights of the sharks are listed here
	const double Bshark = 14500;
	const double GWshark = 2270;
	const double HHshark = 230;
	const double Wshark = 21000;
	const double BUshark = 130;
	const double Lshark = 183; 

	const char bS = 'B';																//defines the cases as the shark choices
	const char gwS = 'G';
	const char hhS = 'H';
	const char wS = 'W';
	const char buS = 'U';
	const char lS = 'L'; 

	cout<<"Below are the names of the Sharks that you can choose from. They are listed by a letter."<<endl;						//The names of the sharks are listed here
	cout<<"Basking Shark - B"<<endl;														//This starts the defining of each shark
	cout<<"Great White Shark - G"<<endl;
	cout<<"Hammerhead Shark - H"<<endl;
	cout<<"Whale Shark - W"<<endl;
	cout<<"Bull Shark - U"<<endl;
	cout<<"Lemon Shark - L"<<endl;															//This ends the defining of each shark

	cout<<"Enter in your Shark of choice:";														//Orders to pick a shark
	cin>>choice;																	//Choice of shark

	switch (choice)																	//opens the switch in terms of choice
	{
		case bS:																//first case for basking shark
			cout<<"Enter in the duration you would like the tornado to last in terms of seconds:";
			cin>>duration;															//duration of the tornado in seconds
			cout<<"Enter in the the windspeed in miles per hour:";
			cin>>windspeed;															//windspeed of tornado in miles per hour
			cout<<fixed<<setprecision(2);													//sets to 2 decimal places
			totalspeed = windspeed * .447;													//converts windspeed from m/s to mph
			damage = totalspeed * Bshark * duration;											//total damage inflicted by the sharknado
			cout<<"Damage done by the Sharknado:"<<damage<<endl;
			break;																//break stops the reading if bS is satisfied
																			//EVERY CASE REPEATS FROM HERE WITH RESPECT TO THE DIFFERENT CHOICE IN SHARK
		case gwS:
			cout<<"Enter in the duration you would like the tornado to last in terms of seconds:";
			cin>>duration;
			cout<<"Enter in the windspeed in miles per hour:";
			cin>>windspeed;
			cout<<fixed<<setprecision(2);
			totalspeed = windspeed * .447;
			damage = totalspeed * GWshark * duration;
	 		cout<<"Damage done by the Sharknado:"<<damage<<endl;
			break;
			
		case hhS:
			cout<<"Enter in the duration you would like the tornado to last in terms of seconds:";
			cin>>duration;
			cout<<"Enter in the windspeed in miles per hour:";
			cin>>windspeed;	
			cout<<fixed<<setprecision(2);
			totalspeed = windspeed * .447;
			damage = totalspeed * HHshark * duration;
			cout<<"Damage done by the Sharknado:"<<damage<<endl;
			break;
	
		case wS:
			cout<<"Enter in the duration you would like the tornado to last in terms of seconds:";
			cin>>duration;
			cout<<"Enter the windspeed in miles per hour:";
			cin>>windspeed;
			cout<<fixed<<setprecision(2);
			totalspeed = windspeed * .447;
			damage = windspeed * Wshark * duration;
			cout<<"Damage done by the Sharknado:"<<damage<<endl;	
			break;
	
		case buS:
			cout<<"Enter in the duration you would like the tornado to last in terms of seconds:";
			cin>>duration;
			cout<<"Enter the windspeed in miles per hour:";
			cin>>windspeed;
			cout<<fixed<<setprecision(2);
			totalspeed = windspeed * .447;
			damage = windspeed * BUshark * duration;
			cout<<"Damage done by the Sharknado:"<<damage<<endl;
			break;

		case lS:
			cout<<"Enter in the duration you would like the tornado to last in terms of secons:";
			cin>>duration;
			cout<<"Enter the windspeed in miles per hour:";
			cin>>windspeed;
			cout<<fixed<<setprecision(2);
			totalspeed = windspeed * .447;
			damage = windspeed * Lshark * duration;
			cout<<"Damage done by the Sharknado:"<<damage<<endl;
			break;	

		default:
			cout<<"The Shark that you tried to enter is not a valid choice. Please rerun the program and enter in a valid option.";		//if an invalid shark selection is entered
						

	}																		//closes the switch



	return 0;
}

