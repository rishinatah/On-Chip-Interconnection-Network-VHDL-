//`include "register.sv"
//`include "priority_decoder.sv"
//`include "mux_4_1.sv"

//this module implements the storage element
module buffer_storage (clk, rst, receive_i, send_i, data_i, data_o);

	input clk;
	input rst;
	input receive_i;
	input send_i;
	input [16 : 0] data_i;
	output [16 : 0] data_o;

	logic [4 : 0] valid;
	logic [4 : 0] position;
	logic [4 : 0] receive, receive_init;
	logic [4 : 0] send;
	logic [84 : 0] val;
	logic [68 : 0] data_all;
	logic [4 : 0] front_is_valid;
	logic empty;
	logic full;
	logic [4 : 0] position_left;
	priority_decoder position_selector(
	.valid_i(valid), .write_o(position));
	
	assign front_is_valid = valid & ~position;
	assign empty = ~(valid[0] | valid[1] | valid[2] | valid[3] | valid[4]);
	assign full = valid[0] & valid[1] & valid[2] & valid[3] & valid[4];
	assign position_left = ({position[3], position[2], position[1], position[0], empty});
	mux_4_1 #(.DATA_WIDTH(5))
		receive_init_calc (.control({receive_i, send_i}),
			.data1_i(5'b0),
			.data2_i(front_is_valid),
			.data3_i(position_left),
			.data4_i({valid[4], valid[3], valid[2], valid[1], valid[0]|empty}),
			.data_o(receive_init)
		);
	always_comb begin
		receive = (full & ~send_i) ? 5'b00000 : receive_init;
	end
	
	mux_2_1 #(.DATA_WIDTH(5))
		send_calc (.control(send_i),
			.data1_i(5'b0),
			.data2_i(valid),
			.data_o(send)
		);
	
	mux_2_1 #(.DATA_WIDTH(17))
			r1_input (.control(front_is_valid[0]),
			.data1_i(data_i),
			.data2_i(val[33 : 17]),
			.data_o(data_all[16 : 0])
		);
	register #(.DATA_WIDTH(17))
		value1 (
		.clk(clk),
		.rst(rst),
		.receive_i(receive[0]),
		.send_i(send[0]),
		.data_i(data_all[16 : 0]),
		.data_o(val[16 : 0]),
		.valid_o(valid[0])
		);
	
	mux_2_1 #(.DATA_WIDTH(17))
			r2_input (.control(front_is_valid[1]),
			.data1_i(data_i),
			.data2_i(val[50 : 34]),
			.data_o(data_all[33 : 17])
		);
	register #(.DATA_WIDTH(17))
		value2 (
		.clk(clk),
		.rst(rst),
		.receive_i(receive[1]),
		.send_i(send[1]),
		.data_i(data_all[33 : 17]),
		.data_o(val[33 : 17]),
		.valid_o(valid[1])
		);
		
	mux_2_1 #(.DATA_WIDTH(17))
			r3_input (.control(front_is_valid[2]),
			.data1_i(data_i),
			.data2_i(val[67 : 51]),
			.data_o(data_all[50 : 34])
		);
	register #(.DATA_WIDTH(17))
		value3 (
		.clk(clk),
		.rst(rst),
		.receive_i(receive[2]),
		.send_i(send[2]),
		.data_i(data_all[50 : 34]),
		.data_o(val[50 : 34]),
		.valid_o(valid[2])
		);
	
	mux_2_1 #(.DATA_WIDTH(17))
			r4_input (.control(front_is_valid[3]),
			.data1_i(data_i),
			.data2_i(val[84 : 68]),
			.data_o(data_all[67 : 51])
		);
	register #(.DATA_WIDTH(17))
		value4 (
		.clk(clk),
		.rst(rst),
		.receive_i(receive[3]),
		.send_i(send[3]),
		.data_i(data_all[67 : 51]),
		.data_o(val[67 : 51]),
		.valid_o(valid[3])
		);
	
	register #(.DATA_WIDTH(17))
		value5 (
		.clk(clk),
		.rst(rst),
		.receive_i(receive[4]),
		.send_i(send[4]),
		.data_i(data_i),
		.data_o(val[84 : 68]),
		.valid_o(valid[4])
		);
		
	assign data_o = val[16 : 0];	
	
endmodule
