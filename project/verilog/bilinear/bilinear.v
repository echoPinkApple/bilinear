module bilinear(input clk,
				input start,
			  output [7:0]doutb
    );
parameter [7:0]src_width = 'd100;
wire [9:0]coordinate_x;
wire [9:0]coordinate_y;
//wire start;
wire en_b;
//////////////////
wire [9:0]coefficient1;
wire [9:0]coefficient2;
wire [9:0]coefficient3;
wire [9:0]coefficient4;
wire [7:0]doutbx;
wire [7:0]doutbx1;
wire [7:0]doutby;
wire [7:0]doutby1;
// Instantiate the module
coordinate_trans coordinate (
    .clk(clk), 
    .src_width(src_width), 
    .start(start), 
    .coordinate_x(coordinate_x), 
    .coordinate_y(coordinate_y), 
    .coefficient1(coefficient1), 
    .coefficient2(coefficient2), 
    .coefficient3(coefficient3), 
    .coefficient4(coefficient4),
	 .en(en_b)
    );
//////////////////
wire [7:0]dina;
wire valid_zsc;

mem_control mem_control(
.clk(clk),
.coordinate_x(coordinate_x), /////////
.coordinate_y(coordinate_y), ////////////
.src_width(src_width), //////////////
.doutbx(doutbx), 
.doutbx1(doutbx1), 
.doutby(doutby), 
.doutby1(doutby1)
);



wire [7:0] data_o;
wire en_o;
// Instantiate the module
bilinear_cal bilinear_unit (
    .clk(clk), 
    .coefficient1(coefficient1), 
    .coefficient2(coefficient2), 
    .coefficient3(coefficient3), 
    .coefficient4(coefficient4), 
    .en_b(en_b), 
    .doutbx(doutbx), 
    .doutbx1(doutbx1), 
    .doutby(doutby), 
    .doutby1(doutby1), 
    .data_o(doutb),
	 .en_o(en_o)
    );

endmodule