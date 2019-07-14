module ctrl(
  input [5:0] opcode,
  output reg regDst, aluSrc, memtoReg, regWrite, memWrite, branch, jump,
  output reg [1:0] aluOp
  );
  
  initial
  begin
    regDst = 0;
    aluSrc = 0;
    memtoReg = 0;
    regWrite = 0;
    memWrite = 0;
    branch = 0;
    aluOp = 2'b00;
    jump = 0;
  end
  
  always @(opcode)
  begin
    case (opcode)
      6'b000000:        // R-type
      begin
        regDst = 1;
        aluSrc = 0;
        memtoReg = 0;
        regWrite = 1;
        memWrite = 0;
        branch = 0;
        aluOp = 2'b10;
        jump = 0;
      end
      6'b100011:        // lw
      begin
        regDst = 0;
        aluSrc = 1;
        memtoReg = 1;
        regWrite = 1;
        memWrite = 0;
        branch = 0;
        aluOp = 2'b00;
        jump = 0;
      end
      6'b101011:        // sw
      begin
        regDst = 0;     // x
        aluSrc = 1;
        memtoReg = 0;   // x
        regWrite = 0;
        memWrite = 1;
        branch = 0;
        aluOp = 2'b00;
        jump = 0;
      end
      6'b000100:        // beq
      begin
        regDst = 0;     // x
        aluSrc = 0;
        memtoReg = 0;   // x
        regWrite = 0;
        memWrite = 0;
        branch = 1;
        aluOp = 2'b01;
        jump = 0;
      end
      6'b000010:        // jump
      begin
        regDst = 0;
        aluSrc = 0;
        memtoReg = 0;
        regWrite = 0;
        memWrite = 0;
        branch = 0;
        aluOp = 2'b00;
        jump = 1;
      end
      6'b001000:        // addi
      begin
        regDst = 0;
        aluSrc = 1;
        memtoReg = 0;
        regWrite = 1;
        memWrite = 0;
        branch = 0;
        aluOp = 2'b00;
        jump = 0;
      end
      6'b001100:        // andi
      begin
        regDst = 0;
        aluSrc = 1;
        memtoReg = 0;
        regWrite = 1;
        memWrite = 0;
        branch = 0;
        aluOp = 2'b11;
        jump = 0;
      end
      default:
      begin
        regDst = 0;
        aluSrc = 0;
        memtoReg = 0;
        regWrite = 0;
        memWrite = 0;
        branch = 0;
        aluOp = 2'b00;
        jump = 0;
      end
    endcase
  end
endmodule