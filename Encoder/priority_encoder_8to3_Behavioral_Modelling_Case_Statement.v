module priority_encoder_8to3
 ( 
  input [7:0] in,
  output reg [2:0] out,
  output valid
 );
  
  assign valid = |in; // if in = 8'b0000_0000 => valid = 0
  
  always @(*) begin
	casex (in) 
      8'b0000_0001: out = 3'b000;
      8'b0000_001x: out = 3'b001;
      8'b0000_01xx: out = 3'b010;
      8'b0000_1xxx: out = 3'b011;
      8'b0001_xxxx: out = 3'b100;
      8'b001x_xxxx: out = 3'b101;
      8'b01xx_xxxx: out = 3'b110;
      8'b1xxx_xxxx: out = 3'b111;
	  default: out = 3'bxxx; // or we could assign out = 2'bzz instead
    endcase
  end
  
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
    
    $display ("\nCheck for more detail");
    for (int i = 0; i < 32; i++) begin
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