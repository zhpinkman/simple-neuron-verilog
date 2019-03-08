

module read_file(input clk, rst, init, next, output [6:0] X1, X2, output [1:0] T,output reg EOF);
integer               data_file    ; // file handler
integer               scan_file    ; // file handler

reg [6:0] a, b;
reg [1:0] c;

assign X1 = a;
assign X2 = b;
assign T = c;

initial begin
  data_file = $fopen("data_set.txt", "r");
  EOF = 1'b0;
  if (data_file == 1) begin
    $display("data_file handle was NULL");
    $finish;
  end
end

always @(posedge clk) begin
  if(rst | init) begin
    $fclose(data_file);
    data_file = $fopen("data_set.txt", "r");
    scan_file = $fscanf(data_file, "%b %b %b\n", a, b, c); 
    EOF = 1'b0;
  end
  else if(next) begin
    if(!$feof(data_file)) begin
      EOF = 1'b0;
      scan_file = $fscanf(data_file, "%b %b %b\n", a, b, c); 
    end
    else EOF = 1'b1;
  end
end 

endmodule 

module TB();
  reg clk = 1'b0;
  reg rst=0, init=0 ,next=0;
  wire EOF;
  wire [6:0] a, b;
  wire [1:0] c;
  read_file uut(clk, rst, init, next, a, b, c,EOF );
  initial begin
    init = 1;
    #100;
    init = 0;
    repeat(10) begin
      next = 1; #10; 
    end
    init = 1;
    #20;
    init = 0;
    repeat(1000) begin
      next = 1; #10; 
    end
    
    #200000;
    $stop;
  end
  always #10 clk = ~clk;
  
endmodule

