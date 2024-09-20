//`include "full_adder.v"

module full_adder (
  input a,b,cin,
  output sum,cout);
  
  // data flow modeling
  assign sum = a ^ b ^ cin;  
  assign cout = (a&b) | (a&cin) | (b&cin);  
 
endmodule

module carry_lookahead_adder
  #(parameter WIDTH)
  (
   input  [WIDTH-1:0] a,
   input  [WIDTH-1:0] b,
   output [WIDTH:0]   answer
   );
     
  wire [WIDTH:0]     w_C;       // carry out
  wire [WIDTH-1:0]   w_G, w_P, w_SUM;  // Carry Generate and Carry Propagate and Sum
 
  assign w_C[0] = 1'b0; // no carry input on first adder
  assign answer = {w_C[WIDTH], w_SUM};   // Verilog Concatenation 
 
  // Create the Full Adders
  genvar i;
  generate
    for (i=0; i < WIDTH; i++) 
      begin
        full_adder full_adder_inst (.a(a[i]), .b(b[i]), .cin(w_C[i]), .sum(w_SUM[i]), .cout()); // the carry output port is unconnected 
      end                                                                                       // because the carry out is calculated by
  endgenerate                                                                                   // formula not by instance
 
  // Create the Generate (G) Terms:  Gi=Ai*Bi
  // Create the Propagate Terms: Pi=Ai+Bi
  // Create the Carry Terms:
  genvar j;
  generate
    for (j=0; j < WIDTH; j++) 
      begin
        assign w_G[j]   = a[j] & b[j];
        assign w_P[j]   = a[j] | b[j];
        assign w_C[j+1] = w_G[j] | (w_P[j] & w_C[j]);
      end
  endgenerate
   
endmodule // carry_lookahead_adder