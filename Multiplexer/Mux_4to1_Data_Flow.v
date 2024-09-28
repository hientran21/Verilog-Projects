/*module mux_4to1 (
  input [3:0] in,
  input [1:0] s,
  input enable,
  output out
  );
  
  assign out = enable ? (s[1]?(s[0]?in[3]:in[2]):(s[0]?in[1]:in[0])) : 1'bx;
  
endmodule */

module mux_4to1_tb();
  
  reg [3:0] in;
  reg [1:0] s;
  reg enable;
  wire out;
  
  mux_4to1 dut (.in(in), .s(s), .enable(enable), .out(out));
  
  initial begin
    $monitor ("[%0tns] enable = %b, s = %b, in = %b, out = %b",$time, enable, s, in, out);
    $display ("Check for data initialization");    
    #10;
    
    $display ("\nCheck for random");  
    repeat (5) begin
      enable = $random; in = $random ; s = $random; #1;
    end
    
    $display ("\nCheck for correctness of design");  
    enable = 1'b1;
    in = 4'b0001; s = 2'b00; #5;  
    in = 4'b0010; s = 2'b01; #5;  
    in = 4'b0100; s = 2'b10; #5;  
    in = 4'b1000; s = 2'b11; #5; 
    
    in = 4'b1110; s = 2'b00; #5;  
    in = 4'b1101; s = 2'b01; #5;  
    in = 4'b1011; s = 2'b10; #5;  
    in = 4'b0111; s = 2'b11; #5; 
    
  end
  
endmodule