module four_bit_carry_lookahead_adder (
  input [3:0]a, b, 
  input cin,
  output [3:0] sum,
  output cout
);
  wire [3:0] c; // Carry intermediate for intermediate computation
  
  assign c[0] = cin;
  assign c[1] = (a[0] & b[0]) | ((a[0]^b[0]) & c[0]);
  //assign c[2] = (a[1] & b[1]) | ((a[1]^b[1]) & c[1]); expands to
  assign c[2] = (a[1] & b[1]) | ((a[1]^b[1]) & ((a[0] & b[0]) | ((a[0]^b[0]) & c[0])));
  //assign c[3] = (a[2] & b[2]) | ((a[2]^b[2]) & c[2]); expands to
  assign c[3] = (a[2] & b[2]) | ((a[2]^b[2]) & ((a[1] & b[1]) | ((a[1]^b[1]) & ((a[0] & b[0]) | ((a[0]^b[0]) & c[0])))));
  //assign Cout  = (a[3] & b[3]) | ((a[3]^b[3]) & c[3]); expands to
  assign cout  = (a[3] & b[3]) | ((a[3]^b[3]) & ((a[2] & b[2]) | ((a[2]^b[2]) & ((a[1] & b[1]) | ((a[1]^b[1]) & ((a[0] & b[0]) | ((a[0]^b[0]) & c[0])))))));

  assign sum = a ^ b ^ c;

endmodule

// reference to https://vlsiverify.com/verilog/verilog-codes/carry-look-ahead-adder/

module four_bit_carry_lookahead_adder_tb();
  reg [3:0] a, b;
  reg cin;
  wire [3:0] sum;
  wire cout;
  
  wire [4:0] answer = {cout,sum};

  four_bit_carry_lookahead_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
    );

  initial begin // test case
    repeat (10) begin
      a = $random; b = $random; cin = $random;
      #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] A = %0d, B = %0d, Cin = %0d, Cout = %0d, Sum = %0d, answer = %0d",$time,a,b,cin,cout,sum,answer);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule