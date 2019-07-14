module Hazard(
  input   [5:0] OpD,
  input   [4:0] RsD, RtD, RsE, RtE, RtM,
  input   [4:0] WriteRegE, WriteRegM, WriteRegW,
  input   [1:0] ALUSrcD,
  input         IsJrJalrD, BranchD, IsMdD, BusyE,
  input         IsJJalM, IsJrJalrM,
  input         MemToRegE, MemToRegM, MemWriteM,
  input         RegWriteE, RegWriteM, RegWriteW,
  output        StallF, StallD, FlushE,
  output  [1:0] ForwardAD, ForwardBD, ForwardAE, ForwardBE,
  output        ForwardM
  );
  
  parameter 
    BEQ   = 6'b000100,
    BNE   = 6'b000101,
    RType = 6'b000000;
  
  wire UseRsD, UseRtD, UseRsE, UseRtE;
  
  assign UseRsD = IsJrJalrD || BranchD;
  assign UseRtD = (OpD == BEQ) || (OpD == BNE);
  assign UseRsE = (OpD == RType) || (ALUSrcD == 2'b01);
  assign UseRtE = OpD == RType;
  
  assign StallF = FlushE;
  assign StallD = FlushE;
  assign FlushE = (UseRsD && (((RsD == WriteRegE) && RegWriteE) || ((RsD == WriteRegM) && MemToRegM))) ||
                  (UseRtD && (((RtD == WriteRegE) && RegWriteE) || ((RtD == WriteRegM) && MemToRegM))) ||
                  (UseRsE && (RsD == WriteRegE) && MemToRegE) ||
                  (UseRtE && (RtD == WriteRegE) && MemToRegE) ||
                  (IsMdD && BusyE);
  
  assign ForwardAD = ((RsD == WriteRegM) && RegWriteM && (IsJJalM || IsJrJalrM) && (WriteRegM != 5'b00000)) ? 2'b11 :
                     ((RsD == WriteRegM) && RegWriteM && (WriteRegM != 5'b00000)) ? 2'b01 :
                     ((RsD == WriteRegW) && RegWriteW && (WriteRegW != 5'b00000)) ? 2'b10 : 2'b00 ;
  assign ForwardBD = ((RtD == WriteRegM) && RegWriteM && (WriteRegM != 5'b00000)) ? 2'b01 :
                     ((RtD == WriteRegW) && RegWriteW && (WriteRegW != 5'b00000)) ? 2'b10 : 2'b00 ;
  assign ForwardAE = ((RsE == WriteRegM) && RegWriteM && (WriteRegM != 5'b00000)) ? 2'b01 :
                     ((RsE == WriteRegW) && RegWriteW && (WriteRegW != 5'b00000)) ? 2'b10 : 2'b00 ;
  assign ForwardBE = ((RtE == WriteRegM) && RegWriteM && (WriteRegM != 5'b00000)) ? 2'b01 :
                     ((RtE == WriteRegW) && RegWriteW && (WriteRegW != 5'b00000)) ? 2'b10 : 2'b00 ;
  assign ForwardM  = ((RtM == WriteRegW) && RegWriteW && (WriteRegW != 5'b00000)) ? 1 : 0;
  
endmodule