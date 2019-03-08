module multiplier(input signed[13:0] a, b, output signed[13:0] c);
  wire signed [25:0] result;
  assign result = a*b;
  assign c = result[17:4];
endmodule