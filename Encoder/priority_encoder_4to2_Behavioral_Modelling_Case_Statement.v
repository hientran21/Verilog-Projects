module priority_encoder_4to2 
 ( 
  input [3:0] in,
  output reg [1:0] out,
  output valid
 );
  
  assign valid = |in; // if in = 0000, valid = 0
  
  always @(*) begin
	casex (in) 
      4'b0001: out = 2'b00;
      4'b001x: out = 2'b01;
      4'b01xx: out = 2'b10;
      4'b1xxx: out = 2'b11;
	  default: out = 2'bxx; // or we could assign out = 2'bzz instead
    endcase
  end
  
endmodule

module priority_encoder_4to2_tb();
 
  reg [3:0] in;
  wire [1:0] out;
  wire valid;

  priority_encoder_4to2 dut (.in(in), .out(out), .valid(valid));
  
  initial begin
    #10; // at the beginning time, there are not signal drives the dut
    for (int i = 0; i < 15; i++) begin
        in = i; #5;
    end
    
    // test case for input that include 'x'
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