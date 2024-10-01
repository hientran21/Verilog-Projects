module demux_2_1(
  input sel,
  input i,
  output y0, y1);
  
  assign {y0,y1} = sel?{1'b0,i}: {i,1'b0};
endmodule

module demux_1_4(
  input sel0, sel1,
  input  i,
  output reg y0, y1, y2, y3);
  
  wire z1,z2;
  
  demux_2_1 d1(sel0, i, z1, z2);
  demux_2_1 d2(sel1, z1, y0, y1);
  demux_2_1 d3(sel1, z2, y2, y3);
endmodule

module tb;
  reg sel0, sel1;
  reg i;
  wire y0,y1,y2,y3;
  
  demux_1_4 demux(sel0, sel1, i, y0, y1, y2, y3);
  
  initial begin
    $monitor("sel0 = %b, sel1 = %b, i = %b -> y0 = %0b, y1 = %0b ,y2 = %0b, y3 = %0b", sel0, sel1, i, y0,y1,y2,y3);
    sel0=0; sel1=0; i=0; #1;
    sel0=0; sel1=0; i=1; #1;
    sel0=0; sel1=1; i=0; #1;
    sel0=0; sel1=1; i=1; #1;
    sel0=1; sel1=0; i=0; #1;
    sel0=1; sel1=0; i=1; #1;
    sel0=1; sel1=1; i=0; #1;
    sel0=1; sel1=1; i=1; #1;
  end
endmodule