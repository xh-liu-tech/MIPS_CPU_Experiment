module StartCtrl(
  input [31:0] InstrD,
  input        BusyE,
  output       StartD
  );
  
  parameter
    RType = 6'b000000,
    MULT  = 6'b011000,
    MULTU = 6'b011001,
    DIV   = 6'b011010,
    DIVU  = 6'b011011;
  
  assign StartD = (BusyE) ? 0 :
                  (
                    (InstrD[31:26] == RType &&
                      (InstrD[5:0] == MULT || InstrD[5:0] == MULTU ||
                       InstrD[5:0] == DIV  || InstrD[5:0] == DIVU)
                    ) ? 1 : 0
                  );
  
endmodule