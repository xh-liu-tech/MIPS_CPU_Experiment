module PC(
  input               clk, reset, En,
  input               Jump, PCSrcD,
  input       [31:0]  PCJumpF, PCBranchD,
  output  reg [31:0]  PCPlus4F, PCF
  );
  
  initial
  begin
    PCF <= 32'h00003000;
    PCPlus4F <= 32'h00003004;
  end
  
  always @(posedge clk)
  begin
    if (reset)
    begin
      PCF = 32'h00003000;
      PCPlus4F = PCF + 4;
    end
    else if (!En)
    begin
      PCF = PCF;
      PCPlus4F = PCF + 4;
    end
    else if (PCSrcD)
    begin
      PCF = PCBranchD;
      PCPlus4F = PCF + 4;
    end
    else if (Jump)
    begin
      PCF = PCJumpF;
      PCPlus4F = PCF + 4;
    end
    else
    begin
      PCF = PCF + 4;
      PCPlus4F = PCF + 4;
    end
  end
  
endmodule