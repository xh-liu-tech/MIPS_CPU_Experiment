module Ext(
  input   [15:0]  ImmD_16,
  input   [1:0]   ExtOpD,
  output  [31:0]  ImmD_32
  );
  
  assign ImmD_32 = (ExtOpD == 2'b10) ? {ImmD_16, 16'b0} :               // lui
                   (ExtOpD == 2'b00) ? {{16{ImmD_16[15]}}, ImmD_16} :   // Sign Extend
                   (ExtOpD == 2'b01) ? {16'b0, ImmD_16} :               // Zero Extend
                                       32'b0;
  
endmodule