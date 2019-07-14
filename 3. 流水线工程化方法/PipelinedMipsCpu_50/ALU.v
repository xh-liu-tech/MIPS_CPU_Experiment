module ALU(
  input   [31:0]  A, B,
  input   [3:0]   ALUControlE,
  output  [31:0]  ALUOutE
  );

  parameter 
		ADDU = 4'b0000,
		ADD  = 4'b0001,
		SUBU = 4'b0010,
		SUB  = 4'b0011,
		SLTU = 4'b0100,
		SLT  = 4'b0101,
		SLL  = 4'b0110,
		SLLV = 4'b0111,
		SRL  = 4'b1000,
		SRLV = 4'b1001,
		SRA  = 4'b1010,
		SRAV = 4'b1011,
		AND  = 4'b1100,
		OR   = 4'b1101,
		XOR  = 4'b1110,
		NOR  = 4'b1111;
  
  reg [31:0] Temp;
  always @(*)
    Temp <= $signed(B) >>> $signed(A[4:0]);
  
  assign ALUOutE = (ALUControlE == ADDU)  ? (A + B) :
                   (ALUControlE == ADD)   ? (A + B) :
                   (ALUControlE == SUBU)  ? (A - B) :
                   (ALUControlE == SUB)   ? (A - B) :
                   (ALUControlE == SLTU)  ? ((A < B) ? 1 : 0) :
                   (ALUControlE == SLT)   ? (($signed(A) < $signed(B)) ? 1 : 0) :
                   (ALUControlE == SLL)   ? (B << A[4:0]) :
                   (ALUControlE == SLLV)  ? (B << A[4:0]) :
                   (ALUControlE == SRL)   ? (B >> A[4:0]) :
                   (ALUControlE == SRLV)  ? (B >> A[4:0]) :
                   (ALUControlE == SRA)   ? (Temp) :
                   (ALUControlE == SRAV)  ? (Temp) :
                   (ALUControlE == AND)   ? (A & B) :
                   (ALUControlE == OR)    ? (A | B) :
                   (ALUControlE == XOR)   ? (A ^ B) :
                   (ALUControlE == NOR)   ? ~(A | B) :
                                            32'b0;
  
endmodule