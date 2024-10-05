module siso_register (
  input clk,reset,in,
  output reg q_out
  );
  
  reg [3:0] q;
  
  always @(posedge clk or posedge reset) begin
    if (reset)   // active-HIGH reset
      q <= 4'b0000;
    else begin
      q <= q >> 1;
      q[3] <= in;
    end
  end
    
  always @(q) q_out = q[0]; 
  
endmodule

//SISO q[3] -> q[2] -> q[1] -> q[0]

module siso_register_tb();
  
  reg clk, reset, in;
  wire q_out;
  
  siso_register dut (.clk(clk), .reset(reset), .in(in), .q_out(q_out));
  
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end
  
 initial begin    
   
   // TEST CASE for RESET
   #5;
   in = 0;
   reset = 1; #10;
   in = 0;
   reset = 0; #10; //BY USING THIS DONT CARE CAN BE AVOIDED
   
   // TEST CASE for data in = 4'b1011
   in = 1; #10;
   in = 1; #10;
   in = 0; #10;
   in = 1; #10;
   
   #50 $finish;
 end
  
 initial begin
   $dumpfile("siso.vcd");
   $dumpvars(1);
   $monitor("[%0tns] | clk = %0b | reset = %0b | in = %0b | q_out = %0b", $time, clk, reset, in, q_out);
 end

endmodule