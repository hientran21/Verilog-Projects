module four_bit_comparator 
  (input [3:0] a,b,
   output eq,gt,lt
  );
  
  wire x0,x1,x2,x3;
  
  assign x0 = a[0] ~^ b[0];
  assign x1 = a[1] ~^ b[1];
  assign x2 = a[2] ~^ b[2];
  assign x3 = a[3] ~^ b[3];
  
  assign eq = x0 & x1 & x2 & x3;
  assign gt = a[3]&(~b[3]) | x3&a[2]&(~b[2]) | x3&x2&a[1]&(~b[1]) | x3&x2&x1&a[0]&(~b[0]);
  assign lt = (~a[3])&b[3] | x3&(~a[2])&b[2] | x3&x2&(~a[1])&b[1] | x3&x2&x1&(~a[0])&b[0];
  
endmodule

module four_bit_comparator_tb();
  
  reg [3:0] a,b;
  wire eq,gt,lt;
  
  four_bit_comparator dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));
  
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