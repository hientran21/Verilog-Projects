// data flow modeling
module one_bit_comparator 
  (input a,b,
   output eq,gt,lt
  );
  
  assign eq = a ~^ b;
  assign gt = a & (~b);
  assign lt = (~a) & b; 
  
endmodule

module one_bit_comparator_tb();
  
  reg a,b;
  wire eq,gt,lt;
  
  one_bit_comparator dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));
  
  initial begin
    repeat (10) begin
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