FPGA Implementation:
Our FPGA implementation of this circuit was put on a Zybo Z7-10 FPGA board, with an 8 LED pmod and a 4 Switch PMOD
The bitstream was created by combining the Zybo-Z7 constraints file, all relevant parts of the calucator circuit, and a button debouncer
The button debouncer uses the 33.333MHz clock on the board to create a relevant delay (around 6 miliseconds, 164 Hz) long enough to properly debounce the button.
The bitsream was created in Vivado.
The 4 Switch PMOD was plugged into the top port of PMOD port JE
The 8 LED PMOD was plugged into PMOD port JD

To Operate:
Each switch represents 1 bit of the 8 bit instruction, a switch flipped up means a 1, and a switch flipped down means a 0
The output of the circuit will be represented by the LED PMOD, with the least significant bit on the right (LD0, and the most significant on the left (LD7)
When an instruction is ready to be executed, press BTN0. LED0 on the main board will light up. Once done, release BTN0
To print, flip the two left most switches on the PMOD to mirror the print instruction and the next two switches represent the register.
ISA Format is found in the Report
