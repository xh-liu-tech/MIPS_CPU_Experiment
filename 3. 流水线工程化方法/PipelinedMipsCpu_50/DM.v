module DM_4k(
  input   [11:2]  A,    // address bus
  input   [31:0]  WD,   // 32-bit input data
  input           clk,  // clock
  input           WE,
  input   [3:0]   BE,
  output  [31:0]  RD    // 32-bit memory output
  );
  
  reg [31:0] RAM[0:1023];
  
  integer i;
  initial
    for (i = 0; i < 1023; i = i + 1)
      RAM[i] <= 0;
  
  assign RD = RAM[A];
  
  always @(posedge clk)
    if (WE)
      casex (BE)
        4'b0001: RAM[A][7:0]    <= WD[7:0];
        4'b0010: RAM[A][15:8]   <= WD[7:0];
        4'b0100: RAM[A][23:16]  <= WD[7:0];
        4'b1000: RAM[A][31:24]  <= WD[7:0];
        4'b0011: RAM[A][15:0]   <= WD[15:0];
        4'b1100: RAM[A][31:16]  <= WD[15:0];
        4'b1111: RAM[A]         <= WD;
        default: RAM[A]         <= 32'b0;
      endcase
  
endmodule