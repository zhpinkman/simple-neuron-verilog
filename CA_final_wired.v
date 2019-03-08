module wired(input clk, rst, start, output ready, output[1:0] y_sign, output[13:0] b, w1, w2);
   wire ld_b, ld_tmp, ld_w1, ld_w2, ld_yin, rst_flag, set_flag;
   wire sel_sum2, sel_mult2, sel_yin;
   wire[1:0] sel_sum1, sel_mult1;
   wire init_all_reg, init_file_handler, next, sub, equal, flag_out, EOF, t1_out;
   DP dp(rst, clk, ld_b, ld_tmp, ld_w1, ld_w2, ld_yin, rst_flag, set_flag, init_all_reg, init_file_handler, next, sub, sel_sum2, sel_mult2, sel_yin, sel_sum1, sel_mult1, equal, flag_out, EOF, t1_out, y_sign, b, w1, w2);
   Controller controller(rst, clk, equal, flag_out, EOF, start, t1_out, ld_b, ld_tmp, ld_w1, ld_w2, ld_yin, rst_flag, set_flag, sel_yin, sel_mult2, sel_sum2, init_all_reg, init_file_handler, next, sub, ready, sel_mult1, sel_sum1);
 endmodule
