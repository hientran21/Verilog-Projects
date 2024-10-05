module pipo_register 
  (
   input clk, reset,
   input [3:0] parallel_in,
   output reg [3:0] parallel_out
  );
  
  always @(posedge clk or posedge reset) begin
    if (reset) 
      parallel_out <= 4'b0000;
    else 
      parallel_out <= parallel_in;
  end
   
endmodule

module siso_register_tb();
  
  reg clk, reset;
  reg [3:0] in;
  wire [3:0] out;
  
  pipo_register dut (.clk(clk), .reset(reset), .parallel_in(in), .parallel_out(out));
  
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end
  
 initial begin    
   
   // TEST CASE for RESET
   #5;
   in = 0;
   reset = 1; #10;
   reset = 0; #10; //BY USING THIS DONT CARE CAN BE AVOIDED
   
   // TEST CASE for data in = 4'b1011
   in = 4'b0001; #10; // LSB
   in = 4'b1001; #10;
   in = 4'b0101; #10;
   in = 4'b0110; #10; // MSB
   
   #50 $finish;
 end
  
 initial begin
   $dumpfile("pipo.vcd");
   $dumpvars(1);
   $monitor("[%0tns] | clk = %0b | reset = %0b | in = %b | out = %b", $time, clk, reset, in, out);
 end

endmodule