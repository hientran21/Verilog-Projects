// data flow modeling latch

module sr_latch(
    input S, R,
    output reg Q, Q_not);

  always @(*) begin
    if (S == 1'b1 && R ==1'b0) begin
      Q = 1'b1;
      Q_not = 1'b0;
    end else if (S == 1'b0 && R ==1'b1) begin
      Q = 1'b0;
      Q_not = 1'b1;
    end else if (S == 1'b1 && R ==1'b1) begin
      Q = 1'bz;
      Q_not = 1'bz;
    end
  end
endmodule

module sr_latch_tb;

  reg s, r;     
  wire q, q_not; 
  sr_latch latch(.S(s), .R(r), .Q(q), .Q_not(q_not));

  initial begin
      // for waveform analysis
      $dumpfile("sr_latch.vcd");
      $dumpvars(s, r, q, q_not);
    
      // Display initial value of Latch
      $display("s=%b, r=%b ==> q=%b, q_not=%b",
                s, r, q, q_not);

      // case 1 (latch w/o state)
      s=0; r=0; #1
      $display("s=%b, r=%b ==> q=%b, q_not=%b # should be undefined",
                s, r, q, q_not);

      // case 2 (reset)
      s=0; r=1; #1
      $display("s=%b, r=%b ==> q=%b, q_not=%b # reset, so q=0",
                s, r, q, q_not);

      // case 3 (set)
      s=1; r=0; #1
      $display("s=%b, r=%b ==> q=%b, q_not=%b # set, so q=1",
                s, r, q, q_not);

      // case 4 (latch with state)
      s=0; r=0; #1
      $display("s=%b, r=%b ==> q=%b, q_not=%b # latch, so q=q (keep state)",
                s, r, q, q_not);

      // case 5 (invalid state)
      s=1; r=1; #1
      $display("s=%b, r=%b ==> q=%b, q_not=%b # invalid state, so discount error",
                s, r, q, q_not);
  end

endmodule