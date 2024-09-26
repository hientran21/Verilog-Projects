module priority_encoder_8to3
 ( 
  input [7:0] in,
  output [2:0] out,
  output valid
 );
  
  assign valid = |in; // if in = 8'b0000_0000 => valid = 0
  assign out[0] = in[7] | ~in[6]&(in[5] | ~in[4]&in[3] | ~in[4]&~in[3]&~in[2]&in[1]);
  assign out[1] = in[7] | in[6] | ~in[5]&~in[4]&(in[3] | in[2]);
  assign out[2] = in[7] | in[6] | in[5] | in[4];

endmodule

module encoder_8to3_tb();
 
  reg [7:0] in;
  wire [2:0] out;
  wire valid;

  priority_encoder_8to3 dut (.in(in), .out(out), .valid(valid));
  
  initial begin
    $display ("Check for the initilization of data");
    #10; // check for the initilization of data
    
    $display ("\nCheck for the correctness of design");
    in = 8'b0000_0001; #5;
    for(int i = 0; i < 7; i++) begin
      in = in << 1; #5;
    end
    
    $display ("\n Check for deficiency in the data flow modelling method");
    for (int i = 0; i < 32; i++) begin // if input = 0 cause output = 0 => fail
        in = i; #5;
    end
    
    // test case for input that include 'x'
    $display ("\nTest case for input that include 'x'");
    in = 8'bxxxx; #5; // somehow 4'bxxxx is equal to casex (8'b0001)
    in = 8'bxxx1; #5; // somehow 4'bxxx1 is equal to casex (8'b0001)
    in = 8'bxxx0; #5; // somehow 4'bxxx1 is equal to casex (8'b001x)
    in = 8'bxx00; #5; // somehow 4'bxxx1 is equal to casex (8'b01xx)
    in = 8'bx000; #5; // somehow 4'bxxx1 is equal to casex (8'b1xxx)
  end
  
  initial begin
    $monitor ("[%0tns] in = %0b, out = %0b (DEC = %0d), valid = %0b",$time,in,out,out,valid);
    $dumpfile ("dump.vcd");
    $dumpvars (1);
  end
endmodule