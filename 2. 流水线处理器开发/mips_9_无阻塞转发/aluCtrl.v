module aluCtrl(
  input [1:0] aluOp,
  input [5:0] funct,
  output reg [3:0] aluCtrlSignal
  );
  
  always @(aluOp or funct)
  casex ({aluOp, funct})
    8'b00xxxxxx : aluCtrlSignal = 4'b0010;
    8'b10xx0000 : aluCtrlSignal = 4'b0010;
    8'b1xxx0010 : aluCtrlSignal = 4'b0110;
    8'b10xx0100 : aluCtrlSignal = 4'b0000;
    8'b10xx0101 : aluCtrlSignal = 4'b0001;
    8'b10xx1010 : aluCtrlSignal = 4'b0111;
    8'b11xxxxxx : aluCtrlSignal = 4'b0000;
  endcase
  
endmodule