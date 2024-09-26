module n_bit_priority_encoder #(parameter WIDTH = 4)
 ( 
  input [WIDTH-1:0] in,
  output reg [$clog2(WIDTH)-1:0] out,
  output valid
 );
  
  assign valid = |in; // if in = 8'b0000_0000 => valid = 0

  always @(in) begin
    for (int i = 0; i < WIDTH; i++) begin
      if (in[i]) out = i;
    end
  end

endmodule

module encoder_8to3_tb();
  
  parameter WIDTH = 4; 
  reg [WIDTH-1:0] in;
  wire [$clog2(WIDTH)-1:0] out;
  wire valid;

  n_bit_priority_encoder #(.WIDTH(WIDTH)) dut (.in(in), .out(out), .valid(valid));
  
  initial begin
    $display ("Check for the initilization of data");
    #10; // check for the initilization of data
    
    $display ("\nCheck for the correctness of design");
    in = 4'b0001; #5;
    for(int i = 0; i < WIDTH; i++) begin
      in = in << 1; #5;
    end
    
    $display ("\n Check for deficiency in the data flow modelling method");
    for (int i = 0; i < 10; i++) begin // if input = 0 cause output = 0 => fail
        in = i; #5;
    end
    
    // test case for input that include 'x'
    $display ("\nTest case for input that include 'x'");
    in = 4'bxxxx; #5; // somehow 4'bxxxx is equal to casex (8'b0001)
    in = 4'bxxx1; #5; // somehow 4'bxxx1 is equal to casex (8'b0001)
    in = 4'bxxx0; #5; // somehow 4'bxxx1 is equal to casex (8'b001x)
    in = 4'bxx00; #5; // somehow 4'bxxx1 is equal to casex (8'b01xx)
    in = 4'bx000; #5; // somehow 4'bxxx1 is equal to casex (8'b1xxx)
  end
  
  initial begin
    $monitor ("[%0tns] in = %0b, out = %0b (DEC = %0d), valid = %0b",$time,in,out,out,valid);
    $dumpfile ("dump.vcd");
    $dumpvars (1);
  end
endmodule