module RegFile(
  input           clk, reset, WE3,
  input   [4:0]   A1, A2, A3,
  input   [31:0]  WD3,
  output  [31:0]  SrcAD, SrcBD
  );
  
  reg [31:0] Regs[31:0];
  
  integer i;
  
  initial
    for (i = 0; i < 32; i = i + 1)
      Regs[i] <= 0;
  
  always @(reset)
    for (i = 0; i < 32; i = i + 1)
      Regs[i] <= 0;
  
  always @(posedge clk)
    if ((WE3 == 1'b1) && (A3 != 5'b00000))
      Regs[A3] <= WD3;
  
  assign SrcAD = ((WE3 == 1'b1) && (A3 == A1) && (A3 != 5'b00000)) ? WD3 : Regs[A1];
  assign SrcBD = ((WE3 == 1'b1) && (A3 == A2) && (A3 != 5'b00000)) ? WD3 : Regs[A2];
  
endmodule