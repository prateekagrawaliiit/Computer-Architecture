`include "adder32alt.v"

module top;
reg signed [31:0]ai,bi;
reg[7:0] xin;
wire signed [31:0]si;
wire[7:0]xout;
reg clk,rst;
adder adder_0(si,xout,ai,bi,xin,clk,rst);
integer i;
initial
begin
#0 xin="k"; ai=36865; bi=33023;
#3 xin="k"; ai=9943121; bi=-3302367;
#4 xin="k"; ai=-3686; bi=3023;
#4 xin="k"; ai=2; bi=2;
#4 xin="k"; ai=4; bi=4;

end

initial
begin
clk=1;
rst=0;
rst=1;
for (i=0;i<30;i++)
#1 clk=~clk;
end

initial
 begin
 	$monitor($time," Input bits:Number-1=%0d and Number-2=%0d;\n\tOutput: Sum=%0d",ai,bi,si);
 	$dumpfile("adder32alt.vcd");
 	$dumpvars;  
end
endmodule

