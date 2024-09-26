// In this design if input = 4'b0000, then output = 2'b00 -> it is a failure of 
// data flow modelling approach

module encoder_4to2 
 ( 
  input [3:0] in,
  output [1:0] out
 );
  
  assign out[0] = in[1] | in[3];
  assign out[1] = in[2] | in[3];
  
endmodule

// in = 0001 -> out = 00
// in = 0010 -> out = 01
// in = 0100 -> out = 10
// in = 1000 -> out = 11

module encoder_4to2_tb();
 
  reg [3:0] in;
  wire [1:0] out;

  encoder_4to2 dut (.in(in), .out(out));
  
  initial begin
    #10; // check for the initilization of data
    
    $display ("\nCheck for the correctness of design");
    in = 4'b0001; #5;
    for(int i = 0; i < 3; i++) begin
      in = in << 1; #5;
    end
    
    $display ("\n Check for deficiency in the data flow modelling method");
    for (int i = 0; i < 15; i++) begin
        in = i; #5;
    end
  in = 4'bxxxx;
  end
  
  initial begin
    $monitor ("[%0tns] in = %0b, out = %0b (DEC = %0d)",$time,in,out,out);
    $dumpfile ("dump.vcd");
    $dumpvars (1);
  end
endmodule