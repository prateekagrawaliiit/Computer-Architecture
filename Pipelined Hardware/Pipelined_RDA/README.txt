Main file:"adder32_alt.v "
FUNCTION DEPICTED BY THE FOLLOWING FILES:

2kpg.v            : Generates 1 string; either : "k","p" and "g" for the corresponding input bits 'a' and 'b' of width 1 bit
kpg.v             : Generates 8 strings : "k","p" and "g" for the corresponding input bits 'a' and 'b' of width  8 bits
ppc1.v            : Generates 32 strings : "k","p" and "g" for the corresponding input carry string "k" ,"p" and "g"  using recursive doubling algorithm
adder32_alt.v     : Generates 32 bit sum output for the given input bits 'a' and 'b' of bit width 32 bits
adder32_alt_tb.v  : Test Bench Program to simulate the working of 32bit RDA adder
dff_lvl.v & dff.v : Contains D-flipflops



NOTE:
"adder32_alt.v" requires "kpg.v" and "ppc1.v"
"kpg.v"requires 2kpg.v 

RDA _Clocked:
1)The test bench clk-input will change its value every 1 second => 1clock cycle is 2 seconds
2)Cla which has 5 stage in parallel prefix circuit and one stage for input into cla and one stage for output=> Total 7 stages 
3)The first input in test bench is given at 0sec and the output is visible at 14 and for every input change after 3-4 seconds the correct output will be 4 seconds after the previous correct output  
