module PC(
  input               clk, rst, En,
  input               IsJBrD,
  input       [31:0]  NPCD,
  output  reg [31:0]  PCPlus4F, PCF
  );
  
  initial
  begin
    PCF <= 32'h00003000;
    PCPlus4F <= 32'h00003004;
  end
  
  always @(posedge clk)
  begin
    if (rst)
    begin
      PCF = 32'h00003000;
      PCPlus4F = PCF + 4;
    end
    else if (!En)
    begin
      PCF = PCF;
      PCPlus4F = PCF + 4;
    end
    else if (IsJBrD)
    begin
      PCF = NPCD;
      PCPlus4F = PCF + 4;
    end
    else
    begin
      PCF = PCF + 4;
      PCPlus4F = PCF + 4;
    end
  end
  
endmodule