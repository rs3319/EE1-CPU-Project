#include "Assembler.hpp"
#include <iostream>
using namespace std;

int main(){
	Assembler tester;
	tester.Load();
	tester.Assemble();
	tester.OutRAW();
}