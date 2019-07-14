module RegM(
  input               clk, reset,
  input       [31:0]  ALUOutE,
  input       [31:0]  WriteDataE,
  input       [4:0]   WriteRegE,
  input               RegWriteE,
  input               MemWriteE,
  input               MemToRegE,
  output  reg [31:0]  ALUOutM,
  output  reg [31:0]  WriteDataM,
  output  reg [4:0]   WriteRegM,
  output  reg         RegWriteM,
  output  reg         MemWriteM,
  output  reg         MemToRegM
  );
  
  initial
  begin
    ALUOutM     <= 0;
    WriteDataM  <= 0;
    WriteRegM   <= 0;
    RegWriteM   <= 0;
    MemWriteM   <= 0;
    MemToRegM   <= 0;
  end
  
  always @(posedge clk)
  begin
    if (reset)
    begin
      ALUOutM     <= 0;
      WriteDataM  <= 0;
      WriteRegM   <= 0;
      RegWriteM   <= 0;
      MemWriteM   <= 0;
      MemToRegM   <= 0;
    end
    else
    begin
      ALUOutM     <= ALUOutE;
      WriteDataM  <= WriteDataE;
      WriteRegM   <= WriteRegE;
      RegWriteM   <= RegWriteE;
      MemWriteM   <= MemWriteE;
      MemToRegM   <= MemToRegE;
    end
  end
  
endmodule