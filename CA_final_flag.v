module flag(input rst, set, output reg out);
  always@(posedge rst, posedge set)begin
    if(rst) out <= 1'b0;
    else if(set) out <= 1'b1;
  else out <= 1'b0;
  end
endmodule