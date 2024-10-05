module SIPO_register (
  input in,reset,clk,
  output reg [3:0] q
  );
  
  always @(posedge clk or negedge reset) begin //Async Reset
    if (!reset) begin  // active-LOW reset
      q <= 4'b0000;
    end
    else begin
      q <= {in,q[3:1]};
    end
  end
  
endmodule

module siso_register_tb();
  
  reg clk, reset, in;
  wire [3:0] q;
  
  SIPO_register dut (.clk(clk), .reset(reset), .in(in), .q(q));
  
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end
  
 initial begin    
   
   // TEST CASE for RESET
   #5;
   in = 0;
   reset = 0; #10;
   reset = 1; #10; //BY USING THIS DONT CARE CAN BE AVOIDED
   
   // TEST CASE for data in = 4'b1011
   in = 1; #10; // LSB
   in = 1; #10;
   in = 0; #10;
   in = 1; #10; // MSB
   
   #50 $finish;
 end
  
 initial begin
   $dumpfile("sipo.vcd");
   $dumpvars(1);
   $monitor("[%0tns] | clk = %0b | reset = %0b | in = %0b | q = %b", $time, clk, reset, in, q);
 end

endmodule