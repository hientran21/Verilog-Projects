// data flow modeling using Truth-Table to implement the formula
module two_bit_comparator 
  (input [1:0] a,b,
   output eq,gt,lt
  );
  
  assign eq = (a[0] ~^ b[0]) & (a[1] ~^ b[1]);
  assign gt = (a[1]&~b[1]) | ~b[0]&((a[0]&~b[1]) | (a[0]&a[1]));
  assign lt = b[1]&~a[1] | b[0]&b[1]&~a[0] | ~a[1]&~a[0]&b[0];
  
endmodule

module two_bit_comparator_tb();
  
  reg [1:0] a,b;
  wire eq,gt,lt;
  
  two_bit_comparator dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));
  
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