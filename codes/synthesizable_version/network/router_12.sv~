//`include "chooser.sv"
//`include "arbiter_logic.sv"
//`include "register.sv"
//`include "FF.sv"
//`include "priority_decoder.sv"
//`include "mux_4_1.sv"
//`include "mux_2_1.sv"
//`include "valid_tester.sv"
//`include "direction_analyzer.sv"
//`include "output_data_logic.sv"
//`include "header_body_logic.sv"
//`include "header_body_record.sv"
//`include "comparator_4_bit.sv"
//`include "com_dir_logic.sv"
//`include "arbiter.sv"
//`include "input_buffer.sv"
//`include "buffer_storage.sv"
//`include "crossbar_switch.sv"
//`include "counter.sv"

module router_12 #(parameter ROUTER_ID = 12)
(	
	input clk,rst,
	input [16 : 0] north_data_i,east_data_i,local_data_i,
	input [3 : 0] consume_all_i,
	output logic[1 : 0] send_data_o,
	output logic[16 : 0]north_data_o,east_data_o,local_data_o,
	output logic local_full_o
);
	logic [16 : 0] west_data_o, south_data_o;
	logic [4 : 0] send_data;
	logic [4 : 0] counter_minus;
	logic [16 : 0] data1, data2, data3, data4, data5;
	logic [5 : 0] dir1, dir2, dir3, dir4, dir5;
	logic [14 : 0] credit_all;
	logic arb;
	logic [4 : 0] filter;
	logic [4 : 0] is_body;
	input_buffer input_buffer_north(
	.clk(clk),
	.rst(rst),
	.data_i(north_data_i),
	.data_send_i(send_data[4]),
	.data_o(data1)
	);
	input_buffer input_buffer_east(
	.clk(clk),
	.rst(rst),
	.data_i(east_data_i),
	.data_send_i(send_data[3]),
	.data_o(data2)
	);
	input_buffer input_buffer_local(
	.clk(clk),
	.rst(rst),
	.data_i(local_data_i),
	.data_send_i(send_data[0]),
	.data_o(data5)
	);
	
	counter up_counter (
	.clk(clk),
	.rst(rst),
	.up_i(consume_all_i[3]),
	.down_i(counter_minus[4]),
	.value_o(credit_all[14 : 12])
	);
	counter right_counter (
	.clk(clk),
	.rst(rst),
	.up_i(consume_all_i[2]),
	.down_i(counter_minus[3]),
	.value_o(credit_all[11 : 9])
	);
	counter local_counter (
	.clk(clk),
	.rst(rst),
	.up_i(send_data[0]),
	.down_i(local_data_i[16]),
	.value_o(credit_all[2 : 0])
	);
	
	arbiter arbiter_instance(
	.clk(clk), 
	.rst(rst),
	.north_dir_i(dir1), 
	.east_dir_i(dir2), 
	.west_dir_i(dir3), 
	.south_dir_i(dir4), 
	.local_dir_i(dir5),
	.is_body_i(is_body),
	.arb_o(arb),
	.filter_o(filter)
	);

	crossbar_switch #(.ROUTER_ID(ROUTER_ID))
		crossbar_switch_instance(
			.clk(clk),
			.rst(rst),
			.north_data_i(data1),
			.east_data_i(data2),
			.west_data_i(17'b0),
			.south_data_i(17'b0),
			.local_data_i(data5),
			.filter_i(filter),
			.arb_i(arb),
			.credit_all_i(credit_all),
			.north_data_o(north_data_o),
			.east_data_o(east_data_o),
			.west_data_o(west_data_o),
			.south_data_o(south_data_o),
			.local_data_o(local_data_o),
			.north_dir_o(dir1),
			.east_dir_o(dir2),
			.west_dir_o(dir3),
			.south_dir_o(dir4),
			.local_dir_o(dir5),
			.send_data_o(send_data),
			.counter_minus_o(counter_minus),
			.is_body_o(is_body)
			);
	
	assign send_data_o = send_data[4 : 3];
	assign local_full_o = (((credit_all[2 : 0] == 3'b000) & ~(send_data[0] & ~local_data_i[16])) | ((credit_all[2 : 0] == 3'b001) & ~send_data[0] & local_data_i[16]))? 1'b1 : 1'b0;
endmodule
