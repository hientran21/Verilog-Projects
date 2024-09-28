module mux_2to1(
  input sel,
  input [1:0] in,
  output out
  );
  
  assign out = sel ? in[1] : in[0];
endmodule

module mux_4to1(
  input [1:0] sel,
  input [3:0] in,
  output out
  );
  
  wire y0, y1;
  
  mux_2to1 m1 (.in({in[1],in[0]}), .sel(sel[0]), .out(y0));
  mux_2to1 m2 (.in({in[3],in[2]}), .sel(sel[0]), .out(y1));
  mux_2to1 m3 (.in({y1,y0}), .sel(sel[1]), .out(out));
  
endmodule

module mux_4to1_tb();
  reg [1:0] sel;
  reg [3:0] in;
  wire out;
  
  mux_4to1 mux(.in(in), .sel(sel), .out(out));
  
  initial begin
    $monitor ("[%0tns] s = %b, in = %b, out = %b",$time, sel, in, out);
    $display ("Check for data initialization");    
    #10;
    
    $display ("\nCheck for random");  
    repeat (5) begin
      in = $random ; sel = $random; #1;
    end
    
    $display ("\nCheck for correctness of design");  
    in = 4'b0001; sel = 2'b00; #5;  
    in = 4'b0010; sel = 2'b01; #5;  
    in = 4'b0100; sel = 2'b10; #5;  
    in = 4'b1000; sel = 2'b11; #5; 
    
    in = 4'b1110; sel = 2'b00; #5;  
    in = 4'b1101; sel = 2'b01; #5;  
    in = 4'b1011; sel = 2'b10; #5;  
    in = 4'b0111; sel = 2'b11; #5; 
    end
  
endmodule