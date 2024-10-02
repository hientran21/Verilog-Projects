// D_FF with Asynchronous Resset

module D_flipflop (
  input clk, rst_n,
  input d,
  output reg q
  );
  
  always@(posedge clk or negedge rst_n) begin
    if(!rst_n) q <= 0;
    else       q <= d;
  end
  
endmodule

module D_flipflop_tb;
  reg clk, rst_n;
  reg d;
  wire q;
  
  D_flipflop dut (.clk(clk), .rst_n(rst_n), .d(d), .q(q));
  
  always #2 clk = ~clk;
  
  initial begin
    clk = 0;
    #5;    
    rst_n = 0;
    d = 0;
    
    #3 rst_n = 1;
    
    repeat(6) begin
      d = $urandom_range(0,1);
      #3;
    end
    
    rst_n = 0; #3;
    rst_n = 1;
    
    repeat(6) begin
      d = $urandom_range(0, 1);
      #3;
    end
    
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule