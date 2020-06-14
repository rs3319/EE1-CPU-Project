------------------------------------------------------------------------------

				          The SAR CPU Assembler

------------------------------------------------------------------------------

The SAR CPU consists of 32 (31 exclusing SSS) instructions, instructions prefixed with SSS have a different format to the other instructions as they have the carry mode and register select bits embedded within them.

This assembler will read instructions from cin (in proper format and seperated by whitespace) and will output the complete .mif file to cout.

All operands are taken in decimal value and are converted to hexidecimal when making the .mif file.

For all the instructions and how to use them, please consult the SAR ISA Document.

Special Instructions:

MEM (address) (data value):
	Stores a data value at the address specified by the instruction prior to execution of the code. (All values are in decimal)

SSS (Carry bit 1) (Carry bit 0) (Operation) (Rd) (Rs)

For .MIF Export:
	
	Run the Assembler with an arguement of 1.

	It will read assembly from cin.

For the Simulator: 
	
	Provide permissions for Simulate.sh using chmod +x.

	Run Simulate.sh, It will run the assembly code in the file "test.txt".

	The script will prompt the user for an Instruction execution period, this is the time between instructions being executed in seconds, leave it at 0 for maximum possible speed.

