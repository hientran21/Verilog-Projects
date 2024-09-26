module decoder_3to8(
  input enable,
  input [2:0] in,
  output reg [7:0] out
  );
  
  always @(enable or in) begin
    out = 8'b0000_0000;
    if (enable == 1) begin
      case (in) 
        3'b000: out[0] = 1'b1;
        3'b001: out[1] = 1'b1;
        3'b010: out[2] = 1'b1;
        3'b011: out[3] = 1'b1;
        3'b100: out[4] = 1'b1;
        3'b101: out[5] = 1'b1;
        3'b110: out[6] = 1'b1;
        3'b111: out[7] = 1'b1;
        default: out = 8'bxxxx_xxxx; // we could assign  
      endcase
    end
    else
      out = 8'b0000_0000;
  end
  
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