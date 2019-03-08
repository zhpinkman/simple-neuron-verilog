module mux_4(input [13:0]a, b, c, d, input [1:0] sel, output[13:0] out);
  
  /*
  always begin
    out = 14'b0;
    case (sel)
      0 : out = a; 
      1 : out = b;
      2 : out = c;
      3 : out = d;
      default: out =  14'bz;
    endcase
  end
  */
  assign out = sel == 2'b00 ? a : sel == 2'b01 ? b : sel == 2'b10 ? c : sel == 2'b11 ? d : 14'bz;
endmodule 