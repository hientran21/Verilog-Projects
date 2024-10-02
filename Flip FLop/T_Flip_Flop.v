module T_flipflop (
  input clk, rst_n,  // reset and async input
  input t,           // sync input
  output reg q, 
  output q_bar
  );
  
  // always@(posedge clk) // for synchronous reset
  //   if (!rst_n)
  
  always@(posedge clk or negedge rst_n) begin // for asynchronous reset
    if(!rst_n) 
      q <= 0;
    else if (t == 1'b1) 
      q <= ~q;
    else 
      q <= q;
  end
  
  assign q_bar = ~q;
  
endmodule

module T_flipflop_tb;
  reg clk, rst_n;
  reg t;
  wire q, q_bar;
  
  T_flipflop dut (.clk(clk), .rst_n(rst_n), .t(t), .q(q), .q_bar(q_bar));
  
  always #10 clk = ~clk; // Create Clock pulse
  
  initial begin
    clk = 0; 
    #5;
    rst_n = 0;
    //$display("[%0tns] Reset=%b --> q=%b, q_bar=%b",$time, rst_n, q, q_bar);
    #2 rst_n = 1;
    //$display("[%0tns] Reset=%b --> q=%b, q_bar=%b",$time, rst_n, q, q_bar);
    #3;
    drive(0);
    drive(1);
    drive(1);
    drive(1);
    drive(1);
    drive(1);
    drive(0);
    #5;
    $finish;
  end
  
  task drive(reg  data);
    t = data; #20;
  endtask
  
  initial begin
    $monitor("[%0tns] reset = %b, t=%b --> q=%b, q_bar=%b",$time,rst_n,t,q,q_bar);
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
endmodule