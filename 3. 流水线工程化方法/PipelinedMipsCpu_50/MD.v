module MD(
  input               clk, rst,
  input       [31:0]  D1, D2,
  input               WE, HiLo, Start,
  input       [1:0]   Op,
  output  reg         Busy,
  output  reg [31:0]  Hi, Lo
  );
  
  integer i;
  
  initial
  begin
    Hi    <= 0;
    Lo    <= 0;
    Busy  <= 0;
    i     <= 0;
  end
  
  always @(posedge clk)
  begin
    if (rst)
    begin
      Hi    <= 0;
      Lo    <= 0;
      Busy  <= 0;
      i     <= 0;
    end
    else if (Start)
    begin
      Busy <= 1'b1;
      case (Op)
        2'b00:
        begin
          {Hi, Lo} <= D1 * D2;
          i <= 5;
        end
        2'b01:
        begin
          {Hi, Lo} <= $signed(D1) * $signed(D2);
          i <= 5;
        end
        2'b10:
        begin
          Lo <= D1 / D2;
          Hi <= D1 % D2;
          i <= 10;
        end
        2'b11:
        begin
          Lo <= $signed(D1) / $signed(D2);
          Hi <= $signed(D1) % $signed(D2);
          i <= 10;
        end
      endcase
    end
    else if (i > 1)
      i <= i - 1;
    else if (i == 1)
    begin
      Busy <= 1'b0;
      i <= 0;
    end
  end
  
endmodule