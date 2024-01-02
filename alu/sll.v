module ShiftLeft (
  input [31:0] data_in,
  input [4:0] shift_amount,
  output [31:0] shifted_data
);

  assign shifted_data = data_in << shift_amount;

endmodule