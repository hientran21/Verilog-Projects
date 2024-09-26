module decimal_to_bcd_encoder(
  input [9:0] in,
  output reg [3:0] out
  );
  
  assign out[3] = in[8] | in[9];
  assign out[2] = in[4] | in[5] | in[6] | in[7];
  assign out[1] = in[2] | in[3] | in[6] | in[7];
  assign out[0] = in[1] | in[3] | in[5] | in[7] | in[9];
  
endmodule

module decimal_to_bcd_encoder_tb ();
  
  reg [9:0] in;
  wire [3:0] out;
  
  decimal_to_bcd_encoder dut (.in(in), .out(out));
  
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