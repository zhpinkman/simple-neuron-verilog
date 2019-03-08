module register(input[13:0] par,input rst, clk, init, ld, output reg[13:0] out);
  always @(posedge clk, posedge rst) begin
    if(rst | init)begin
      out <= 14'b0;
    end
    if(ld) begin
      out <= par;
    end
  end
endmodule 
