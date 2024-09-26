// In this design if input = 4'b0000, then output = 2'b00 -> it is a failure of 
// data flow modelling approach

module priority_encoder_4to2 
 ( 
  input [3:0] in,
  output reg [1:0] out,
  output valid
 );
  
  assign valid = |in; // if in = 0000, valid = 0
  
  assign out[0] = in[3] | ~in[2]&in[1];
  assign out[1] = in[2] | in[3];
  
endmodule

module priority_encoder_4to2_tb();
 
  reg [3:0] in;
  wire [1:0] out;
  wire valid;

  priority_encoder_4to2 dut (.in(in), .out(out), .valid(valid));
  
  initial begin
    #10; // check for the initilization of data
    
    $display ("\nCheck for the correctness of design");
    in = 4'b0001; #5;
    for(int i = 0; i < 3; i++) begin // when in = 0, out should not be 0
      in = in << 1; #5;
    end
    
    $display ("\n Check for deficiency in the data flow modelling method");
    for (int i = 0; i < 15; i++) begin
        in = i; #5;
    end
   
    in = 4'bxxxx; #5; // somehow 4'bxxxx is equal to casex (4'b0001)
    in = 4'bxxx1; #5; // somehow 4'bxxx1 is equal to casex (4'b0001)
    in = 4'bxxx0; #5; // somehow 4'bxxx1 is equal to casex (4'b001x)
    in = 4'bxx00; #5; // somehow 4'bxxx1 is equal to casex (4'b01xx)
    in = 4'bx000; #5; // somehow 4'bxxx1 is equal to casex (4'b1xxx)
   
  end
  
  initial begin
    $monitor ("[%0tns] in = %0b, out = %0b (DEC = %0d), valid = %0b",$time,in,out,out,valid);
    $dumpfile ("dump.vcd");
    $dumpvars (1);
  end
  
endmodule