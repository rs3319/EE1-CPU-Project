#include "Assembler.hpp"
#include <iostream>
using namespace std;

int main(int argc, char** argv){
	Assembler tester;
	tester.Load();
	tester.Assemble();
	if(atoi(argv[1]) == 1){
	tester.Out();
	}
	else{
		tester.OutRAW();
	}
}