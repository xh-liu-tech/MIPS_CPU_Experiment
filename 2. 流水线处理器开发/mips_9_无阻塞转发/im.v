module im_2k(
  input [10:2] addr,      // address bus
  output [31:0] dout      // 32-bit memory output
  );
  
  reg [31:0] im[511:0];
  
  initial
  begin
    $readmemh("code.txt", im);
  end
  
  assign dout = im[addr[10:2]];
  
endmodule