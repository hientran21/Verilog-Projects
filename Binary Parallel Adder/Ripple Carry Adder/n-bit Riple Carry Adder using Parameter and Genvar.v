module full_adder (
  input a,b,cin,
  output sum,cout);
  
  assign {cout,sum} = a + b + cin;
endmodule

// using parameter and genvar to
// implement n-bit ripple carry adder with no input carry

module ripple_carry_adder 
 #(parameter WIDTH)
  (
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  output [WIDTH:0]   answer
  );
     
  wire [WIDTH:0]     w_CARRY;
  wire [WIDTH-1:0]   w_SUM;
   
  assign answer = {w_CARRY[WIDTH], w_SUM};   // Verilog Concatenation for the final answer
  
  assign w_CARRY[0] = 1'b0; // No carry input on the first full adder         
   
  genvar i;
  generate 
    for (i=0; i<WIDTH; i=i+1) 
      begin
        full_adder full_adder_inst
            ( .a(a[i]),
              .b(b[i]),
              .cin(w_CARRY[i]),
              .sum(w_SUM[i]),
              .cout(w_CARRY[i+1])
            );
      end
  endgenerate
   
endmodule // ripple_carry_adder

// reference to https://nandland.com/ripple-carry-adder/

module ripple_carry_adder_tb ();
 
  parameter WIDTH = 4; // the parameter can be changed to implement n-bit RCA
 
  reg  [WIDTH-1:0] a = 0; // this rca doesnt have input carry
  reg  [WIDTH-1:0] b = 0;
  wire [WIDTH:0]   answer; // the final answer
   
  ripple_carry_adder #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .answer(answer));
 
  initial begin // test case
    repeat (10) begin
      a = $random; b = $random;
      #1;
    end
  end
  
  initial begin // display result
    $monitor ("[%0tns] a = %0d, b = %0d, answer = %0d",$time,a,b,answer);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end

endmodule // ripple_carry_adder_tb
