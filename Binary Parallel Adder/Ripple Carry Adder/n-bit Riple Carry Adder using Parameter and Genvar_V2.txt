//`include "full_adder.v"
//`include "half_adder.v"

module n_bit_cripple_carry_adder #(parameter WIDTH) 
 (
 input  [WIDTH-1:0] a,b,
 output [WIDTH:0] answer
 );
  
  wire [WIDTH-1:0] sum;
  wire [WIDTH-1:0] carry;
  
  assign answer = {carry[WIDTH-1],sum};
  
  genvar i;
  
  generate 
    for (i=0; i < WIDTH; i=i+1) begin: generate_n_bit_Adder
      if(i==0) 
        half_adder f(a[0],b[0],sum[0],carry[0]);
      else
        full_adder f(a[i],b[i],carry[i-1],sum[i],carry[i]);
    end
  endgenerate
  
endmodule 

module half_adder (
  input a,b,
  output sum,carry);
  
  // use concatenation and add operator
  assign {carry,sum} = a+b;
endmodule

module full_adder (
  input a,b,cin,
  output sum,cout);
  
  // data flow modeling modeling with concatenation
  assign {cout,sum} = a + b + cin; 
 
endmodule

module  n_bit_cripple_carry_adder_tb ();
  
  parameter WIDTH = 4;
  
  reg  [WIDTH-1:0] a;
  reg  [WIDTH-1:0] b;
  wire [WIDTH:0] answer;

  n_bit_cripple_carry_adder #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .answer(answer));
  
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

// reference to https://www.fpga4student.com/2017/07/n-bit-adder-design-in-verilog.html