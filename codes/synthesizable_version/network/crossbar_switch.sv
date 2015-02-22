//`include "valid_tester.sv"
//`include "direction_analyzer.sv"
//`include "output_data_logic.sv"
//`include "header_body_logic.sv"
//`include "header_body_record.sv"
//`include "comparator_4_bit.sv"
//`include "com_dir_logic.sv"
//`include "mux_2_1.sv"
module crossbar_switch #(parameter ROUTER_ID = 0)(
	input clk, rst,
	input [16 : 0] north_data_i,east_data_i,west_data_i,south_data_i,local_data_i,
	input [4 : 0] filter_i,
	input arb_i,
	input [14:0] credit_all_i,
	output logic[16 : 0]north_data_o,east_data_o,west_data_o,south_data_o,local_data_o,
	output logic[5 : 0] north_dir_o,east_dir_o,west_dir_o,south_dir_o,local_dir_o,
	output logic[4 : 0] send_data_o,
	output logic [4 : 0] counter_minus_o,
	output logic [4 : 0] is_body_o
);
	
	logic [16 : 0] data1, data2, data3, data4, data5;
	logic valid1, valid2, valid3, valid4, valid5;
	logic [5 : 0] dir1,dir2, dir3, dir4, dir5;
	logic [5 : 0] dir_north, dir_east, dir_west, dir_south, dir_local;
	logic [2 : 0] hb_count1, hb_count2, hb_count3, hb_count4, hb_count5;
	logic [5 : 0] hb_r_l1, hb_r_l2, hb_r_l3, hb_r_l4, hb_r_l5;
	logic [5 : 0] hb_l_r1, hb_l_r2, hb_l_r3, hb_l_r4, hb_l_r5;
	logic hb_add1, hb_add2, hb_add3, hb_add4, hb_add5;
	logic [4 : 0] is_body;
	valid_tester valid_tester_north(
	.data_i(north_data_i),
	.data_o(data1),
	.valid_o(valid1)
	);
	valid_tester valid_tester_east(
	.data_i(east_data_i),
	.data_o(data2),
	.valid_o(valid2)
	);
	valid_tester valid_tester_west(
	.data_i(west_data_i),
	.data_o(data3),
	.valid_o(valid3)
	);
	valid_tester valid_tester_south(
	.data_i(south_data_i),
	.data_o(data4),
	.valid_o(valid4)
	);
	valid_tester valid_tester_local(
	.data_i(local_data_i),
	.data_o(data5),
	.valid_o(valid5)
	);

	direction_analyzer #(.ROUTER_ID(ROUTER_ID))
		direction_analyzer_north(	
			.data_i(data1),
			.valid_i(valid1),
			.direction_o(dir1)
		);
	direction_analyzer #(.ROUTER_ID(ROUTER_ID))
		direction_analyzer_east(	
			.data_i(data2),
			.valid_i(valid2),
			.direction_o(dir2)
		);
	direction_analyzer #(.ROUTER_ID(ROUTER_ID))
		direction_analyzer_west(	
			.data_i(data3),
			.valid_i(valid3),
			.direction_o(dir3)
		);
	direction_analyzer #(.ROUTER_ID(ROUTER_ID))
		direction_analyzer_south(	
			.data_i(data4),
			.valid_i(valid4),
			.direction_o(dir4)
		);
	direction_analyzer #(.ROUTER_ID(ROUTER_ID))
		direction_analyzer_local(	
			.data_i(data5),
			.valid_i(valid5),
			.direction_o(dir5)
		);
	
	header_body_logic hb_logic_north(
		.dir_i(dir1),
		.dir_record_i(hb_r_l1),
		.count_i(hb_count1),
		.dir_o(dir_north),
		.dir_record_o(hb_l_r1),
		.add_o(hb_add1),
		.is_body_o(is_body[4])
	);
	header_body_logic hb_logic_east(
		.dir_i(dir2),
		.dir_record_i(hb_r_l2),
		.count_i(hb_count2),
		.dir_o(dir_east),
		.dir_record_o(hb_l_r2),
		.add_o(hb_add2),
		.is_body_o(is_body[3])
	);
	header_body_logic hb_logic_west(
		.dir_i(dir3),
		.dir_record_i(hb_r_l3),
		.count_i(hb_count3),
		.dir_o(dir_west),
		.dir_record_o(hb_l_r3),
		.add_o(hb_add3),
		.is_body_o(is_body[2])
	);
	header_body_logic hb_logic_south(
		.dir_i(dir4),
		.dir_record_i(hb_r_l4),
		.count_i(hb_count4),
		.dir_o(dir_south),
		.dir_record_o(hb_l_r4),
		.add_o(hb_add4),
		.is_body_o(is_body[1])
	);
	header_body_logic hb_logic_local(
		.dir_i(dir5),
		.dir_record_i(hb_r_l5),
		.count_i(hb_count5),
		.dir_o(dir_local),
		.dir_record_o(hb_l_r5),
		.add_o(hb_add5),
		.is_body_o(is_body[0])
	);
	
	header_body_record hb_record_north(
		.clk(clk),
		.rst(rst),
		.add_i(hb_add1),
		.new_data_i(send_data_o[4]),
		.dir_i(hb_l_r1),
		.dir_o(hb_r_l1),
		.count_o(hb_count1)
	);
	header_body_record hb_record_east(
		.clk(clk),
		.rst(rst),
		.add_i(hb_add2),
		.new_data_i(send_data_o[3]),
		.dir_i(hb_l_r2),
		.dir_o(hb_r_l2),
		.count_o(hb_count2)
	);
	header_body_record hb_record_west(
		.clk(clk),
		.rst(rst),
		.add_i(hb_add3),
		.new_data_i(send_data_o[2]),
		.dir_i(hb_l_r3),
		.dir_o(hb_r_l3),
		.count_o(hb_count3)
	);
	header_body_record hb_record_south(
		.clk(clk),
		.rst(rst),
		.add_i(hb_add4),
		.new_data_i(send_data_o[1]),
		.dir_i(hb_l_r4),
		.dir_o(hb_r_l4),
		.count_o(hb_count4)
	);
	header_body_record hb_record_local(
		.clk(clk),
		.rst(rst),
		.add_i(hb_add5),
		.new_data_i(send_data_o[0]),
		.dir_i(hb_l_r5),
		.dir_o(hb_r_l5),
		.count_o(hb_count5)
	);
	
	output_data_logic output_data_logic_instance(
		.north_data_i(north_data_i),
		.east_data_i(east_data_i),
		.west_data_i(west_data_i),
		.south_data_i(south_data_i),
		.local_data_i(local_data_i), 
		.arb_i(arb_i),
		.filter_i(filter_i),
		.north_dir_i(dir_north), 
		.east_dir_i(dir_east),
		.west_dir_i(dir_west), 
		.south_dir_i(dir_south), 
		.local_dir_i(dir_local),
		.credit_all_i(credit_all_i),
		.north_data_o(north_data_o), 
		.east_data_o(east_data_o), 
		.west_data_o(west_data_o), 
		.south_data_o(south_data_o), 
		.local_data_o(local_data_o), 
		.send_data_o(send_data_o),
		.counter_minus_o(counter_minus_o)
		);
	assign north_dir_o = dir_north;
	assign east_dir_o = dir_east;
	assign west_dir_o = dir_west;
	assign south_dir_o = dir_south;
	assign local_dir_o = dir_local;
	assign is_body_o = is_body;
endmodule
