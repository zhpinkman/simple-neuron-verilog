`timescale 1ns/1ns
module wired_TB();
	reg clk=0, rst=0, start=0;
	wire ready;
	wire[1:0] y_sign;
	wire[13:0] b,w1,w2;
	reg r = 0;

	wired my_wired(clk, rst, start,             ready, y_sign, b, w1, w2);


	
	always begin
		#10 clk = ~clk; //50MHz
		
	end

	initial begin
		rst = 1;
	  	#111;
		rst = 0;
	  	#666;
		start = 1; 
		#666;
		start = 0;
		//#10000000 $finish;
		
	end
	always @(posedge ready) begin
		if(r == 1) #10000000 $finish;
		r = 1;
	end

endmodule




