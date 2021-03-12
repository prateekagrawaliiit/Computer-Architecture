module dff_lvl (input [31:0][7:0]d,input rst,input clk,output reg [31:0][7:0] q,output reg[31:0] wire1,output reg[31:0] wire2,input [31:0]a,input [31:0]b);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q <= 0;
          wire1<=0;
          wire2<=0;  
       end
       else  
       begin
          q <= d;  
          wire1<=a;
          wire2<=b;
       end
endmodule  
