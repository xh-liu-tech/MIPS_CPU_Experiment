module NPCJump(
  input   [31:0]  PCPlus4F,
  input   [31:0]  InstrF,
  output  [31:0]  PCJumpF,
  output          Jump
  );
  
  assign PCJumpF = {PCPlus4F[31:28], InstrF[25:0], 2'b00};
  assign Jump = (InstrF[31:26] == 6'b000010) ? 1 : 0;
  
endmodule