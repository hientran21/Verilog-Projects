module full_subtractor (
  input a,b,bin,
  output diff,bout); // diff is difference

  assign bout = (~a & b) | (~(a ^ b) & bin);
  assign diff = a ^ b ^ bin;
  
endmodule

module signed_four_bit_subtractor 
 ( 
   input [3:0] a,b, 
   input signed bin,         // bin is signed number
   output signed [3:0] diff, // diff is signed number
   output signed bout        // bout is signed number
 );
  
  wire b1,b2,b3; // internal borrow out of each full subtractor
  
  // Create a 4-bit subtractor by instantiating 4 full subtractor
  full_subtractor fs0 (.a(a[0]), .b(b[0]), .bin(bin), .bout(b1),   .diff(diff[0]));
  full_subtractor fs1 (.a(a[1]), .b(b[1]), .bin(b1),  .bout(b2),   .diff(diff[1]));
  full_subtractor fs2 (.a(a[2]), .b(b[2]), .bin(b2),  .bout(b3),   .diff(diff[2]));
  full_subtractor fs3 (.a(a[3]), .b(b[3]), .bin(b3),  .bout(bout), .diff(diff[3]));
  
endmodule 

module signed_four_bit_subtractor_tb();
  
  reg  [3:0] a,b;
  reg  bin;
  wire [3:0] diff;
  wire bout;
  wire signed [4:0] answer; // answer is signed
  
  signed_four_bit_subtractor dut (.a(a), .b(b), .diff(diff), .bin(bin), .bout(bout));
  
  assign answer = {bout,diff};
  
  initial begin // test case for full substractor, examine for a,b,bin with different values
    repeat (10) begin
      a = $random; b = $random; bin = $random; #1;
    end
  end
  
  initial begin // monitor values and dump waveform
    $monitor ("[%0tns] a = %0d, b = %0d, bin = %0d, bout = %0d, diff = %0d, answer = %0d",$time,a,b,dut.bin,dut.bout,dut.diff,answer); // using dut. path name instead
    $dumpfile ("dump.vcd");
    $dumpvars(1);
  end
endmodule