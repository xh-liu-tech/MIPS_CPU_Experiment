module MEM_WB_reg(
  input clk,
  input regWrite_in, memtoReg_in,
  input [31:0] dataRead_in, aluRes_in,
  input [4:0] regWriteAddr_in,
  output reg regWrite_out, memtoReg_out,
  output reg [31:0] dataRead_out, aluRes_out,
  output reg [4:0] regWriteAddr_out
  );
  
  always @(posedge clk)
  begin
    regWrite_out = regWrite_in;
    memtoReg_out = memtoReg_in;
    aluRes_out = aluRes_in;
    dataRead_out = dataRead_in;
    regWriteAddr_out = regWriteAddr_in;
  end
  
endmodule