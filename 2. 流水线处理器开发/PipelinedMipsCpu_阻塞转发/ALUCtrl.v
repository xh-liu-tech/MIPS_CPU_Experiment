module ALUCtrl(
  input       [1:0] ALUOp,
  input       [5:0] FunctD,
  output  reg [3:0] ALUControlD
  );
  
  initial ALUControlD <= 4'b0;
  
  always @(*)
    casex ({ALUOp, FunctD})
      8'b00xxxxxx : ALUControlD <= 4'b0010;  // lw & sw
      8'b10xx0000 : ALUControlD <= 4'b0010;  // add
      8'b1xxx0010 : ALUControlD <= 4'b0110;  // sub
      8'b10xx0100 : ALUControlD <= 4'b0000;  // and
      8'b10xx0101 : ALUControlD <= 4'b0001;  // or
      8'b10xx1010 : ALUControlD <= 4'b0111;  // slt
    endcase
  
endmodule