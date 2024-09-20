module full_adder(
  input a, b, cin,
  output sum, cout
);
  
  assign {cout,sum} = a + b + cin;
endmodule

// using parameter and genvar statement to implement
// 4-bit ripple carry adder with input carry

module ripple_carry_adder #(parameter SIZE = 4) 
  (
  input [SIZE-1:0] A, B, 
  input Cin,
  output [SIZE-1:0] Sum, Cout
  );
  
  genvar g;
  
  full_adder fa0(A[0], B[0], Cin, Sum[0], Cout[0]);
  generate  // This will instantiate full_adder SIZE-1 times
    for(g = 1; g < SIZE; g++) begin
      full_adder fa(A[g], B[g], Cout[g-1], Sum[g], Cout[g]);
    end
  endgenerate
  
endmodule


// reference to https://vlsiverify.com/verilog/verilog-codes/ripple-carry-adder/

module ripple_carry_adder_tb ();
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] Sum, Cout;
  wire[4:0] answer;
  
  ripple_carry_adder rca(.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout));
  assign answer = {Cout[3], Sum};
  
  initial begin // test case
    repeat (10) begin
      A = $random; B = $random; Cin = $random;
      #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] A = %0d, B = %0d, Cin = %0d, Cout = %0d, Sum = %0d, answer = %0d",$time,A,B,Cin,Cout[3],Sum,answer);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule
