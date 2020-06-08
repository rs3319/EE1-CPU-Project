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

SSS (Carry) (Operation) (Rd) (Rs)

