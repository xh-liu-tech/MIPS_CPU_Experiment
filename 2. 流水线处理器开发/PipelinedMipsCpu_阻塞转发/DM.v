module DM_4k(
  input   [11:2]  A,		// address bus
  input   [31:0]  WD,		// 32-bit input data
  input           WE,
  input           clk,		// clock
  output  [31:0]  RD		// 32-bit memory output
  );
  
  reg [31:0] RAM[0:1023];
  
  integer i;
  initial
    for (i = 0; i < 1023; i = i + 1)
      RAM[i] <= 0;
  
  assign RD = RAM[A[11:2]];
  
  always @(posedge clk)
    if (WE)
      RAM[A[11:2]] <= WD;
  
endmodule