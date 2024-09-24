module four_bit_comparator_signed (
  input  logic [3:0] a,
  input  logic [3:0] b,
  output logic       gt,
  output logic       lt,
  output logic       eq
);

  assign gt = ($signed(a) > $signed(b)) ? 1'b1 : 1'b0;
  assign lt = ($signed(a) < $signed(b)) ? 1'b1 : 1'b0;
  assign eq = (a == b)                  ? 1'b1 : 1'b0;

endmodule

module four_bit_comparator_tb();
  
  reg signed [3:0] a,b;
  wire eq,gt,lt;
  
  four_bit_comparator_signed dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));
  
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