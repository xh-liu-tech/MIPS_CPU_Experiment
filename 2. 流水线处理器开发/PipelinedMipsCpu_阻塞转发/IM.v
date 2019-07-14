module IM_2k(
  input   [10:2]  A,
  output  [31:0]  RD
  );
  
  reg [31:0] RAM[511:0];
  
  initial $readmemh("code.txt", RAM);
  
  assign RD = RAM[A[10:2]];
  
endmodule