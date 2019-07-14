module mips(
  input clk,
  input rst
  );
  
  wire regDst, aluSrc, memtoReg, regWrite, memWrite, branch, jump;
  wire zero;
  wire [1:0] aluOp;
  wire [3:0] aluCtrlSignal;
  wire [4:0] muxRes1;
  wire [31:0] extended, inst, rsData, rtData, aluRes,
    dmReadData, muxRes2, muxRes3, pcAddr, npcAddr;
  
  mux2 #(5) mux2a(.d0(inst[20:16]), .d1(inst[15:11]),
    .s(regDst), .y(muxRes1));
  mux2 #(32) mux2b(.d0(rtData), .d1(extended),
    .s(aluSrc), .y(muxRes2));
  mux2 #(32) mux2c(.d0(aluRes), .d1(dmReadData),
    .s(memtoReg), .y(muxRes3));
  
  dm_2k dm(
    .addr(aluRes[10:2]),
    .din(rtData),
    .we(memWrite),
    .clk(clk),
    .dout(dmReadData)
    );
  
  im_4k im(
    .addr(pcAddr[11:2]),
    .dout(inst)
    );
  
  signExt signExt(
    .before(inst[15:0]),
    .after(extended)
    );
  
  npc npc(
    .inst(inst[25:0]),
    .immi(extended),
    .branch(branch),
    .zero(zero),
    .jump(jump),
    .pcAddr(pcAddr),
    .npcAddr(npcAddr)
    );
  
  pc pc(
    .npcAddr(npcAddr),
    .clk(clk),
    .reset(rst),
    .pcAddr(pcAddr)
    );
  
  ctrl ctrl(
    .opcode(inst[31:26]),
    .regDst(regDst),
    .aluSrc(aluSrc),
    .memtoReg(memtoReg),
    .regWrite(regWrite),
    .memWrite(memWrite),
    .branch(branch),
    .aluOp(aluOp),
    .jump(jump)
    );
  
  alu alu(
    .input1(rsData),
    .input2(muxRes2),
    .aluCtrlSignal(aluCtrlSignal),
    .zero(zero),
    .aluRes(aluRes)
    );
  
  aluCtrl aluCtrl(
    .aluOp(aluOp),
    .funct(inst[5:0]),
    .aluCtrlSignal(aluCtrlSignal)
    );
  
  regFile regFile(
    .rsAddr(inst[25:21]),
    .rtAddr(inst[20:16]),
    .clk(clk),
    .reset(rst),
    .regWriteAddr(muxRes1),
    .regWriteData(muxRes3),
    .regWriteEn(regWrite),
    .rsData(rsData),
    .rtData(rtData)
    );
  
endmodule