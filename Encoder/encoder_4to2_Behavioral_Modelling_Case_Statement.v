module encoder_4to2 
 ( 
  input [3:0] in,
  output reg [1:0] out
 );
  
  always @(*) begin
	case (in) 
      4'b0001: out = 2'b00;
      4'b0010: out = 2'b01;
      4'b0100: out = 2'b10;
      4'b1000: out = 2'b11;
	  default: out = 2'bxx; // or we could assign out = 2'bzz instead
    endcase
  end
  
endmodule

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
    
    $display ("\nA more detail check for the design");
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