module ALU(
  input       [31:0]  A, B,
  input       [3:0]   ALUControlE,
  output  reg [31:0]  ALUOutE
  );

  always @(*)
  begin
    case (ALUControlE)
      4'b0000 : ALUOutE <= A & B;
      4'b0001 : ALUOutE <= A | B;
      4'b0010 : ALUOutE <= A + B;
      4'b0110 : ALUOutE <= A - B;
      4'b0111 : ALUOutE <= (A < B) ? 1 : 0;
      4'b1100 : ALUOutE <= ~(A | B);
      default : ALUOutE <= 0;
    endcase
  end
  
endmodule