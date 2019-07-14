module Comp(
  input [31:0] A, B,
  input [2:0]  CompOpD,
  output       CompD
  );
  
  assign CompD = (CompOpD == 3'b000 && A == B)          ? 1 :
                 (CompOpD == 3'b001 && A != B)          ? 1 :
                 (CompOpD == 3'b010 && $signed(A) >= 0) ? 1 :
                 (CompOpD == 3'b011 && $signed(A) > 0)  ? 1 :
                 (CompOpD == 3'b100 && $signed(A) <= 0) ? 1 :
                 (CompOpD == 3'b101 && $signed(A) < 0)  ? 1 : 0;
  
endmodule