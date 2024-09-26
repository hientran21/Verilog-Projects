module encoder_8to3
 ( 
  input [7:0] in,
  output reg [2:0] out
 );
  
  always @(*) begin
	case (in) 
      8'b0000_0001: out = 3'b000;
      8'b0000_0010: out = 3'b001;
      8'b0000_0100: out = 3'b010;
      8'b0000_1000: out = 3'b011;
      8'b0001_0000: out = 3'b100;
      8'b0010_0000: out = 3'b101;
      8'b0100_0000: out = 3'b110;
      8'b1000_0000: out = 3'b111;
	  default: out = 3'bxxx; // or we could assign out = 3'bzzz instead
    endcase
  end
  
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
    
    $display ("\n Check for more detail");
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