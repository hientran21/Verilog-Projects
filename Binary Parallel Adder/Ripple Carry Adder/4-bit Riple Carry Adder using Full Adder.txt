module full_adder (
  input a,b,cin,            
  output sum,cout   
  );
  
  assign sum = a ^ b ^ cin;   
  assign cout = (a&b) | (a&cin) | (b&cin); 

endmodule


module ripple_carry_adder (
  input [3:0] a,b,  
  input cin,     
  output [3:0] sum, 
  output cout
  );

  wire c1, c2, c3;  

  // Create a 4-bit adder by instantiating 4 full adders 
  full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
  full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]), .cout(c2));
  full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2), .sum(sum[2]), .cout(c3));
  full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3), .sum(sum[3]), .cout(cout));
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