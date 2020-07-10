//双线性变换单元，
module bilinear_cal(input clk,
							  input [9:0]coefficient1,
							  input [9:0]coefficient2,
							  input [9:0]coefficient3,
							  input [9:0]coefficient4,
							  input en_b,
							  input [7:0]doutbx,
							  input [7:0]doutbx1,
							  input [7:0]doutby,
							  input [7:0]doutby1,
							  output reg[7:0]data_o = 'd0,
							  output reg en_o = 'd0
    );
wire [27:0]data_1;
wire [27:0]data_2;
wire [27:0]data_3; 
wire [27:0]data_4;	
assign data_1 = coefficient1*coefficient3*doutbx;
/////
assign data_2 = coefficient2*coefficient3*doutbx1;
/////	
assign data_3 = coefficient1*coefficient4*doutby;
////
assign data_4 = coefficient2*coefficient4*doutby1;
 
wire [27:0]data_a;
assign data_a = data_1 + data_2;
reg [27:0]data_aq = 'd0;
always @(posedge clk)
	data_aq <= data_a;
wire [27:0]data_b;
assign data_b = data_3 + data_4;
reg [27:0]data_bq = 'd0;
always @(posedge clk)
	data_bq <= data_b;
wire [27:0]data_oq;
assign data_oq = data_aq + data_bq;
always @(posedge clk)
	data_o <= data_oq[25:18];////////高8位为运算后的数据，因为系数扩大了9*9倍
//////en_b
reg en_b_q;
reg en_b_q1;
always@(posedge clk)	begin
	en_b_q <= en_b;
	en_b_q1 <= en_b_q;
	en_o <= en_b_q1;
end
	
endmodule