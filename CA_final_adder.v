module adder(input[13:0] a, b, output[13:0] c, input sub);
  /*
  always begin
    if(sub == 1'b1) c = a - b;
    else c = a + b;
  end
  */
  assign c = (sub == 1'b1) ? (a - b) : (a + b);
endmodule 
