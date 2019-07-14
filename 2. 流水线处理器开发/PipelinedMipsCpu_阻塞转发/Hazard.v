module Hazard(
  input   [4:0] RsD, RtD,
  input   [4:0] RsE, RtE,
  input   [4:0] WriteRegE, WriteRegM, WriteRegW,
  input         BranchD,
  input         MemWriteD, MemWriteM, MemWriteW,
  input         PCSrcD,
  input         MemToRegE, MemToRegM,
  input         RegWriteE, RegWriteM, RegWriteW,
  output        StallF, StallD,
  output        FlushD, FlushE,
  output        ForwardAD, ForwardBD, ForwardM,
  output  [1:0] ForwardAE, ForwardBE
  );
  
  // Forward
  // beq
  assign ForwardAD = (WriteRegM != 0) && (RsD != 0) && (RsD == WriteRegM) && (RegWriteM);
  assign ForwardBD = (WriteRegM != 0) && (RtD != 0) && (RtD == WriteRegM) && (RegWriteM);
  
  assign ForwardAE =  ((WriteRegM != 0) && (RsE != 0) && (RsE == WriteRegM) && (RegWriteM)) ? 2'b10 :
                      ((WriteRegW != 0) && (RsE != 0) && (RsE == WriteRegW) && (RegWriteW)) ? 2'b01 :
                      2'b00;
  assign ForwardBE =  ((WriteRegM != 0) && (RtE != 0) && (RtE == WriteRegM) && (RegWriteM)) ? 2'b10 :
                      ((WriteRegW != 0) && (RtE != 0) && (RtE == WriteRegW) && (RegWriteW)) ? 2'b01 :
                      2'b00;
  
  assign ForwardM = MemWriteM && !MemWriteW && (WriteRegM == WriteRegW);
  
  // Stall
  assign LwStallD = MemToRegE && !MemWriteD && ((WriteRegE == RsD && RsD != 0) || (WriteRegE == RtD && RtD != 0));
  
  assign BranchStallD = BranchD &&
                        ((RegWriteE && ((WriteRegE == RsD && RsD != 0) || (WriteRegE == RtD && RtD != 0))) ||
                         (MemToRegM && ((WriteRegM == RsD && RsD != 0) || (WriteRegM == RtD && RtD != 0))));
  
  assign StallD = LwStallD || BranchStallD;
  assign FlushE = StallD;
  assign StallF = StallD;
  assign FlushD = !StallD && (StallF || PCSrcD);
  
endmodule