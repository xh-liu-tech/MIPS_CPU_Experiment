module MIPS(
  input clk,
  input rst
  );
  
  wire        PCSrcD, BranchD, CompD, Jump, StallF, StallD, FlushD, FlushE;
  wire        RegWriteD, MemWriteD, MemToRegD, ALUSrcAD, ALUSrcBD, RegDstD, RegWriteW;
  wire        ForwardAD, ForwardBD, RegWriteE, RegDstE, MemWriteE, MemToRegE;
  wire        ALUSrcAE, ALUSrcBE, RegWriteM, MemWriteM, MemToRegM, MemToRegW;
  wire [1:0]  ALUOp, ForwardAE, ForwardBE;
  wire [3:0]  ALUControlD, ALUControlE;
  wire [4:0]  RsD, RtD, RdD, WriteRegW, RsE, RtE, RdE, WriteRegE, WriteRegM;
  wire [5:0]  OpD, FunctD;
  wire [31:0] PCJumpF, PCBranchD, PCPlus4F, PCF, PCPlus4D;
  wire [31:0] InstrF, InstrD, ResultW, SrcAD, SrcBD, ALUOutM, SrcA2D, SrcB2D, ImmD, ImmE;
  wire [31:0] SrcAE, SrcBE, SrcA2E, SrcB2E, SrcA3E, SrcB3E, ALUOutE, WriteDataM, ReadDataM;
  wire [31:0] ALUOutW, ReadDataW, WriteData2M;
  
  Hazard Hazard(RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW, BranchD, MemWriteD, MemWriteM, MemWriteW,
                PCSrcD, MemToRegE, MemToRegM, RegWriteE, RegWriteM, RegWriteW,
                StallF, StallD, FlushD, FlushE, ForwardAD, ForwardBD, ForwardM, ForwardAE, ForwardBE);
  
  // IF
  assign PCSrcD = BranchD && CompD;
  PC PC(clk, rst, !StallF, Jump, PCSrcD, PCJumpF, PCBranchD, PCPlus4F, PCF);
  IM_2k IM(PCF[10:2], InstrF);
  NPCJump NPCJump(PCPlus4F, InstrF, PCJumpF, Jump);
  
  // ID
  assign OpD = InstrD[31:26];
  assign FunctD = InstrD[5:0];
  assign RsD = InstrD[25:21];
  assign RtD = InstrD[20:16];
  assign RdD = InstrD[15:11];
  RegD RegD(clk, rst, !StallD, FlushD, InstrF, PCPlus4F, InstrD, PCPlus4D);
  Ctrl Ctrl(OpD, RegWriteD, MemWriteD, MemToRegD, ALUOp, ALUSrcAD, ALUSrcBD, RegDstD, BranchD);
  ALUCtrl ALUCtrl(ALUOp, FunctD, ALUControlD);
  RegFile RegFile(clk, rst, RegWriteW, RsD, RtD, WriteRegW, ResultW, SrcAD, SrcBD);
  MUX2 #(32) ForwardADMUX(SrcAD, ALUOutM, ForwardAD, SrcA2D);
  MUX2 #(32) ForwardBDMUX(SrcBD, ALUOutM, ForwardBD, SrcB2D);
  Comp Comp(SrcA2D, SrcB2D, CompD);
  SignExt SignExt(InstrD[15:0], ImmD);
  NPCBranch NPCBranch(PCPlus4D, ImmD, PCBranchD);
  
  // EX
  RegE RegE(clk, rst, FlushE, SrcAD, SrcBD, RsD, RtD, RdD, ImmD, RegWriteD, RegDstD,
            MemWriteD, MemToRegD, ALUControlD, ALUSrcAD, ALUSrcBD,
            SrcAE, SrcBE, RsE, RtE, RdE, ImmE, RegWriteE, RegDstE, MemWriteE, MemToRegE,
            ALUControlE, ALUSrcAE, ALUSrcBE);
  MUX2 #(5)  WriteRegMUX(RtE, RdE, RegDstE, WriteRegE);
  MUX3 #(32) ForwardAEMUX(SrcAE, ResultW, ALUOutM, ForwardAE, SrcA2E);
  MUX3 #(32) ForwardBEMUX(SrcBE, ResultW, ALUOutM, ForwardBE, SrcB2E);
  MUX2 #(32) SrcAEMUX(SrcA2E, ImmE, ALUSrcAE, SrcA3E);
  MUX2 #(32) SrcBEMUX(SrcB2E, ImmE, ALUSrcBE, SrcB3E);
  ALU ALU(SrcA3E, SrcB3E, ALUControlE, ALUOutE);
  
  // MEM
  RegM RegM(clk, rst, ALUOutE, SrcB2E, WriteRegE, RegWriteE, MemWriteE, MemToRegE,
            ALUOutM, WriteDataM, WriteRegM, RegWriteM, MemWriteM, MemToRegM);
  MUX2 #(32) ForwardMMUX(WriteDataM, ResultW, ForwardM, WriteData2M);
  DM_4k DM(ALUOutM[11:2], WriteData2M, MemWriteM, clk, ReadDataM);
  
  // WB
  RegW RegW(clk, rst, ALUOutM, ReadDataM, WriteRegM, RegWriteM, MemWriteM, MemToRegM,
            ALUOutW, ReadDataW, WriteRegW, RegWriteW, MemWriteW, MemToRegW);
  MUX2 #(32) ResultMUX(ALUOutW, ReadDataW, MemToRegW, ResultW);
  
endmodule