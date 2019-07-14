module NPC(
  input   [31:0]  PCPlus4D,
  input   [25:0]  ImmD_26,
  input   [31:0]  ImmD_32, Reg_32,
  input           IsJJalD, IsJrJalrD, BranchD, CompD,
  output  [31:0]  NPCD,
  output          IsJBrD
  );
  
  assign NPCD = (IsJJalD)           ? {PCPlus4D[31:28], ImmD_26, 2'b00} :
                (IsJrJalrD)         ? Reg_32 :
                (BranchD && CompD)  ? PCPlus4D + ImmD_32 : PCPlus4D + 4;
  assign IsJBrD = ((BranchD && CompD) || IsJJalD || IsJrJalrD);
  
endmodule