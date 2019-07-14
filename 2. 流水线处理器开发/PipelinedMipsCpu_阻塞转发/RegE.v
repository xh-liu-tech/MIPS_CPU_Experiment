module RegE(
  input               clk, reset,
  input               FlushE,
  input       [31:0]  SrcAD, SrcBD,
  input       [4:0]   RsD, RtD, RdD,
  input       [31:0]  ImmD,
  input               RegWriteD, RegDstD,
  input               MemWriteD, MemToRegD,
  input       [3:0]   ALUControlD,
  input               ALUSrcAD, ALUSrcBD,
  output  reg [31:0]  SrcAE, SrcBE,
  output  reg [4:0]   RsE, RtE, RdE,
  output  reg [31:0]  ImmE,
  output  reg         RegWriteE, RegDstE,
  output  reg         MemWriteE, MemToRegE,
  output  reg [3:0]   ALUControlE,
  output  reg         ALUSrcAE, ALUSrcBE
  );
  
  initial
  begin
    SrcAE       <= 0;
    SrcBE       <= 0;
    RsE         <= 0;
    RtE         <= 0;
    RdE         <= 0;
    ImmE        <= 0;
    RegWriteE   <= 0;
    RegDstE     <= 0;
    MemWriteE   <= 0;
    MemToRegE   <= 0;
    ALUControlE <= 0;
    ALUSrcAE    <= 0;
    ALUSrcBE    <= 0;
  end
  
  always @(posedge clk)
  begin
    if (FlushE || reset)
    begin
      SrcAE       <= 0;
      SrcBE       <= 0;
      RsE         <= 0;
      RtE         <= 0;
      RdE         <= 0;
      ImmE        <= 0;
      RegWriteE   <= 0;
      RegDstE     <= 0;
      MemWriteE   <= 0;
      MemToRegE   <= 0;
      ALUControlE <= 0;
      ALUSrcAE    <= 0;
      ALUSrcBE    <= 0;
    end
    else
    begin
      SrcAE       <= SrcAD;
      SrcBE       <= SrcBD;
      RsE         <= RsD;
      RtE         <= RtD;
      RdE         <= RdD;
      ImmE        <= ImmD;
      RegWriteE   <= RegWriteD;
      RegDstE     <= RegDstD;
      MemWriteE   <= MemWriteD;
      MemToRegE   <= MemToRegD;
      ALUControlE <= ALUControlD;
      ALUSrcAE    <= ALUSrcAD;
      ALUSrcBE    <= ALUSrcBD;
    end
  end
  
endmodule