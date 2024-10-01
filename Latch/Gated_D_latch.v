// data flow modeling latch

module gated_d_latch(
    input Enable, Reset, D,
    output reg Q, Q_not);

  always @(*) begin
    if (!Reset) begin
      Q = 0;
      Q_not = 1;
    end
    else 
      if (Enable) begin
        Q = D;
        Q_not = ~D;
      end
  end

endmodule

module gated_d_latch_tb;

  reg enable, reset, d;     
  wire q, q_not; 
  gated_d_latch latch (.Enable(enable), .D(d), .Reset(reset), .Q(q), .Q_not(q_not));

  initial begin
      // for waveform analysis
    $dumpfile("sr_latch.vcd");
    $dumpvars(1);
      
    #10;
    
    repeat (16) begin
      enable = $random; reset = $random; d = $random; #1;
    end
  end
  
  initial $monitor("[%0tns] e = %b, reset = %b, d = %b, q = %b, q_not = %b",$time,enable,reset,d,q,q_not);

endmodule