module universal_shift_reg
  (
  input clk, rst_n, 
  input [1:0] select, // select operation
  input [3:0] p_din,  // parallel data in 
  input s_left_din,   // serial left data in
  input s_right_din,  // serial right data in
  output reg [3:0] p_dout, //parallel data out
  output s_left_dout, // serial left data out
  output s_right_dout // serial right data out
  );
  
  // select: 2'b00 No Change, 2'b01 Shift Rigth
  //         2'b10 Shift Left , 2'b11 Parallel Load
  
  always@(posedge clk or negedge rst_n) begin
    if (!rst_n) 
      p_dout <= 0;
    else begin
      case(select)
        2'h1: p_dout <= {s_right_din,p_dout[3:1]}; // Right Shift
        2'h2: p_dout <= {p_dout[2:0],s_left_din};  // Left Shift
        2'h3: p_dout <= p_din;                     // Parallel in - Parallel out
        default: p_dout <= p_dout;                 // Do nothing
      endcase
    end
  end
  
  assign s_left_dout = p_dout[3];
  assign s_right_dout = p_dout[0];
  
endmodule

module universal_shift_reg_tb();
  reg clk, rst_n;
  reg [1:0] select;
  reg [3:0] p_din;
  reg s_left_din, s_right_din;
  wire [3:0] p_dout; //parallel data out
  wire s_left_dout, s_right_dout;
  
  universal_shift_reg dut (.clk(clk), .rst_n(rst_n), .select(select), .p_din(p_din), .s_left_din(s_left_din), .s_right_din(s_right_din), .p_dout(p_dout), .s_left_dout(s_left_dout), .s_right_dout(s_right_dout));
  
  initial begin
    clk = 1;
    forever #5 clk = ~clk;
  end
  
  initial begin
    
    #10;
    rst_n = 0; #5;
    rst_n = 1;
    
    p_din = 4'b1101;
    s_left_din = 1'b1;
    s_right_din = 1'b0;
    
    select = 2'h3; #30;
    select = 2'h1; #30;
    p_din = 4'b1101;
    select = 2'h3; #30;
    select = 2'h2; #30;
    select = 2'h0; #30;
    
    $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    $monitor("[%0tns] clk = %b, reset = %b, select=%b, p_din=%b, s_left_din=%b, s_right_din=%b --> p_dout = %b, s_left_dout = %b, s_right_dout = %b",$time, clk, rst_n, select, p_din, s_left_din, s_right_din, p_dout, s_left_dout, s_right_dout);
  end
   
endmodule