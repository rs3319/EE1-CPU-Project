#include "Simulator.hpp"
int main(int argc,char **argv){
	Simulator tester;
	// cout << "debug: init" << endl;
	tester.readRAW();
	//cout << "A" << argv[1] << endl;
	// cout << "debug: read" << endl;
	// tester.outContents();
	// cout << "debug: out" << endl;
	tester.Simulate(atoi(argv[1]));
}