// // n_bit subtractor using Full Adder (2's complement arithmetic)

module full_adder (
  input a,b,cin,
  output sum,cout);
  
  assign {cout,sum} = a + b + cin;
endmodule

module n_bit_adder_subtractor #(parameter WIDTH) 
 (
  input signed [WIDTH-1:0] a,
  input signed [WIDTH-1:0] b,
  input  ctrl,
  output signed [WIDTH-1:0] answer,
  output overflow
 );
  
  wire [WIDTH:0]   w_CARRY;
  wire [WIDTH-1:0] w_SUM;
  wire [WIDTH-1:0] b_xor;
  
  assign w_CARRY[0] = ctrl;  // input carry into the first adder is equal to ctrl
  assign answer = w_SUM;               
  assign b_xor = b ^ {4{ctrl}};
  assign overflow = w_CARRY[WIDTH] ^ w_CARRY[WIDTH-1]; // checking for overflow
  
  genvar i;
  generate 
    for (i = 0; i < WIDTH; i++)  begin
      full_adder fa (.a(a[i]), .b(b_xor[i]), .cin(w_CARRY[i]), .sum(w_SUM[i]), .cout(w_CARRY[i+1]));
    end
  endgenerate
  
endmodule
    
module n_bit_adder_subtractor_tb ();
 
  parameter WIDTH = 4; 
  
  reg ctrl; // if ctrl = 1 -> subtractor, ctrl = 0 -> adder
  reg signed [WIDTH-1:0] a; 
  reg signed [WIDTH-1:0] b;
  wire signed [WIDTH-1:0] answer; // the final answer
  wire overflow;
   
n_bit_adder_subtractor #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .ctrl(ctrl), .answer(answer), .overflow(overflow));
 
  initial begin // test case
    repeat (10) begin
      a = $random; b = $random; ctrl = $random; #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] a = %0d, b = %0d, ctrl = %0d, answer = %0d, overflow = %0b",$time,a,b,ctrl,answer,overflow);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end

endmodule 	