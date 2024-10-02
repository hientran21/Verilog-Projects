module JK_flipflop (
  input clk, rst_n,  // reset and async input
  input j,k,         // sync input
  output reg q, 
  output q_bar
  );
  
  // always@(posedge clk) // for synchronous reset
  //   if (!rst_n)
  
  always@(posedge clk or negedge rst_n) begin // for asynchronous reset
    if(!rst_n) 
      q <= 0;
    else begin
      case({j,k})
        2'b00: q <= q;    // No change
        2'b01: q <= 1'b0; // reset
        2'b10: q <= 1'b1; // set
        2'b11: q <= ~q;   // Toggle
      endcase
    end
  end
  
  assign q_bar = ~q;
  
endmodule

module SR_flipflop_tb;
  reg clk, rst_n;
  reg j, k;
  wire q, q_bar;
  
  JK_flipflop dut (.clk(clk), .rst_n(rst_n), .j(j), .k(k), .q(q), .q_bar(q_bar));
  
  always #10 clk = ~clk; // Create Clock pulse
  
  initial begin
    clk = 0; 
    #5;
    rst_n = 0;
    //$display("[%0tns] Reset=%b --> q=%b, q_bar=%b",$time, rst_n, q, q_bar);
    #2 rst_n = 1;
    //$display("[%0tns] Reset=%b --> q=%b, q_bar=%b",$time, rst_n, q, q_bar);
    #3;
    drive(2'b11);
    drive(2'b00);
    drive(2'b01);
    drive(2'b11);
    drive(2'b10);
    drive(2'b11);
    drive(2'b00);
    #5;
    $finish;
  end
  
  task drive(reg [1:0] data);
    {j,k} = data; #20;
  endtask
  
  initial begin
    $monitor("[%0tns] reset = %b, s=%b, r=%b --> q=%b, q_bar=%b",$time,rst_n, j, k, q, q_bar);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule