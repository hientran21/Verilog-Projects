module decoder_2to4(
  input enable,
  input [1:0] in,
  output reg [3:0] out
  );
  
  always @(in or enable) begin
    if (enable == 1) begin
      case (in) 
        2'b00: out = 4'b0001;
        2'b01: out = 4'b0010;
        2'b10: out = 4'b0100;
        2'b11: out = 4'b1000;
		default: out = 4'bxxxx; // we could assign 4'bzzzz instead
      endcase
    end  
    else
      out = 4'b0000;
  end
  
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