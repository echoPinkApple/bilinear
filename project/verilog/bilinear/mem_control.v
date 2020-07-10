//内存管理单元，管理从RAM中读取图像数据
module mem_control(input clk,
						 input [9:0]coordinate_x,
						 input [9:0]coordinate_y,
			
						 input [7:0]src_width,
						 
						 output wire[7:0]doutbx,
						 output wire[7:0]doutbx1,
						 output wire[7:0]doutby,
						 output wire[7:0]doutby1
    );
	
wire [15:0]address_bx;
wire [15:0]address_bx1;
wire [15:0]address_by;
wire [15:0]address_by1;
wire [7:0]width;
assign width = src_width - 'd1;



assign address_bx = (coordinate_x == width)?coordinate_x + coordinate_y*src_width - 'd1:coordinate_x + coordinate_y*src_width;
assign address_bx1 = (coordinate_x == width)?address_bx:address_bx + 'd1;
assign address_by = (coordinate_y==width)?address_bx:coordinate_x + (coordinate_y+'d1)*src_width;
assign address_by1 = (coordinate_x == width)?address_by:address_by + 'd1;

wire[7:0] data=8'd0;
wire wren=1'b0;
//这其实相当于一个ROM，数据已经加载进RAM，wren一直为0，不允许写入
ram_control ram_1(
.address(address_bx),
	.clock(clk),
	.data(data),
	.wren(wren),
	.q(doutbx)
);


ram_control ram_2(
.address(address_bx1),
	.clock(clk),
	.data(data),
	.wren(wren),
	.q(doutbx1)
);
 
 ram_control ram_3(
.address(address_by),
	.clock(clk),
	.data(data),
	.wren(wren),
	.q(doutby)
);

ram_control ram_4(
.address(address_by1),
	.clock(clk),
	.data(data),
	.wren(wren),
	.q(doutby1)
);
 
endmodule