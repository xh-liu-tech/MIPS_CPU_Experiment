module test_tb;
  
  reg clk, reset;
  
  mips mips(clk, reset);
  
  initial
  begin
    clk = 1'b0;
    reset = 1;
    #5 reset = 0;
  end
  
  always
  begin
    #4 clk = ~clk;
  end
  
endmodule