module dm_2k(
  input [10:2] addr,      // address bus
  input [31:0] din,       // 32-bit input data
  input we,               // memory write enable
  input clk,              // clock
  output [31:0] dout      // 32-bit memory output
  );
  
  reg [31:0] dm[511:0];
  
  assign dout = dm[addr[10:2]];
  
  always @(posedge clk)
  begin
    if (we)
      dm[addr] = din;
  end
  
endmodule