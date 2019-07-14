module NPCBranch(
  input   [31:0]  PCPlus4D,
  input   [31:0]  ImmD_32,
  output  [31:0]  PCBranchD
  );
  
  assign PCBranchD = PCPlus4D + {ImmD_32[29:0], 2'b00};
  
endmodule