module siso_register (
  input clk,reset,in,
  output reg q3,q2,q1,q0
  );
  
  always @(posedge clk or negedge reset) begin
    if (reset) 
      {q3,q2,q1,q0} <= 4'b0000;
    else begin
      q3 <= in;
      q2 <= q3;
      q1 <= q2;
      q0 <= q1;
    end
  end
endmodule

module siso_register_tb();
  
  reg clk, reset, in;
  wire q3,q2,q1,q0;
  
  siso_register dut (.clk(clk), .reset(reset), .in(in), .q3(q3), .q2(q2), .q1(q1), .q0(q0));
  
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
   $monitor("[%0tns] | clk = %0b | reset = %0b | in = %0b | q3 = %0b | q2 = %0b | q1 = %0b | q0 = %0b", $time, clk, reset, in, q3, q2, q1, q0);
 end

endmodule