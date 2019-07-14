module regFile(
  input [4:0] rsAddr,
  input [4:0] rtAddr,
  input clk,
  input reset,
  input [4:0] regWriteAddr,
  input [31:0] regWriteData,
  input regWriteEn,
  output [31:0] rsData,
  output [31:0] rtData
  );
  
  reg [31:0] regs[0:31];
  
  assign rsData = (rsAddr == 5'b0) ? 32'b0 : regs[rsAddr];
  assign rtData = (rtAddr == 5'b0) ? 32'b0 : regs[rtAddr];
  
  integer i;
  
  always @(posedge clk or reset)
  begin
    if (!reset)
    begin
      if (regWriteEn)
      begin
        regs[regWriteAddr] = regWriteData;
      end
    end
    else
    begin
      for (i = 0; i < 32; i = i + 1)
      begin
        regs[i] = 0;
      end
    end
  end

endmodule