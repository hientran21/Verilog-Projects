module full_subtractor (
  input a,b,bin,
  output diff,bout); // diff is difference

  assign bout = (~a & b) | (~(a ^ b) & bin);
  assign diff = a ^ b ^ bin;
  
endmodule

module signed_four_bit_subtractor #(parameter SIZE = 4) 
 ( 
   input [SIZE-1:0] a,b, 
   input signed bin,                  // bin is signed number
   output signed [SIZE-1:0] diff,bout // diff,bout are signed numbers 
 );
  
  full_subtractor fs0 (.a(a[0]), .b(b[0]), .bin(bin), .bout(bout[0]), .diff(diff[0]));
  genvar i;
  generate 
    for (i = 1; i < SIZE; i++) begin
	  full_subtractor fs (.a(a[i]), .b(b[i]), .bin(bout[i-1]), .bout(bout[i]), .diff(diff[i]));
	end
  endgenerate
  
endmodule 

module n_bit_signed_subtractor_tb();
  
  parameter SIZE = 4;
  
  reg  [SIZE-1:0] a,b;
  reg  bin;
  wire [SIZE-1:0] diff,bout;
  wire signed [SIZE:0] answer; // answer is signed
  
  signed_four_bit_subtractor dut (.a(a), .b(b), .diff(diff), .bin(bin), .bout(bout));
  
  assign answer = {bout[SIZE-1],diff};
  
  initial begin // test case for full substractor, examine for a,b,bin with different values
    repeat (10) begin
      a = $random; b = $random; bin = $random; #1;
    end
  end
  
  initial begin // monitor values and dump waveform
    $monitor ("[%0tns] a = %0d, b = %0d, bin = %0d, bout = %0d, diff = %0d, answer = %0d",$time,a,b,dut.bin,dut.bout[SIZE-1],dut.diff,answer); // using dut. path name instead
    $dumpfile ("dump.vcd");
    $dumpvars(1);
  end
endmodule
