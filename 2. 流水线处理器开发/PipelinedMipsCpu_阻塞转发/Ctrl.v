module Ctrl(
  input   [5:0] OpD,
  output        RegWriteD,
  output        MemWriteD,
  output        MemToRegD,
  output  [1:0] ALUOp,
  output        ALUSrcAD,
  output        ALUSrcBD,
  output        RegDstD,
  output        BranchD
  );
  
  reg [10:0] CtrlCode;
  assign {RegWriteD, MemWriteD, MemToRegD,  // 1, 1, 1
          ALUOp, ALUSrcAD, ALUSrcBD,        // 2, 1, 1
          RegDstD, BranchD                  // 1, 1
          } = CtrlCode;
  
  initial CtrlCode <= 9'b0;
  
  always @(*)
    casex (OpD)
      6'b000000:      // R-type
        CtrlCode <= 9'b1_0_0_10_0_0_1_0;
      6'b100011:      // lw
        CtrlCode <= 9'b1_0_1_00_0_1_0_0;
      6'b101011:      // sw
        CtrlCode <= 9'b0_1_0_00_0_1_0_0;
      6'b001000:      // addi
        CtrlCode <= 9'b1_0_0_00_0_1_0_0;
      6'b000100:      // beq
        CtrlCode <= 9'b0_0_0_01_0_0_0_1;
      default:
        CtrlCode <= 9'b0;
    endcase
  
endmodule