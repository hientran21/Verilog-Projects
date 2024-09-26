module decoder_3to8(
  input enable,
  input [2:0] in,
  output [7:0] out
  );
  
  assign out[0] = enable & ~in[2] & ~in[1] & ~in[0];
  assign out[1] = enable & ~in[2] & ~in[1] & in[0];
  assign out[2] = enable & ~in[2] & in[1] & ~in[0];
  assign out[3] = enable & ~in[2] & in[1] & in[0];
  assign out[4] = enable & in[2] & ~in[1] & ~in[0];
  assign out[5] = enable & in[2] & ~in[1] & in[0];
  assign out[6] = enable & in[2] & in[1] & ~in[0];
  assign out[7] = enable & in[2] & in[1] & in[0];
  
endmodule

module decoder_3to8_tb();
  
  reg enable;
  reg [2:0] in;
  wire [7:0] out;
  
  decoder_3to8 dut (.enable(enable), .in(in), .out(out));
  
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