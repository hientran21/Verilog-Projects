`timescale 1ns / 1ps

module four_bit_carry_lookahead_adder(
  input [3:0] A, B,
  input Cin,
  output [3:0] S,
  output Cout
  );
  
  wire G[3:0], P[3:0]; // Carry Generate and Carry Propagate
  wire C[3:0];         // Carry Out of each adder 

  assign G[0] = A[0] & B[0]; // Cg = AB
  assign G[1] = A[1] & B[1];
  assign G[2] = A[2] & B[2];
  assign G[3] = A[3] & B[3];

  assign P[0] = A[0] | B[0]; // Cp = A + B
  assign P[1] = A[1] | B[1];
  assign P[2] = A[2] | B[2];
  assign P[3] = A[3] | B[3];
    
  assign C[0] = G[0] | (P[0] & Cin); // Cout = Cp + Cg&Cin
  assign C[1] = G[1] | (P[1] & C[0]);
  assign C[2] = G[2] | (P[2] & C[1]);
  assign C[3] = G[3] | (P[3] & C[2]);
  assign Cout = C[3];

  assign S[0] = A[0] ^ B[0] ^ Cin; // Sum = A^B^Cin
  assign S[1] = A[1] ^ B[1] ^ C[0];
  assign S[2] = A[2] ^ B[2] ^ C[1];
  assign S[3] = A[3] ^ B[3] ^ C[2];
  
endmodule

module four_bit_carry_lookahead_adder_tb();
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] S;
  wire Cout;
  
  wire [4:0] answer = {Cout,S};

  four_bit_carry_lookahead_adder dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

  initial begin // test case
    repeat (10) begin
      A = $random; B = $random; Cin = $random;
      #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] A = %0d, B = %0d, Cin = %0d, Cout = %0d, Sum = %0d, answer = %0d",$time,A,B,Cin,Cout,S,answer);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule