module mips(
  input clk,
  input rst
  );
  
  wire regDst, aluSrc, memtoReg, regWrite, memWrite, zero,
	memtoReg_out1, regWrite_out1, memWrite_out1,
	memtoReg_out2, regWrite_out2, memWrite_out2,
	regWrite_out3, memtoReg_out3;
  wire [1:0] aluOp, aluOp_out;
  wire [3:0] aluCtrlSignal;
  wire [4:0] muxRes1, rtAddr_out, rdAddr_out,
	regWriteAddr_out1, regWriteAddr_out2;
  wire [31:0] extended, inst, rsData, rtData, aluRes,
    dmReadData, muxRes2, muxRes3, pcAddr, npcAddr,
    inst_out, imme_out, rsData_out, rtData_out,	aluRes_out1, aluRes_out2,
	dataWrite_out, dataRead_out;
  
  mux2 #(5) mux2a(.d0(rtAddr_out), .d1(rdAddr_out),
    .s(regDst_out), .y(muxRes1));
  mux2 #(32) mux2b(.d0(rtData_out), .d1(imme_out),
    .s(aluSrc_out), .y(muxRes2));
  mux2 #(32) mux2c(.d0(aluRes_out2), .d1(dataRead_out),
    .s(memtoReg_out3), .y(muxRes3));
  
  IF_ID_reg IF_ID_reg(
    .inst_in(inst),
    .clk(clk),
    .inst_out(inst_out)
    );
  
  ID_EX_reg ID_EX_reg(
    .clk(clk),
    .regDst_in(regDst),
    .aluSrc_in(aluSrc),
    .memtoReg_in(memtoReg),
    .regWrite_in(regWrite),
    .memWrite_in(memWrite),
    .aluOp_in(aluOp),
    .rtAddr_in(inst_out[20:16]),
    .rdAddr_in(inst_out[15:11]),
    .imme_in(extended),
    .rsData_in(rsData),
    .rtData_in(rtData),
    .regDst_out(regDst_out),
    .aluSrc_out(aluSrc_out),
    .memtoReg_out(memtoReg_out1),
    .regWrite_out(regWrite_out1),
    .memWrite_out(memWrite_out1),
    .aluOp_out(aluOp_out),
    .rtAddr_out(rtAddr_out),
    .rdAddr_out(rdAddr_out),
    .imme_out(imme_out),
    .rsData_out(rsData_out),
    .rtData_out(rtData_out)
    );
  
  EX_MEM_reg EX_MEM_reg(
    .clk(clk),
    .memWrite_in(memWrite_out1),
    .regWrite_in(regWrite_out1),
    .memtoReg_in(memtoReg_out1),
    .aluRes_in(aluRes),
    .dataWrite_in(rtData_out),
    .regWriteAddr_in(muxRes1),
    .memWrite_out(memWrite_out2),
    .regWrite_out(regWrite_out2),
    .memtoReg_out(memtoReg_out2),
    .aluRes_out(aluRes_out1),
    .dataWrite_out(dataWrite_out),
    .regWriteAddr_out(regWriteAddr_out1)
    );
  
  MEM_WB_reg MEM_WB_reg(
    .clk(clk),
    .regWrite_in(regWrite_out2),
    .memtoReg_in(memtoReg_out2),
    .dataRead_in(dmReadData),
    .aluRes_in(aluRes_out1),
    .regWriteAddr_in(regWriteAddr_out1),
    .regWrite_out(regWrite_out3),
    .memtoReg_out(memtoReg_out3),
    .dataRead_out(dataRead_out),
    .aluRes_out(aluRes_out2),
    .regWriteAddr_out(regWriteAddr_out2)
    );
  
  dm_4k dm(
    .addr(aluRes_out1[11:2]),
    .din(dataWrite_out),
    .we(memWrite_out2),
    .clk(clk),
    .dout(dmReadData)
    );
  
  im_2k im(
    .addr(pcAddr[10:2]),
    .dout(inst)
    );
  
  signExt signExt(
    .before(inst_out[15:0]),
    .after(extended)
    );
  
  npc npc(
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
    .opcode(inst_out[31:26]),
    .regDst(regDst),
    .aluSrc(aluSrc),
    .memtoReg(memtoReg),
    .regWrite(regWrite),
    .memWrite(memWrite),
    .aluOp(aluOp)
    );
  
  alu alu(
    .input1(rsData_out),
    .input2(muxRes2),
    .aluCtrlSignal(aluCtrlSignal),
    .zero(zero),
    .aluRes(aluRes)
    );
  
  aluCtrl aluCtrl(
    .aluOp(aluOp_out),
    .funct(imme_out[5:0]),
    .aluCtrlSignal(aluCtrlSignal)
    );
  
  regFile regFile(
    .rsAddr(inst_out[25:21]),
    .rtAddr(inst_out[20:16]),
    .clk(clk),
    .reset(rst),
    .regWriteAddr(regWriteAddr_out2),
    .regWriteData(muxRes3),
    .regWriteEn(regWrite_out3),
    .rsData(rsData),
    .rtData(rtData)
    );
  
endmodule