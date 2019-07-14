module RegE(
  input               clk, rst,
  input               FlushE,
  input       [31:0]  PCPlus4D,
  input       [31:0]  SrcA2D, SrcB2D,
  input       [4:0]   RsD, RtD, RdD, ShamtD,
  input       [31:0]  ImmD,
  input               RegWriteD, RegDstD,
  input               MemWriteD, MemToRegD,
  input       [3:0]   ALUControlD,
  input       [1:0]   ALUSrcD,
  input               StartD,
  input               IsJJalD,
  input               IsJrJalrD,
  input               IsLbSbD,
  input               IsLhShD,
  input               IsUnsignedD,
  input               HiLoWriteD,
  input               HiLoD,
  input               IsShamtD,
  input       [1:0]   MdOpD,
  output  reg [31:0]  PCPlus8E,
  output  reg [31:0]  SrcA2E, SrcB2E,
  output  reg [4:0]   RsE, RtE, RdE, ShamtE,
  output  reg [31:0]  ImmE,
  output  reg         RegWriteE, RegDstE,
  output  reg         MemWriteE, MemToRegE,
  output  reg [3:0]   ALUControlE,
  output  reg [1:0]   ALUSrcE,
  output  reg         StartE,
  output  reg         IsJJalE,
  output  reg         IsJrJalrE,
  output  reg         IsLbSbE,
  output  reg         IsLhShE,
  output  reg         IsUnsignedE,
  output  reg         HiLoWriteE,
  output  reg         HiLoE,
  output  reg         IsShamtE,
  output  reg [1:0]   MdOpE
  );
  
  initial
  begin
    PCPlus8E    <= 0;
    SrcA2E       <= 0;
    SrcB2E       <= 0;
    RsE         <= 0;
    RtE         <= 0;
    RdE         <= 0;
    ShamtE      <= 0;
    ImmE        <= 0;
    RegWriteE   <= 0;
    RegDstE     <= 0;
    MemWriteE   <= 0;
    MemToRegE   <= 0;
    ALUControlE <= 0;
    ALUSrcE     <= 0;
    StartE      <= 0;
    IsJJalE     <= 0;
    IsJrJalrE   <= 0;
    IsLbSbE     <= 0;
    IsLhShE     <= 0;
    IsUnsignedE <= 0;
    HiLoWriteE  <= 0;
    HiLoE       <= 0;
    IsShamtE    <= 0;
    MdOpE       <= 0;
  end
  
  always @(posedge clk)
  begin
    if (FlushE || rst)
    begin
      PCPlus8E    <= 0;
      SrcA2E       <= 0;
      SrcB2E       <= 0;
      RsE         <= 0;
      RtE         <= 0;
      RdE         <= 0;
      ShamtE      <= 0;
      ImmE        <= 0;
      RegWriteE   <= 0;
      RegDstE     <= 0;
      MemWriteE   <= 0;
      MemToRegE   <= 0;
      ALUControlE <= 0;
      ALUSrcE     <= 0;
      StartE      <= 0;
      IsJJalE     <= 0;
      IsJrJalrE   <= 0;
      IsLbSbE     <= 0;
      IsLhShE     <= 0;
      IsUnsignedE <= 0;
      HiLoWriteE  <= 0;
      HiLoE       <= 0;
      IsShamtE    <= 0;
      MdOpE       <= 0;
    end
    else
    begin
      PCPlus8E    <= PCPlus4D;
      SrcA2E       <= SrcA2D;
      SrcB2E       <= SrcB2D;
      RsE         <= RsD;
      RtE         <= RtD;
      RdE         <= RdD;
      ShamtE      <= ShamtD;
      ImmE        <= ImmD;
      RegWriteE   <= RegWriteD;
      RegDstE     <= RegDstD;
      MemWriteE   <= MemWriteD;
      MemToRegE   <= MemToRegD;
      ALUControlE <= ALUControlD;
      ALUSrcE     <= ALUSrcD;
      StartE      <= StartD;
      IsJJalE     <= IsJJalD;
      IsJrJalrE   <= IsJrJalrD;
      IsLbSbE     <= IsLbSbD;
      IsLhShE     <= IsLhShD;
      IsUnsignedE <= IsUnsignedD;
      HiLoWriteE  <= HiLoWriteD;
      HiLoE       <= HiLoD;
      IsShamtE    <= IsShamtD;
      MdOpE       <= MdOpD;
    end
  end
  
endmodule