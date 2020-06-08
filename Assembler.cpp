#include "Assembler.hpp"
uint8_t Assembler::IndexMap(string Index){
	if(Index == "STP"){
		return 0;
	}
	else if(Index =="LSR"){
		return 1;
	}
	else if(Index =="ASR"){
		return 2;

	}
	else if(Index == "MOV"){
		return 3;
	}
	else if(Index == "ADD"){
		return 4;
	}
	else if(Index == "SUB"){
		return 5;
	}
	else if(Index == "MUL"){
		return 6;
	}
	else if(Index == "PUSH"){
		return 7;
	}
	else if(Index == "POP"){
		return 8;
	}
	else if(Index == "CMP"){
		return 9;
	}
	else if(Index == "INC"){
		return 10;
	}
	else if(Index == "DEC"){
		return 11;
	}
	else if(Index == "AND"){
		return 12;
	}
	else if(Index == "OR"){
		return 13;
	}
	else if(Index == "XOR"){
		return 14;
	}
	else if(Index == "NOT"){
		return 15;
	}
	else{
		return -1;
	}
}
uint8_t Assembler::OpMap(string Index){
	if(Index == "LDA"){
		return 0;
	}
	else if(Index =="STA"){
		return 1;
	}
	else if(Index =="ADD"){
		return 2;

	}
	else if(Index == "SUB"){
		return 3;
	}
	else if(Index == "MUL"){
		return 4;
	}
	else if(Index == "JMP"){
		return 5;
	}
	else if(Index == "JMI"){
		return 6;
	}
	else if(Index == "JEQ"){
		return 7;
	}
	else if(Index == "LDI"){
		return 8;
	}
	else if(Index == "LDN"){
		return 9;
	}
	else if(Index == "SSS"){
		return 10;
	}
	else if(Index == "JME"){
		return 11;
	}
	else if(Index == "CALL"){
		return 12;
	}
	else if(Index == "JGE"){
		return 13;
	}
	else if(Index == "CALL"){
		return 14;
	}
	else if(Index == "RET"){
		return 15;
	}
	else{
		return -1;
	}
}

void Assembler::Load(){
	Instruction IR;
	while(cin >> IR.Opcode){
		if(IR.Opcode == "MEM"){
			uint16_t addr1,data;
			cin >> addr1 >> data;
			MMap.insert(pair<uint16_t,uint16_t>(addr1,data));
		}
		else if(IR.Opcode == "SSS"){
			// cout << "debug"<< endl;
			bool b1;
			bool b2;
			cin >> b1;
			cin >> b2;
			string index;
			cin >> index;
			uint8_t rd;
			// cout << "rd : " << rd << endl;
			uint8_t rs;
			cin >> rd;
			cin >> rs;
			IR.Operand = (0x80)&(b1 << 7) | (0x8)&(b2 << 3) | (0xF00)&(IndexMap(index)<< 8) | (0x70)&( rd << 4 ) | (0x7)&rs;
			InCode.push_back(IR);
		}
		else{
			if(IR.Opcode != "RET"){
				cin >> IR.Operand;
			}else{
				IR.Operand = 0;
			}
			InCode.push_back(IR);
		}
	}
}
void Assembler::Assemble(){
	// cout << InCode.size() << endl;
	// cout << InCode[0].Opcode << " " << InCode[0].Operand << endl;
	// cout << hex << ((OpMap(InCode[0].Opcode) << 12) | InCode[0].Operand) << endl;
	for(int i = 0;i<InCode.size();i++){
		// cout << hex <<  InCode[i].Operand <<  endl;
		OutCode.push_back((OpMap(InCode[i].Opcode) << 12) | InCode[i].Operand);
	}
}
void Assembler::Out(){
		cout << "DEPTH = 4096;" << endl;
		cout << "WIDTH = 16;" << endl;
		cout << "ADDRESS_RADIX = HEX;" << endl;
		cout << "DATA_RADIX = HEX;" << endl;
		cout << "CONTENT" << endl;
		cout << "BEGIN" << endl;
		cout << "[0..FFF]: 0;" << endl;
	for(int i = 0;i<OutCode.size();i++){
		cout << i << "   :" << "   " << hex << OutCode[i]  << ";"<< endl; 
	}
	map<uint16_t,uint16_t>::iterator itr;
	for(itr = MMap.begin();itr != MMap.end();++itr){
		cout << itr->first << "   :" << "   " << hex << itr->second  << ";"<< endl; 
	}
	cout << "END;" << endl;
}
void Assembler::OutRAW(){
	for(int i = 0;i<OutCode.size();i++){
		cout << i << "   " << hex << OutCode[i]  <<endl; 
	}
	map<uint16_t,uint16_t>::iterator itr;
	for(itr = MMap.begin();itr != MMap.end();++itr){
		cout << itr->first << "   " << hex << itr->second << endl; 
	}
}