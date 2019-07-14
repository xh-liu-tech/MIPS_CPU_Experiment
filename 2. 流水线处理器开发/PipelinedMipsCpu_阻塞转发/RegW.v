module RegW(
  input               clk, reset,
  input       [31:0]  ALUOutM,
  input       [31:0]  ReadDataM,
  input       [4:0]   WriteRegM,
  input               RegWriteM,
  input               MemWriteM,
  input               MemToRegM,
  output  reg [31:0]  ALUOutW,
  output  reg [31:0]  ReadDataW,
  output  reg [4:0]   WriteRegW,
  output  reg         RegWriteW,
  output  reg         MemWriteW,
  output  reg         MemToRegW
  );
  
  initial
  begin
    ALUOutW   <= 0;
    ReadDataW <= 0;
    WriteRegW <= 0;
    RegWriteW <= 0;
    MemWriteW <= 0;
    MemToRegW <= 0;
  end
  
  always @(posedge clk)
  begin
    if (reset)
    begin
      ALUOutW   <= 0;
      ReadDataW <= 0;
      WriteRegW <= 0;
      RegWriteW <= 0;
      MemWriteW <= 0;
      MemToRegW <= 0;
    end
    else
    begin
      ALUOutW   <= ALUOutM;
      ReadDataW <= ReadDataM;
      WriteRegW <= WriteRegM;
      RegWriteW <= RegWriteM;
      MemWriteW <= MemWriteM;
      MemToRegW <= MemToRegM;
    end
  end
  
endmodule