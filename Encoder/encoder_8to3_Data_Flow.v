// In this design if input = 8'b0000_0000, then output = 3'b000 -> it is a failure of 
// data flow modelling approach

module encoder_8to3 
 ( 
  input [7:0] in,
  output [2:0] out
 );
  
  assign out[0] = in[1] | in[3] | in[5] | in[7];
  assign out[1] = in[2] | in[3] | in[6] | in[7];
  assign out[2] = in[4] | in[5] | in[6] | in[7];
  
endmodule

module encoder_8to3_tb();
 
  reg [7:0] in;
  wire [2:0] out;

  encoder_8to3 dut (.in(in), .out(out));
  
  initial begin
    #10; // check for the initilization of data
    
    $display ("\nCheck for the correctness of design");
    in = 8'b0000_0001; #5;
    for(int i = 0; i < 7; i++) begin
      in = in << 1; #5;
    end
    
    $display ("\n Check for deficiency in the data flow modelling method");
    for (int i = 0; i < 32; i++) begin
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