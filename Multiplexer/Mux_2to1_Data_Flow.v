module mux_2to1 (
  input [1:0] in,
  input s,enable,
  output out
  );
  
  assign out = (enable)?((s)?in[1]:in[0]):1'bx;
  
endmodule

module mux_2to1_tb();
  
  reg [1:0] in;
  reg s,enable;
  wire out;
  
  mux_2to1 dut (.in(in), .s(s), .enable(enable), .out(out));
  
  initial begin
    $monitor ("enable = %b, s = %b, in[0] = %b, in[1] = %b, out = %b", enable, s, in[0], in[1], out);
    repeat (10) begin
      in = $random; s = $random; enable = $random; #1;
    end
  end
  
endmodule