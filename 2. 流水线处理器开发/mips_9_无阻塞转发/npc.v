module npc(
  input [31:0] pcAddr,
  output [31:0] npcAddr
  );
  
  assign npcAddr = pcAddr + 4;
  
endmodule