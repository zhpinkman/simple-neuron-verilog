module sign_extender(input [6:0] x, output [13:0] out);
  wire a = x[6];
  assign out = a == 1'b1 ? {7'b1111111, x} : {7'b0, x};
endmodule