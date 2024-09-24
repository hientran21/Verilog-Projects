module comparator_bit_slice
 (
  input a, b, lt_i, eq_i, gt_i,
  output lt_o, eq_o, gt_o
 );

  assign gt_o = ( a & ~b ) | (~(a ^ b) & gt_i);
  assign eq_o = eq_i & (( a & b ) | (~a & ~b));
  assign lt_o = ( b & ~a ) | (~(a ^ b) & lt_i);

endmodule

module n_bit_comparator_using_bit_slice #(parameter WIDTH)
 (
 input [WIDTH-1:0] a, b,
 output lt, eq, gt
 );

  wire [WIDTH:0] gt_w;
  wire [WIDTH:0] eq_w;
  wire [WIDTH:0] lt_w;
  
  assign gt_w[0] = 1'b0;
  assign eq_w[0] = 1'b1;
  assign lt_w[0] = 1'b0;
  
  genvar i;
  generate
    for (i = 0; i < WIDTH; i ++) begin 
      comparator_bit_slice cmp (.a(a[i]), .b(b[i]), .lt_i(lt_w[i]), .eq_i(eq_w[i]), .gt_i(gt_w[i]), .lt_o(lt_w[i+1]), .eq_o(eq_w[i+1]), .gt_o(gt_w[i+1]));
    end     
  endgenerate
      
  assign lt = lt_w[WIDTH];
  assign eq = eq_w[WIDTH];
  assign gt = gt_w[WIDTH];

endmodule

module n_bit_comparator_using_bit_slice_tb();
  
  parameter WIDTH = 4;
  reg [WIDTH-1:0] a,b;
  wire eq,gt,lt;
  
  n_bit_comparator_using_bit_slice #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .eq(eq), .gt(gt), .lt(lt));
  
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