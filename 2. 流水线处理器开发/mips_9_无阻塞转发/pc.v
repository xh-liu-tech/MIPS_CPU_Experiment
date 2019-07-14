module pc(
  input [31:0] npcAddr,
  input clk,
  input reset,
  output reg [31:0] pcAddr
  );
  
  always @(posedge clk)
    if (!reset)
      pcAddr = npcAddr;
    else
      pcAddr = 32'h00003000;
  
endmodule