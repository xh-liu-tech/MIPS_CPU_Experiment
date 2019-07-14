module IF_ID_reg(
  input [31:0] inst_in,
  input clk,
  output reg [31:0] inst_out
  );
  
  always @(posedge clk)
  begin
    inst_out = inst_in;
  end
  
endmodule