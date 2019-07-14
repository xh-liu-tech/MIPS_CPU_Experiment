module ID_EX_reg(
  input clk,
  input regDst_in, aluSrc_in, memtoReg_in, regWrite_in, memWrite_in,
  input [1:0] aluOp_in,
  input [4:0] rtAddr_in, rdAddr_in,
  input [31:0] imme_in, rsData_in, rtData_in,
  output reg regDst_out, aluSrc_out, memtoReg_out, regWrite_out, memWrite_out,
  output reg [1:0] aluOp_out,
  output reg [4:0] rtAddr_out, rdAddr_out,
  output reg [31:0] imme_out, rsData_out, rtData_out
  );
  
  always @(posedge clk)
  begin
    regDst_out = regDst_in;
    aluSrc_out = aluSrc_in;
    memtoReg_out = memtoReg_in;
    regWrite_out = regWrite_in;
    memWrite_out = memWrite_in;
    aluOp_out = aluOp_in;
    rtAddr_out = rtAddr_in;
    rdAddr_out = rdAddr_in;
    imme_out = imme_in;
    rsData_out = rsData_in;
    rtData_out = rtData_in;
  end
  
endmodule