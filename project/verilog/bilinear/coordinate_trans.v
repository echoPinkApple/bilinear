//计算虚拟坐标
//实现从100*100到256*256的变换
module coordinate_trans(input clk,
									 input [7:0]src_width,/////src_width = src_height
									 input start,
									 output [9:0]coordinate_x,
									 output [9:0]coordinate_y,
									 output [9:0]coefficient1,
									 output [9:0]coefficient2,
									 output [9:0]coefficient3,
									 output [9:0]coefficient4,
									 output reg en = 'd0
												 
    );
/////////////////高电平有效rst
reg [1:0]cnt = 'd0;
always @(posedge clk)
	if(cnt == 'd3)
		cnt <= 'd3;
	else
		cnt <= cnt + 'd1;
reg rst = 'd1;
always @(posedge clk)
	if(cnt == 'd3)
		rst <= 'd0;
	else
		rst <= 'd1;
//有限状态机实现一帧图像处理完毕才处理下一帧
//////////////////////
localparam [1:0]IDLE = 2'b01;
localparam [1:0]START = 2'b10;
/////////////
reg[1:0]next_state = 'd0;
reg[1:0]current_state = 'd0;
always @(posedge clk)
	if(rst)////////////////////////高电平复位
		current_state <= IDLE;
	else
		current_state <= next_state;
//////////////////
reg finish = 'd0;
always @(*)
	case(current_state)	
		IDLE:	begin
			if(start)
				next_state = START;
			else
				next_state = IDLE;
		end
		START:	begin
			if(finish)
				next_state = IDLE;
			else
				next_state = START;
		end
		default:	next_state = IDLE;
	endcase	
//////////////////////////
always @(*)
		case(current_state)
			IDLE:	begin
				en = 'd0;
			end
			START:	begin
				en = 'd1;
			end
			default:	en = 'd0;
		endcase
///////////////////////////对目的图像坐标进行计数
reg[9:0] pos_x = 'd0;/////列计数
always@(posedge clk)
	if(en)	begin
		if(pos_x == 'd255)
			pos_x <= 'd0;
		else
			pos_x <= pos_x + 'd1;
	end
	else
		pos_x <= pos_x;
reg[9:0] pos_y = 'd0;////行计数
always @(posedge clk)
	if(pos_x == 'd255)
		pos_y <= pos_y + 'd1; 
	else
		pos_y <= pos_y;
//////////////////////结束标志
always@(posedge clk)
	if((pos_x == 'd254)&&(pos_y == 'd255))
		finish <= 'd1;
	else
		finish <= 'd0;
//////////////////////通过pos_x、pos_y可以计算对应源图像位置的虚拟坐标
reg [19:0]src_x = 'd0;///////高11位表示整数，低9位表示小数
reg [19:0]src_y = 'd0;
wire [9:0]pos_xq;
wire [9:0]pos_yq;
assign pos_xq = pos_x<<1;//乘2
assign pos_yq = pos_y<<1;
///////////
//根据公式计算源坐标
always @(posedge clk)
	if(pos_x == 'd0)	begin
		if(src_width > 'd256)
			src_x <= src_width - 'd256;
		else
			src_x <= 'd256 - src_width;
	end
	else 	begin
		if((pos_xq + 'd1)*src_width > 'd256)
			src_x <= (pos_xq + 'd1)*src_width - 'd256;
		else
			src_x <= 'd256 - (pos_xq + 'd1)*src_width;
	end
 
always @(posedge clk)
	if(pos_y == 'd0)	begin
		if(src_width > 'd256)
			src_y <= src_width - 'd256;
		else
			src_y <= 'd256 - src_width;
	end
	else 	begin
		if((pos_yq + 'd1)*src_width > 'd256)
			src_y <= (pos_yq + 'd1)*src_width - 'd256;
		else 
			src_y <= 'd256 - (pos_yq + 'd1)*src_width;
	end
//高11位为整数部分
assign coordinate_x = src_x[18:9];
assign coordinate_y = src_y[18:9];
//////////////////生成对应系数 
//低9位表示小数
assign coefficient2 = {1'b0,src_x[8:0]};
assign coefficient1 = 'd512 - coefficient2;
assign coefficient4 = {1'b0,src_y[8:0]};
assign coefficient3 = 'd512 - coefficient4;
endmodule