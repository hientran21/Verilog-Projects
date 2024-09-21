// n_bit subtractor using Full Adder (2's complement)

module full_adder (
  input a,b,cin,
  output sum,cout);
  
  // data flow modeling
  assign sum = a ^ b ^ cin;  
  assign cout = (a&b) | (a&cin) | (b&cin);  
 
endmodule

module n_bit_subtractor_using_Full_Adder #(parameter WIDTH) 
  (
  input  signed [WIDTH-1:0] a,
  input  signed [WIDTH-1:0] b,
  output signed [WIDTH-1:0] answer,
  output overflow
  );
  
  wire [WIDTH-1:0]   b_not;
  wire [WIDTH:0]     w_CARRY;
  wire [WIDTH-1:0]   w_SUM;
  
  assign b_not = ~b;                         // Inverting b
  assign w_CARRY[0] = 1'b1;                  // Input carry = 1 for 2's complement
  assign answer = w_SUM;               
  assign overflow = w_CARRY[WIDTH] ^ w_CARRY[WIDTH-1]; // checking for overflow
  
  genvar i;
  generate 
    for (i=0; i < WIDTH; i=i+1)  begin
        full_adder full_adder_inst
            ( .a(a[i]), .b(b_not[i]), .cin(w_CARRY[i]), .sum(w_SUM[i]), .cout(w_CARRY[i+1]));
    end
  endgenerate
  
endmodule

module n_bit_subtractor_using_Full_Adder_tb ();
 
  parameter WIDTH = 4; 
 
  reg signed [WIDTH-1:0] a = 0; 
  reg signed [WIDTH-1:0] b = 0;
  wire signed [WIDTH-1:0]   answer; // the final answer
  wire overflow;
   
  n_bit_subtractor_using_Full_Adder #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .answer(answer), .overflow(overflow));
 
  initial begin // test case
    repeat (10) begin
      a = $random; b = $random; #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] a = %0d, b = %0d, answer = %0d, overflow = %0d",$time,a,b,answer,overflow);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end

endmodule 