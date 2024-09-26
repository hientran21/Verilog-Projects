module priority_encoder_8to3
 ( 
  input [7:0] in,
  output reg [2:0] out,
  output valid
 );
  
  assign valid = |in; // if in = 8'b0000_0000 => valid = 0
  
  always @(*) begin
    if (in[7]) 
      out = 3'b111;
    else if (in[6])
      out = 3'b110;
    else if (in[5])
      out = 3'b101;
    else if (in[4])
      out = 3'b100;
    else if (in[3])
      out = 3'b011;
    else if (in[2])
      out = 3'b010;
    else if (in[1])
      out = 3'b001;
    else if (in[0])
      out = 3'b000;
    else 
      out = 3'bxxx; // or we could assign out = 3'bzzz instead
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
    in = 8'bxxxx; #5; 
    in = 8'bxxx1; #5; // somehow 8'bxxx1 is equal to if(in[0])
    in = 8'bxx1x; #5; // somehow 8'bxx1x is equal to if(in[1])
    in = 8'bx1xx; #5; // somehow 8'bx1xx is equal to if(in[2])
    in = 8'b1xxx; #5; // somehow 8'b1xxx is equal to if(in[3])
  end
  
  initial begin
    $monitor ("[%0tns] in = %0b, out = %0b (DEC = %0d), valid = %0b",$time,in,out,out,valid);
    $dumpfile ("dump.vcd");
    $dumpvars (1);
  end
endmodule