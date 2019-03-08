module DP(input rst, clk, ld_b, ld_tmp, ld_w1, ld_w2, ld_yin, rst_flag, set_flag, init_all_reg, init_file_handler, next, sub, sel_sum2, sel_mult2, sel_yin, input[1:0] sel_sum1, sel_mult1, output equal, flag_out, EOF, t1_out, output[1:0] y_sign, output[13:0] b, w1, w2);
  wire [13:0] sum, mult, tmp, X1, X2, alpha, yin, yin_par, sum_input1, sum_input2, mult_input1, mult_input2;
  //wire [13:0] b, w1, w2;
  wire [6:0] x1, x2;
  wire [1:0] t;
  assign t1_out = t[1];
  assign alpha = 14'b00000011000000;
  
  sign my_sign_function(yin, y_sign);

  
  mux_4 mux_sum1(b, w1, w2, yin, sel_sum1, sum_input1);
  mux_2 mux_sum2(alpha, tmp, sel_sum2, sum_input2);
  mux_4 mux_mult1(.a(alpha), .b(w1), .c(w2), .d(w2), .sel(sel_mult1), .out(mult_input1));
  mux_2 mux_mult2(X1, X2, sel_mult2, mult_input2);
  mux_2 yin_mult(b, sum, sel_yin, yin_par);
  
  adder adder1(sum_input1, sum_input2, sum, sub);
  
  multiplier mult1(mult_input1, mult_input2, mult);
  
  comparator comp(y_sign, t, equal);
  
  register b_reg(.par(sum), .ld(ld_b), .init(init_all_reg), .clk(clk), .rst(rst), .out(b));
  register tmp_reg(.par(mult), .ld(ld_tmp), .init(init_all_reg), .clk(clk), .rst(rst), .out(tmp));
  register w1_reg(.par(sum), .ld(ld_w1), .init(init_all_reg), .clk(clk), .rst(rst), .out(w1));
  register w2_reg(.par(sum), .ld(ld_w2), .init(init_all_reg), .clk(clk), .rst(rst), .out(w2));
  register yin_reg(.par(yin_par), .ld(ld_yin), .init(init_all_reg), .clk(clk), .rst(rst), .out(yin));  
  
  read_file file_handler(clk, rst, init_file_handler, next, x1, x2, t, EOF);

  
  sign_extender extender1(x1, X1);
  sign_extender extender2(x2, X2);
  
  flag flag1(rst_flag, set_flag, flag_out);
  
endmodule
