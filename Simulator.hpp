#ifndef Simulator_HPP
#define Simulator_HPP
#include <iostream>

using namespace std;

class Simulator{
	uint16_t Memory[4096];
	uint16_t pc = 0;
	uint16_t Regs[8];
	bool Carry = 0;
	int cycles = 0;
	bool end = false;
	uint8_t Flags = 0;
	uint16_t StackPtr = 0xFFF;
public:
	void readRAW();
	void outContents();
	void Simulate(int clockDelay);
	void SSS();
};


#endif
