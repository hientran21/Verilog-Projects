module bcd_to_decimal_decoder (
  input enable,
  input [3:0] in,
  output reg [9:0] out
  );
  
  always @(enable or in) begin
    out = 10'b00_0000_0000;
    if (enable) begin
      case (in)
        4'b0000: out[0] = 1'b1;
        4'b0001: out[1] = 1'b1;
        4'b0010: out[2] = 1'b1;
        4'b0011: out[3] = 1'b1;
        4'b0100: out[4] = 1'b1;
        4'b0101: out[5] = 1'b1;
        4'b0110: out[6] = 1'b1;
        4'b0111: out[7] = 1'b1;
        4'b1000: out[8] = 1'b1;
        4'b1001: out[9] = 1'b1;
        default: out = 10'bx; // we could assign 10'bz
      endcase
    end
    else
      out = 10'b00_0000_0000;
  end
  
 
endmodule

module bcd_to_decimal_decoder_tb();
  
  reg enable;
  reg [3:0] in;
  wire [9:0] out;
  
  bcd_to_decimal_decoder dut (.enable(enable), .in(in), .out(out));
  
  initial begin
    repeat (128) begin
      in = $random; enable = $random; #1;
    end
  end
  
  initial begin
    $monitor ("[%0tns] enable = %0b, in = %0b, out = %0b",$time,enable,in,out);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule