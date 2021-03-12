`include "kpg.v"
`include "ppc_str.v"
`include "dff.v"


module adder(si,xout,a,b,xin,clk,rst);

input [31:0] a,b;
input clk,rst;

// string occupies 8 bits
input[7:0] xin;

output [32:0][7:0]x;
integer i=0;

output [7:0]xout;
output [31:0][7:0] y ;
output reg[31:0] si;

input [31:0] c,d,e,f;

//passing my inputs to c and d.

dff m1(a,b,rst,clk,c,d); //pipeline-1

//a[0] and b[0] are stored in x[1]

//generate k,p and g values for the 32bits. The 0th bit remains unchanged and is equal to xin.

//kgp values for the first 8 bits.
kpgg kpg_0(x[8:1],c[7:0],d[7:0]);

//kgp values for the next 8 bits.
kpgg kpg_1(x[16:9],c[15:8],d[15:8]);

//kgp values for the next 8 bits.
kpgg kpg_2(x[24:17],c[23:16],d[23:16]);

//kgp values for the last 8 bits.
kpgg kpg_3(x[32:25],c[31:24],d[31:24]);

//initialize the input carry equal to the given input carry value.
assign x[0]=xin;


//generate the partial products when we multiply c and d. Each partial product is of size 65 bits. One bit extra has been used to handle the carry if any though only 64 would have been enough.
ppc ppc_0(y[31:0],x[31:0],rst,clk,c,d,e,f);


// generate the final sum using the final kpg values after RD technique.
always@(posedge clk)
begin
for(i=0;i<32;i=i+1)
begin
if(y[i]=="k")
si[i]=(e[i]^f[i])^0;
else
si[i]=(e[i]^f[i])^1;
end
end
endmodule
