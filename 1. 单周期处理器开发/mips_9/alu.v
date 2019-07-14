module alu(
  input [31:0] input1, input2,
  input [3:0] aluCtrlSignal,
  output reg [31:0] aluRes,
  output zero
  );

  assign zero = (aluRes == 0) ? 1 : 0;
  always @(input1 or input2 or aluCtrlSignal)
  begin
    case (aluCtrlSignal)
      4'b0000 : aluRes = input1 & input2;
      4'b0001 : aluRes = input1 | input2;
      4'b0010 : aluRes = input1 + input2;
      4'b0110 : aluRes = input1 - input2;
      4'b0111:
      begin
        if (input1 < input2)
          aluRes = 1;
        else
          aluRes = 0;
      end
      4'b1100 : aluRes = ~(input1 | input2);
      default : aluRes = 0;
    endcase
  end
  
endmodule