module full_subtractor (
  input a,b,bin,
  output diff,bout); // diff is difference

  assign bout = (~a & b) | (~(a ^ b) & bin);
  assign diff = a ^ b ^ bin;
  
endmodule

module n_bit_signed_subtractor #(parameter WIDTH)
  (  
   input [WIDTH-1:0] a,b,             
   output signed [WIDTH:0] answer // answer is signed number
  );
  
  wire [WIDTH-1:0] w_diff;       // internal diff
  wire [WIDTH:0]   w_borrow;     // internal borrow
  
  assign answer = {w_borrow[WIDTH],w_diff};  // concatenation for the final answer
  assign w_borrow[0] = 1'b0;                  // No borrow input on the first full subtractor 
   
  genvar i;
  generate
    for (i = 0; i < WIDTH; i++) begin
	  full_subtractor fs (.a(a[i]), .b(b[i]), .bin(w_borrow[i]), .bout(w_borrow[i+1]), .diff(w_diff[i]));
	end
  endgenerate
  
endmodule
  
 module n_bit_signed_four_bit_subtractor_tb();
  
  parameter WIDTH = 4; // parameter can be changed
  
  reg  [WIDTH-1:0] a,b;
  wire signed [WIDTH:0] answer; // answer is signed
  
  n_bit_signed_subtractor #(.WIDTH(WIDTH)) dut (.a(a), .b(b), .answer(answer));
    
  initial begin // test case for full substractor, examine for a,b,bin with different values
    repeat (10) begin
      a = $random; b = $random; #1;
    end
  end
  
  initial begin // monitor values and dump waveform
    $monitor ("[%0tns] a = %0d, b = %0d, answer = %0d",$time,a,b,answer); 
    $dumpfile ("dump.vcd");
    $dumpvars(1);
  end
endmodule 