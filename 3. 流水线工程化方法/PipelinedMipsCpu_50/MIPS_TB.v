module MIPS_TB;
  
  reg clk, rst;
  
  MIPS MIPS(clk, rst);
  
  initial
  begin
    clk = 1'b0;
    rst = 1;
    #5 rst = 0;
  end
  
  always
  begin
    #2 clk = !clk;
  end
  
endmodule