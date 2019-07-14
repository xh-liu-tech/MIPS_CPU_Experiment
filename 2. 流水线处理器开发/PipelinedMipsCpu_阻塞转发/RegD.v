module RegD(
  input               clk, reset, En, FlushD,
  input       [31:0]  InstrF, PCPlus4F,
  output  reg [31:0]  InstrD, PCPlus4D
  );
  
  initial
  begin
    InstrD <= 0;
    PCPlus4D <= 0;
  end
  
  always @(posedge clk)
    if (reset)
    begin
      InstrD <= 0;
      PCPlus4D <= 0;
    end
    else if (En)
    begin
      InstrD <= InstrF;
      PCPlus4D <= PCPlus4F;
    end
    else if (FlushD)
    begin
      InstrD <= 0;
      PCPlus4D <= 0;
    end
    else
    begin
      InstrD <= InstrD;
      PCPlus4D <= PCPlus4D;
    end
  
endmodule