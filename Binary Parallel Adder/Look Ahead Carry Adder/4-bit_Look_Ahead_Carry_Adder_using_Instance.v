module full_adder (
  input a,b,cin,
  output sum,cout);
  
  // data flow modeling modeling with concatenation
  assign sum = a ^ b ^ cin;  
  assign cout = (a&b) | (a&cin) | (b&cin);
 
endmodule

module look_ahead_carry_adder_4_bit // this module has an input carry = 0
 (
 input  [3:0]  a,
 input  [3:0]  b,
 output [4:0]  answer
 );
     
  wire [4:0]    w_C;
  wire [3:0]    w_G, w_P, w_SUM;
   
  full_adder fa0 (.a(a[0]), .b(b[0]), .cin(w_C[0]), .sum(w_SUM[0]), .cout()); // output port cout is unconnected 
  full_adder fa1 (.a(a[1]), .b(b[1]), .cin(w_C[1]), .sum(w_SUM[1]), .cout()); // because we will use another formula 
  full_adder fa2 (.a(a[2]), .b(b[2]), .cin(w_C[2]), .sum(w_SUM[2]), .cout()); // to calculate the cout instead using 
  full_adder fa3 (.a(a[3]), .b(b[3]), .cin(w_C[3]), .sum(w_SUM[3]), .cout()); // the instance
    
  // Create the Generate (G) Terms:  Gi=Ai*Bi
  assign w_G[0] = a[0] & b[0];
  assign w_G[1] = a[1] & b[1];
  assign w_G[2] = a[2] & b[2];
  assign w_G[3] = a[3] & b[3];
 
  // Create the Propagate Terms: Pi=Ai+Bi
  assign w_P[0] = a[0] | b[0];
  assign w_P[1] = a[1] | b[1];
  assign w_P[2] = a[2] | b[2];
  assign w_P[3] = a[3] | b[3];
 
  // Create the Carry Terms:
  assign w_C[0] = 1'b0; // No carry input
  assign w_C[1] = w_G[0] | (w_P[0] & w_C[0]);
  assign w_C[2] = w_G[1] | (w_P[1] & w_C[1]);
  assign w_C[3] = w_G[2] | (w_P[2] & w_C[2]);
  assign w_C[4] = w_G[3] | (w_P[3] & w_C[3]);
   
  assign answer = {w_C[4],w_SUM};   // Verilog Concatenation
 
endmodule // carry_lookahead_adder_4_bit

module look_ahead_carry_adder_4_bit_tb();
  reg  [3:0] a,b;
  wire [4:0] answer;
  
  look_ahead_carry_adder_4_bit dut (
    .a(a),
    .b(b),
    .answer(answer)
    );

  initial begin // test case
    repeat (10) begin
      a = $random; b = $random; 
      #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] a = %0d, b = %0d, answer = %0d",$time,a,b,answer);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule

// Reference to https://nandland.com/carry-lookahead-adder/