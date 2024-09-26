module decoder_2to4(
  input enable,
  input [1:0] in,
  output [3:0] out
  );
  
  assign out[0] = enable & ~in[0] & ~in[1];
  assign out[1] = enable & in[0] & ~in[1];
  assign out[2] = enable & ~in[0] & in[1];
  assign out[3] = enable & in[0] & in[1];
  
endmodule

module decoder_2to4_tb();
  
  reg enable;
  reg [1:0] in;
  wire [3:0] out;
  
  decoder_2to4 dut (.enable(enable), .in(in), .out(out));
  
  initial begin
    repeat (32) begin
      in = $random; enable = $random; #1;
    end
  end
  
  initial begin
    $monitor ("[%0tns] enable = %0b, in = %0b, out = %0b",$time,enable,in,out);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule