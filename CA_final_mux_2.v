module mux_2(input [13:0] a, b,input sel, output[13:0] out);
  /*
  always begin
    case (sel)
      0 : out = a;
      1 : out = b;
      default: out = 14'bz;
    endcase
  end
  */
  
  assign out = sel == 1'b0 ? a : sel == 1'b1 ? b : 14'bz;
endmodule 