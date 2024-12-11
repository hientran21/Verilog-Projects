module ripple_carry_adder ( // 4 - bit adder but more simple
  input [3:0] a,b,
  input cin,
  output [3:0] sum,
  output cout);
  
  assign {cout,sum} = a + b + cin;
  
endmodule

module ripple_carry_adder_tb ();
  
  reg [3:0] a,b;
  reg cin;
  wire [3:0] sum;
  wire cout;
  
  wire [4:0] answer; // an intermediate net used to monitor the value of addition
  
  assign answer = {cout,sum}; 
  
  ripple_carry_adder dut (.a(a),.b(b),.sum(sum),.cin(cin),.cout(cout));
  
  initial begin // test case
    repeat (10) begin
      a = $random; b = $random; cin = $random;
      #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] a = %0d, b = %0d, cin = %0d, cout = %0d, sum = %0d, answer = %0d",$time,a,b,cin,cout,sum,answer);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule