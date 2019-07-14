module BECtrl(
  input   [1:0] ByteOffset,
  input         IsLhShM, IsLbSbM,
  output  [3:0] BEOutM
  );
  
  assign BEOutM = (!IsLhShM && !IsLbSbM) ? 4'b1111:
                  (IsLbSbM) ?
                    (
                      (ByteOffset == 2'b00) ? 4'b0001 :
                      (ByteOffset == 2'b01) ? 4'b0010 :
                      (ByteOffset == 2'b10) ? 4'b0100 :
                      (ByteOffset == 2'b11) ? 4'b1000 : 4'b0
                    ) :
                  (IsLhShM) ?
                    (
                      (ByteOffset == 2'b00) ? 4'b0011 :
                      (ByteOffset == 2'b10) ? 4'b1100 : 4'b0
                    ) : 4'b0;
  
endmodule