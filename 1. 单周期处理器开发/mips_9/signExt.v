module signExt(
  input [15:0] before,
  output [31:0] after
  );
  
  assign after = {{16{before[15]}}, before};

endmodule