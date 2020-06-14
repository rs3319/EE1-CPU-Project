g++ tester.cpp Assembler.cpp -o Assembler
g++ simTest.cpp Simulator.cpp -o Simulator
read -p "Instruction execution period in seconds (Real time program interpretation): " Cspeed
./Assembler 0 < test.txt | ./Simulator $Cspeed