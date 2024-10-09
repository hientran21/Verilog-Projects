module synchronous_counter #(parameter SIZE=4)(
  input clk, rst_n,
  input up,
  output reg [3:0] cnt
);

  always@(posedge clk) begin
    if(!rst_n) begin
      cnt <= 4'h0;
    end
    else begin
      if(up) cnt <= cnt + 1'b1;
      else cnt <= cnt - 1'b1;
    end
  end
endmodule

module tb;
  parameter SIZE = 4;
  reg clk, rst_n;
  reg up;
  wire [3:0] cnt;
  synchronous_counter #(.SIZE(SIZE)) dut (clk, rst_n, up, cnt);
  
  initial begin
    clk = 0; rst_n = 0; 
    up = 1;
    #4; rst_n = 1;
    #80;
    rst_n = 0;
    #4; rst_n = 1; up = 0;
    #50;
    $finish;
  end
  always #2 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd"); 
	$dumpvars(1);
  end
endmodule