module demux_2to1(
  input sel,i,
  output y0, y1);
  
  assign {y0,y1} = sel?{1'b0,i}: {i,1'b0};
endmodule
  
module demux_2to1_tb;
  reg sel, i;
  wire y0, y1;
  
  demux_2to1 dut (sel, i, y0, y1);
  initial begin
    $monitor("sel = %h: i = %h --> y0 = %h, y1 = %h", sel, i, y0, y1);
    sel=0; i=0; #1;
    sel=0; i=1; #1;
    sel=1; i=0; #1;
    sel=1; i=1; #1;
  end
endmodule  