module four_bit_comparator_using_always(
  input [3:0] a,b,
  output reg eq,gt,lt
);

  always @(*) begin
    lt = (a < b);
    eq = (a == b);
    gt = (a > b);
  end
  
endmodule

module four_bit_comparator_tb();
  
  reg [3:0] a,b;
  wire eq,gt,lt;
  
  four_bit_comparator_using_always dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));
  
  initial begin
    repeat (20) begin
      a = $random; b = $random; #1; 
      //if (eq) $display ("[%0tns] a==b:  a = %0d, b = %0d",$time,a,b);
      //if (gt) $display ("[%0tns] a>b :  a = %0d, b = %0d",$time,a,b);
      //if (lt) $display ("[%0tns] a<b :  a = %0d, b = %0d",$time,a,b);
    end
  end
  
  initial begin
    $monitor ("[%0tns] a = %0d, b = %0d, eq = %0d, gt = %0d, lt = %0d",$time,a,b,eq,gt,lt);
    $dumpfile ("dump.vcd");
    $dumpvars (1);
  end
  
endmodule