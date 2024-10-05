module piso_register
 (
  input clk,reset,load,
  input [3:0] parallel_in,
  output reg serial_out
 );
  
  reg [3:0] q; // tempory storage
  
  always @(posedge clk or posedge reset) begin
    if(reset)     
      q <= 4'b0000;
    else if (load)
      q <= parallel_in;
    else
      q <= q >> 1;
  end
  
  always @(q) begin
      serial_out = q[0];
  end
  
endmodule

module piso_register_tb();
  
  reg clk, reset, load;
  reg [3:0] in;
  wire out;
  
  piso_register dut (.clk(clk), .reset(reset), .load(load), .parallel_in(in), .serial_out(out));
  
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end
  
 initial begin    
   
   // TEST CASE for RESET
   #5;
   in = 0; load = 0;
   reset = 1; #10;
   reset = 0;  
   
   // TEST CASE for data in = 4'b1011
   in = 4'b1011;
   load = 1; #10; 
   load = 0; #5;
   
   #50; 
   in = 4'b1100;
   load = 1; #10; 
   load = 0; #5;
   
   #100 $finish;
 end
  
 initial begin
   $dumpfile("piso.vcd");
   $dumpvars(1);
   $monitor("[%0tns] | clk = %0b | reset = %0b | load = %b | in = %b | q_internal = %b | out = %b", $time, clk, reset, load, in, dut.q, out);
 end

endmodule