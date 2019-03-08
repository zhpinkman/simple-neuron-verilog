//module controller(input read_file_finished, YTequal, output sub, selmux)
module Controller(input rst, clk, equal, flag_change, EOF, start, t1, output reg ld_b, ld_tmp, ld_w1, ld_w2, ld_yin, rst_flag, set_flag, sel_yin, sel_mult2, sel_sum2, init_all_reg, init_file_handler, next, sub, ready, output reg[1:0] sel_mult1, sel_sum1);
	reg[3:0] idle=0, starting=1, init=2, w1x1=3, w2x2=4, add_yin=5, ax1=6, answer_check=7, w1_update=8, w2_update=9, b_update=10, nextln=11, nextln2=12, init_fh=13; 
	reg[3:0] ps, ns;
	
	reg[2:0] sel_mult1_alpha=0, sel_mult1_w1=1, sel_mult1_w2=2;
	reg[1:0] sel_mult2_x1=0, sel_mult2_x2=1;
	reg[2:0] sel_sum1_b=0, sel_sum1_w1=1, sel_sum1_w2=2, sel_sum1_yin=3;
	reg[1:0] sel_sum2_alpha=0, sel_sum2_tmp=1;
	reg[1:0] sel_yin_b=0, sel_yin_sum=1;

	always @(posedge clk, posedge rst) begin
		if(rst) ps <= idle;
		else ps <= ns;
	end

	// SET NS
	always @(ps, equal, flag_change, EOF, start, t1) begin
		ns = idle;
		case(ps)
			idle: begin
				ns = start?starting:idle; 
			end
			starting: begin
				ns = start?starting:init;
			end
			init: begin
				ns = w1x1;
			end
			w1x1: begin
				ns = w2x2;
			end
			w2x2: begin
				ns = add_yin;
			end
			add_yin: begin
				ns = ax1;
			end
			ax1: begin
				ns = answer_check;
			end
			answer_check: begin
				ns = equal?nextln:w1_update;
			end
			//---------------------<Update>
			w1_update: begin
				ns = w2_update;
			end
			w2_update: begin 
				ns = b_update;
			end
			b_update: begin 
				ns = nextln;
			end
			//---------------------</Update>
			nextln: begin 
				ns = nextln2;
			end
			nextln2: begin
				if(EOF) begin
					ns = flag_change?init:idle;
				end else begin
					ns=w1x1;
				end
			end
			default: ns = idle;
		endcase	
	end
	
	// SET CONTROL SIGNALS
	always @(ps, equal, flag_change, EOF, start, t1) begin
		{ld_b, ld_tmp, ld_w1, ld_w2, ld_yin, rst_flag, set_flag, sel_yin, sel_mult1, sel_mult2, sel_sum1, sel_sum2, init_all_reg, init_file_handler, next, sub, ready} = 0;
		case(ps)
			idle: begin
				ready = 1;
				rst_flag = 1;
			end
			starting: begin
				init_all_reg = 1;
			end
			init: begin
				init_file_handler = 1;
				rst_flag = 1;
			end
			w1x1: begin
				sel_mult1 = sel_mult1_w1;
				sel_mult2 = sel_mult2_x1;
				sel_yin = sel_yin_b;
				ld_yin = 1;
				ld_tmp = 1;
			end
			w2x2: begin
				sel_mult1 = sel_mult1_w2;
				sel_mult2 = sel_mult2_x2;
				sel_sum1 = sel_sum1_yin;
				sel_sum2 = sel_sum2_tmp;
				sel_yin = sel_yin_sum;
				ld_yin = 1; 
				ld_tmp = 1;
			end
			add_yin: begin
				sel_sum1 = sel_sum1_yin;
				sel_sum2 = sel_sum2_tmp;
				sel_yin = sel_yin_sum;
				ld_yin = 1;
			end
			ax1: begin
				sel_mult1 = sel_mult1_alpha;
				sel_mult2 = sel_mult2_x1;
				ld_tmp = 1;
			end
			answer_check: begin
				
			end
			//---------------------<Update>
			w1_update: begin
				set_flag = 1;
				sel_mult1 = sel_mult1_alpha;
				sel_mult2 = sel_mult2_x2;
				sel_sum1 = sel_sum1_w1;
				sel_sum2 = sel_sum2_tmp;
				ld_w1 = 1;
				ld_tmp = 1;
				sub = t1;
			end
			w2_update: begin 
				sel_sum1 = sel_sum1_w2;
				sel_sum2 = sel_sum2_tmp;
				ld_w2 = 1;
				sub = t1;
			end
			b_update: begin 
				sel_sum1 = sel_sum1_b;
				sel_sum2 = sel_sum2_alpha;
				sub = t1;
				ld_b = 1;
			end
			//---------------------</Update>
			nextln: begin 
				next = 1;
			end
			nextln2: begin
				
			end
			default: {ld_b, ld_tmp, ld_w1, ld_w2, rst_flag, set_flag, sel_yin, sel_mult1, sel_mult2, sel_sum1, sel_sum2, init_all_reg, init_file_handler, next, sub, ready} = 0;
		endcase	
	end
	
endmodule
