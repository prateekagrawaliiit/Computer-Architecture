module kpg(x,ai,bi);

// Inputs a and b each of 8 bits
input ai,bi;
output reg[7:0] x;

always @(ai or bi)

// Check if both the bits are same
if(ai==bi)
begin
    // if both the bits are 0 then generate kill
    if(ai==0)
    x="k";
    // if both the bits are 1 then generate generate
    else
    x="g";
end
else
// if both the bits are difference then generate propagate
x="p";

endmodule
