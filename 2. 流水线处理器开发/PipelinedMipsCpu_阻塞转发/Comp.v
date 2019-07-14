module Comp(
  input   [31:0]  A, B,
  output          CompD
  );
  
  assign CompD = (A == B) ? 1 : 0;
  
endmodule