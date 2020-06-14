#include "Simulator.hpp"
#include <unistd.h>
void Simulator::readRAW(){
	for(int i = 0; i<4096;i++){ //init to 0
		Memory[i] = 0;
	}
	for(int i = 0; i < 8; i++){
			Regs[i] = 0;
		}
	uint16_t currrentaddr;
	uint16_t currentdata;
	while(cin >> hex >> currrentaddr){
		cin >> hex >>  currentdata;
		Memory[currrentaddr] = currentdata;
	}
}
void Simulator::outContents(){
		//cout << "--------PC: " << pc-1 << ": " << hex << Memory[pc-1] <<  "-------------" << endl;
		cout << "Total Cycles Elapsed: " << dec << cycles << endl;
		cout << "Registers: " << endl;
		for(int i = 0; i < 8; i++){
			cout << "R" << i << ": " << hex << Regs[i] << endl;
		}
		cout << "Flags: " << hex << Flags << endl;
		cout << "Carry: " << hex <<Carry << endl;
		cout << "Stack Pointer: " << hex <<  StackPtr << endl;
		cout << "Memory: " << endl;
		for(int i = 0; i<4096;i++){ //out memory
		if(Memory[i] != 0){
			cout << i << " " << hex << Memory[i] << endl;
		}
	}
}
void Simulator::Simulate(int clockDelay){

	while(Memory[pc] != 0 && (end == false)){
		cout << "--------PC: " << pc << ": " << hex << Memory[pc] <<  "-------------" << endl;
		//cout << clockDelay << endl;
		uint8_t opcode = (0xF000 & Memory[pc])>>12;
		uint16_t operand = (0xFFF & Memory[pc]);
		sleep(clockDelay);
		switch(opcode){
			case 0x0:
				Regs[0] = Memory[operand];
				pc++;
				cycles += 2;
				break;
			case 0x1:
				Memory[operand] = Regs[0];
				pc++;
				cycles += 2;
				break;
			case 0x2:
				Regs[0] += Memory[operand];
				pc++;
				cycles += 2;
				break;
			case 0x3:
				Regs[0] -= Memory[operand];
				pc++;
				cycles += 2;
				break;
			case 0x4:
				Regs[0] = Regs[0]*Memory[operand];
				pc++;
				cycles += 2;
				break;
			case 0x5:
				pc = operand;
				cycles += 2;
				break;
			case 0x6:
				if((Regs[0] >> 12) >= 8){
					pc = operand;
				}
				else{
					pc++;
				}
				cycles += 2;
				break;
			case 0x7:
				if(Regs[0] == 0){
					pc = operand;
				}
				else{
					pc++;
				}
				cycles += 2;
				break;
			case 0x8:
				Regs[0] = operand;
				pc++;
				cycles += 2;
				break;
			case 0x9:
				Regs[0] = Memory[Memory[operand]];
				pc++;
				cycles += 3;
				break;
			case 0xa:
				SSS();
				cycles += 2;
				break;
			case 0xb:
				if(Flags >> 2){
					pc = operand;
				}
				else{
					pc++;
				}
				cycles += 2;
				break;
			case 0xc:
				if((Flags >> 1)&0x1){
					pc = operand;
				}
				else{
					pc++;
				}
				cycles += 2;
				break;
			case 0xd:
				if(Flags&0x1){
					pc = operand;
				}
				else{
					pc++;
				}
				cycles += 2;
				break;
			case 0xe:
				Memory[StackPtr] = pc+1;
				StackPtr--;
				pc = operand;
				cycles += 2;
				break;
			case 0xf:
				StackPtr++;
				pc = Memory[StackPtr];
				cycles += 3;
				break;

		}
		cout << "----------------------------------------------" << endl;
		outContents();
		cout << "----------------------------------------------" << endl;
	}
}
void Simulator::SSS(){
	//cout << "SSS" << "---" << endl;
	uint8_t Cbits = ((Memory[pc] & 0x80) >> 6 )|((Memory[pc] & 0x8) >> 3);
	uint8_t Rd = (Memory[pc]) & 0x7;
	uint8_t Rs = ((Memory[pc]) & 0x70)>> 4;
	bool CarryIn;
	if(Cbits == 0){
		CarryIn = 0;
	}
	else if(Cbits == 1){
		CarryIn = 1;
	}
	else if(Cbits == 2){
		CarryIn = Carry;
	}
	else{
		CarryIn = ((Regs[Rd] & 0x8000) >> 15);
	}
	uint8_t Index = (Memory[pc] >> 8) & 0xF;
	switch(Index){
		case 0x0:
			end = true;
			pc++;
			break;
		case 0x1:
			Regs[Rs] = Regs[Rs] >> 1;
			pc++;
			break;
		case 0x2:
			Regs[Rs] = ((Regs[Rs]&0x8000)<<1) | Regs[Rs] >> 1;
			pc++;
			break;
		case 0x3:
			//cout << "DEBUG" << " " << (int)Rs << " " << (int)Rd << endl;
			Regs[Rs] = Regs[Rd];
			pc++;
			break;
		case 0x4:
			Regs[Rs] += (Regs[Rd] + CarryIn);
			pc++;
			break;
		case 0x5:
			Regs[Rs] -= (Regs[Rd] + CarryIn);
			pc++;
			break;
		case 0x6:
			Regs[Rs] *= Regs[Rd];
			pc++;
			break;
		case 0x7:
			Memory[StackPtr] = Regs[Rs];
			StackPtr--;
			pc++;
			break;
		case 0x8:
			StackPtr++;
			Regs[Rs] = Memory[StackPtr];
			pc++;
			break;
		case 0x9:
			if(Regs[Rs] == Regs[Rd]){
				Flags |= 0x4;
			}
			else{
				Flags &= 0xfb;
			}
			if(Regs[Rs] > Regs[Rd]){
				Flags |= 0x2;
			}
			else{
				Flags &= 0xfd;
			}
			if(Regs[Rs] >= Regs[Rd]){
				Flags |= 0x1;
			}
			else{
				Flags &= 0xfe;
			}
			pc++;
			break;
		case 0xa:
			Regs[Rs]++;
			pc++;
			break;
		case 0xb:
			Regs[Rs]--;
			pc++;
			break;
		case 0xc:
			Regs[Rs] &= Regs[Rd];
			pc++;
			break;
		case 0xd:
			Regs[Rs] |= Regs[Rd];
			pc++;
			break;
		case 0xe:
			Regs[Rs] ^= Regs[Rd];
			pc++;
			break;
		case 0xf:
			Regs[Rs] = ~Regs[Rd];
			pc++;
			break;
	}
}