module comparator(input[1:0] a, b, output c);
  assign c = (a == b) ? 1'b1 : 1'b0;
endmodule
