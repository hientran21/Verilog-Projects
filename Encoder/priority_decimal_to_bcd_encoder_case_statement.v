module priority_decimal_to_bcd_encoder(
  input [9:0] in,
  output reg [3:0] out
  );
  
  always @(in) begin
    casex (in)
      10'b0000000001: out = 4'b0000;
      10'b000000001x: out = 4'b0001;
      10'b00000001xx: out = 4'b0010;
      10'b0000001xxx: out = 4'b0011;
      10'b000001xxxx: out = 4'b0100;
      10'b00001xxxxx: out = 4'b0101;
      10'b0001xxxxxx: out = 4'b0110;
      10'b001xxxxxxx: out = 4'b0111;
      10'b01xxxxxxxx: out = 4'b1000;
      10'b1xxxxxxxxx: out = 4'b1001;
      default: out = 4'bxxxx;  // we could assign 4'bzzzz instead
    endcase
  end
endmodule 

module decimal_to_bcd_encoder_tb ();
  
  reg [9:0] in;
  wire [3:0] out;
  
  priority_decimal_to_bcd_encoder dut (.in(in), .out(out));
  
  initial begin
    $display ("\nCheck for the initialization of data");
    #10;
    
    $display ("\nCheck for the correctness of design");
    in = 10'b00_0000_0001; #5;
    for (int i = 0; i < 9; i++) begin
      in = in << 1; #5;
    end
    
    $display ("\nCheck for deficiency in the data flow modelling method");
    for (int i  = 0; i < 32; i++) begin
      in = i; #5;
    end
    
    $display ("\nCheck for the input data has 'x'");
    #5; in = 4'bxxxx; 
    #5; in = 4'bxxx1;  
    #5; in = 4'bxxx0;  
    #5; in = 4'bxx00; 
    #5; in = 4'bx000; 
    
  end
  
  initial begin
    $monitor ("[%0tns] in = %0b, out = %0b (DEC = %0d)",$time,in,out,out);
  end
  
endmodule