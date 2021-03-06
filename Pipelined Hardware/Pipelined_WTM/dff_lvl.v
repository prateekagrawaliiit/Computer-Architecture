module dff_lvl_1 (input [31:0][64:0]d,input rst,input clk,output reg [31:0][64:0] q);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q <= 0;
       end
       else  
       begin
          q <= d;  

       end
endmodule  

module dff_lvl_2 (input [9:0][64:0]d1,input [9:0][64:0]d2,input rst,input clk,output reg [9:0][64:0] q1,output reg [9:0][64:0] q2);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
       end
endmodule  

module dff_lvl_3 (input [6:0][64:0]d1,input [6:0][64:0]d2,input rst,input clk,output reg [6:0][64:0] q1,output reg [6:0][64:0] q2);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
       end
endmodule  

module dff_lvl_4 (input [4:0][64:0]d1,input [4:0][64:0]d2,input rst,input clk,output reg [4:0][64:0] q1,output reg [4:0][64:0] q2);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
       end
endmodule  

module dff_lvl_5 (input [2:0][64:0]d1,input [2:0][64:0]d2,input rst,input clk,output reg [2:0][64:0] q1,output reg [2:0][64:0] q2);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
       end
endmodule  

module dff_lvl_6 (input [1:0][64:0]d1,input [1:0][64:0]d2,input rst,input clk,output reg [1:0][64:0] q1,output reg [1:0][64:0] q2);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
       end
endmodule  

module dff_lvl_7 (input [64:0]d1,input [64:0]d2,input rst,input clk,output reg [64:0] q1,output reg [64:0] q2);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
       end
endmodule  