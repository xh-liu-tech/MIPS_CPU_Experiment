module EX_MEM_reg(
  input clk,
  input memWrite_in, regWrite_in, memtoReg_in,
  input [31:0] aluRes_in, dataWrite_in,
  input [4:0] regWriteAddr_in,
  output reg memWrite_out, regWrite_out, memtoReg_out,
  output reg [31:0] aluRes_out, dataWrite_out,
  output reg [4:0] regWriteAddr_out
  );
  
  always @(posedge clk)
  begin
    memWrite_out = memWrite_in;
    regWrite_out = regWrite_in;
    memtoReg_out = memtoReg_in;
    aluRes_out = aluRes_in;
    dataWrite_out = dataWrite_in;
    regWriteAddr_out = regWriteAddr_in;
  end
  
endmodule