module npc(
  input [25:0] inst,
  input [31:0] immi,
  input branch, zero, jump,
  input [31:0] pcAddr,
  output [31:0] npcAddr
  );
  
  wire [31:0] pc_plus_4, pc_branch, jumpAddr, muxRes;
  assign pc_plus_4 = pcAddr + 4;
  assign pc_branch = pc_plus_4 + {immi[29:0], 2'b00};
  assign jumpAddr = {pc_plus_4[31:28], inst, 2'b00};
  
  mux2 #(32) mux2a(.d0(pc_plus_4), .d1(pc_branch),
    .s(zero & branch), .y(muxRes));
  
  mux2 #(32) mux2b(.d0(muxRes), .d1(jumpAddr),
    .s(jump), .y(npcAddr));
  
endmodule