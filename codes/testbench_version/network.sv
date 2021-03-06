`include "network/FF.sv"
`include "network/arbiter_logic.sv"
`include "network/arbiter.sv"
`include "network/buffer_storage.sv"
`include "network/chooser.sv"
`include "network/com_dir_logic.sv"
`include "network/comparator_4_bit.sv"
`include "network/counter.sv"
`include "network/crossbar_switch.sv"
`include "network/direction_analyzer.sv"
`include "network/header_body_logic.sv"
`include "network/header_body_record.sv"
`include "network/input_buffer.sv"
`include "network/interface.sv"
`include "network/mux_2_1.sv"
`include "network/mux_4_1.sv"
`include "network/output_data_logic.sv"
`include "network/priority_decoder.sv"
`include "network/register.sv"
`include "network/router.sv"
`include "network/router_0.sv"
`include "network/router_1_2.sv"
`include "network/router_3.sv"
`include "network/router_4_8.sv"
`include "network/router_7_11.sv"
`include "network/router_12.sv"
`include "network/router_13_14.sv"
`include "network/router_15.sv"
`include "network/valid_tester.sv"

module network (
	ifc.dut ifc
);
	logic [16 : 0] data_0_4, data_4_8, data_8_12, data_1_5, data_5_9, data_9_13, data_2_6, data_6_10, data_10_14, data_3_7, data_7_11, data_11_15, data_0_1, data_1_2, data_2_3, data_4_5, data_5_6, data_6_7, data_8_9, data_9_10, data_10_11, data_12_13, data_13_14, data_14_15; //the two numbers after data mean the two endpoint routers of a data wire
	logic [16 : 0] data_4_0, data_8_4, data_12_8, data_5_1, data_9_5, data_13_9, data_6_2, data_10_6, data_14_10, data_7_3, data_11_7, data_15_11, data_1_0, data_2_1, data_3_2, data_5_4, data_6_5, data_7_6, data_9_8, data_10_9, data_11_10, data_13_12, data_14_13, data_15_14; //the two numbers after data mean the two endpoint routers of a data wire
	logic  signal_0_4, signal_4_8, signal_8_12, signal_1_5, signal_5_9, signal_9_13, signal_2_6, signal_6_10, signal_10_14, signal_3_7, signal_7_11, signal_11_15, signal_0_1, signal_1_2, signal_2_3, signal_4_5, signal_5_6, signal_6_7, signal_8_9, signal_9_10, signal_10_11, signal_12_13, signal_13_14, signal_14_15; //the two numbers after data mean the two endpoint routers of a signal wire to tell neighbor router a flit is consumed
	logic  signal_4_0, signal_8_4, signal_12_8, signal_5_1, signal_9_5, signal_13_9, signal_6_2, signal_10_6, signal_14_10, signal_7_3, signal_11_7, signal_15_11, signal_1_0, signal_2_1, signal_3_2, signal_5_4, signal_6_5, signal_7_6, signal_9_8, signal_10_9, signal_11_10, signal_13_12, signal_14_13, signal_15_14; //the two numbers after data mean the two endpoint routers of a signal wire to tell neighbor router a flit is consumed

	router_0 #(.ROUTER_ID(0))
		r0(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.east_data_i(data_1_0),
		.south_data_i(data_4_0),
		.local_data_i(ifc.data_0_i),
		.consume_all_i({1'b0, signal_1_0, 1'b0, signal_4_0}),
		.send_data_o({signal_0_1, signal_0_4}),
		.east_data_o(data_0_1),
		.south_data_o(data_0_4),
		.local_data_o(ifc.data_0_o),
		.local_full_o(ifc.local_full[0])
		);
	router_1_2 #(.ROUTER_ID(1))
		r1(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.east_data_i(data_2_1),
		.west_data_i(data_0_1),
		.south_data_i(data_5_1),
		.local_data_i(ifc.data_1_i),
		.consume_all_i({1'b0, signal_2_1, signal_0_1, signal_5_1}),
		.send_data_o({signal_1_2, signal_1_0, signal_1_5}),
		.east_data_o(data_1_2),
		.west_data_o(data_1_0),
		.south_data_o(data_1_5),
		.local_data_o(ifc.data_1_o),
		.local_full_o(ifc.local_full[1])
		);
	router_1_2 #(.ROUTER_ID(2))
		r2(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.east_data_i(data_3_2),
		.west_data_i(data_1_2),
		.south_data_i(data_6_2),
		.local_data_i(ifc.data_2_i),
		.consume_all_i({1'b0, signal_3_2, signal_1_2, signal_6_2}),
		.send_data_o({signal_2_3, signal_2_1, signal_2_6}),
		.east_data_o(data_2_3),
		.west_data_o(data_2_1),
		.south_data_o(data_2_6),
		.local_data_o(ifc.data_2_o),
		.local_full_o(ifc.local_full[2])
		);
	router_3 #(.ROUTER_ID(3))
		r3(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.west_data_i(data_2_3),
		.south_data_i(data_7_3),
		.local_data_i(ifc.data_3_i),
		.consume_all_i({1'b0, 1'b0, signal_2_3, signal_7_3}),
		.send_data_o({signal_3_2, signal_3_7}),
		.west_data_o(data_3_2),
		.south_data_o(data_3_7),
		.local_data_o(ifc.data_3_o),
		.local_full_o(ifc.local_full[3])
		);
	router_4_8 #(.ROUTER_ID(4))
		r4(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_0_4),
		.east_data_i(data_5_4),
		.south_data_i(data_8_4),
		.local_data_i(ifc.data_4_i),
		.consume_all_i({signal_0_4, signal_5_4, 1'b0, signal_8_4}),
		.send_data_o({signal_4_0, signal_4_5, signal_4_8}),
		.north_data_o(data_4_0),
		.east_data_o(data_4_5),
		.south_data_o(data_4_8),
		.local_data_o(ifc.data_4_o),
		.local_full_o(ifc.local_full[4])
		);
	router #(.ROUTER_ID(5))
		r5(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_1_5),
		.east_data_i(data_6_5),
		.west_data_i(data_4_5),
		.south_data_i(data_9_5),
		.local_data_i(ifc.data_5_i),
		.consume_all_i({signal_1_5, signal_6_5,signal_4_5, signal_9_5}),
		.send_data_o({signal_5_1, signal_5_6, signal_5_4, signal_5_9}),
		.north_data_o(data_5_1),
		.east_data_o(data_5_6),
		.west_data_o(data_5_4),
		.south_data_o(data_5_9),
		.local_data_o(ifc.data_5_o),
		.local_full_o(ifc.local_full[5])
		);
	router #(.ROUTER_ID(6))
		r6(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_2_6),
		.east_data_i(data_7_6),
		.west_data_i(data_5_6),
		.south_data_i(data_10_6),
		.local_data_i(ifc.data_6_i),
		.consume_all_i({signal_2_6, signal_7_6, signal_5_6, signal_10_6}),
		.send_data_o({signal_6_2, signal_6_7, signal_6_5, signal_6_10}),
		.north_data_o(data_6_2),
		.east_data_o(data_6_7),
		.west_data_o(data_6_5),
		.south_data_o(data_6_10),
		.local_data_o(ifc.data_6_o),
		.local_full_o(ifc.local_full[6])
		);
	router_7_11 #(.ROUTER_ID(7))
		r7(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_3_7),
		.west_data_i(data_6_7),
		.south_data_i(data_11_7),
		.local_data_i(ifc.data_7_i),
		.consume_all_i({signal_3_7, 1'b0, signal_6_7, signal_11_7}),
		.send_data_o({signal_7_3, signal_7_6, signal_7_11}),
		.north_data_o(data_7_3),
		.west_data_o(data_7_6),
		.south_data_o(data_7_11),
		.local_data_o(ifc.data_7_o),
		.local_full_o(ifc.local_full[7])
		);
	router_4_8 #(.ROUTER_ID(8))
		r8(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_4_8),
		.east_data_i(data_9_8),
		.south_data_i(data_12_8),
		.local_data_i(ifc.data_8_i),
		.consume_all_i({signal_4_8, signal_9_8, 1'b0, signal_12_8}),
		.send_data_o({signal_8_4, signal_8_9, signal_8_12}),
		.north_data_o(data_8_4),
		.east_data_o(data_8_9),
		.south_data_o(data_8_12),
		.local_data_o(ifc.data_8_o),
		.local_full_o(ifc.local_full[8])
		);
	router #(.ROUTER_ID(9))
		r9(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_5_9),
		.east_data_i(data_10_9),
		.west_data_i(data_8_9),
		.south_data_i(data_13_9),
		.local_data_i(ifc.data_9_i),
		.consume_all_i({signal_5_9, signal_10_9, signal_8_9, signal_13_9}),
		.send_data_o({signal_9_5, signal_9_10, signal_9_8, signal_9_13}),
		.north_data_o(data_9_5),
		.east_data_o(data_9_10),
		.west_data_o(data_9_8),
		.south_data_o(data_9_13),
		.local_data_o(ifc.data_9_o),
		.local_full_o(ifc.local_full[9])
		);
	router #(.ROUTER_ID(10))
		r10(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_6_10),
		.east_data_i(data_11_10),
		.west_data_i(data_9_10),
		.south_data_i(data_14_10),
		.local_data_i(ifc.data_10_i),
		.consume_all_i({signal_6_10, signal_11_10, signal_9_10, signal_14_10}),
		.send_data_o({signal_10_6, signal_10_11, signal_10_9, signal_10_14}),
		.north_data_o(data_10_6),
		.east_data_o(data_10_11),
		.west_data_o(data_10_9),
		.south_data_o(data_10_14),
		.local_data_o(ifc.data_10_o),
		.local_full_o(ifc.local_full[10])
		);
	router_7_11 #(.ROUTER_ID(11))
		r11(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_7_11),
		.west_data_i(data_10_11),
		.south_data_i(data_15_11),
		.local_data_i(ifc.data_11_i),
		.consume_all_i({signal_7_11, 1'b0, signal_10_11, signal_15_11}),
		.send_data_o({signal_11_7, signal_11_10, signal_11_15}),
		.north_data_o(data_11_7),
		.west_data_o(data_11_10),
		.south_data_o(data_11_15),
		.local_data_o(ifc.data_11_o),
		.local_full_o(ifc.local_full[11])
		);
	router_12 #(.ROUTER_ID(12))
		r12(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_8_12),
		.east_data_i(data_13_12),
		.local_data_i(ifc.data_12_i),
		.consume_all_i({signal_8_12, signal_13_12, 1'b0, 1'b0}),
		.send_data_o({signal_12_8, signal_12_13}),
		.north_data_o(data_12_8),
		.east_data_o(data_12_13),
		.local_data_o(ifc.data_12_o),
		.local_full_o(ifc.local_full[12])
		);
	router_13_14 #(.ROUTER_ID(13))
		r13(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_9_13),
		.east_data_i(data_14_13),
		.west_data_i(data_12_13),
		.local_data_i(ifc.data_13_i),
		.consume_all_i({signal_9_13, signal_14_13, signal_12_13, 1'b0}),
		.send_data_o({signal_13_9, signal_13_14, signal_13_12}),
		.north_data_o(data_13_9),
		.east_data_o(data_13_14),
		.west_data_o(data_13_12),
		.local_data_o(ifc.data_13_o),
		.local_full_o(ifc.local_full[13])
		);
	router_13_14 #(.ROUTER_ID(14))
		r14(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_10_14),
		.east_data_i(data_15_14),
		.west_data_i(data_13_14),
		.local_data_i(ifc.data_14_i),
		.consume_all_i({signal_10_14, signal_15_14, signal_13_14, 1'b0}),
		.send_data_o({signal_14_10, signal_14_15, signal_14_13}),
		.north_data_o(data_14_10),
		.east_data_o(data_14_15),
		.west_data_o(data_14_13),
		.local_data_o(ifc.data_14_o),
		.local_full_o(ifc.local_full[14])
		);
	router_15 #(.ROUTER_ID(15))
		r15(
		.clk(ifc.clk),
		.rst(ifc.rst),
		.north_data_i(data_11_15),
		.west_data_i(data_14_15),
		.local_data_i(ifc.data_15_i),
		.consume_all_i({signal_11_15, 1'b0, signal_14_15, 1'b0}),
		.send_data_o({signal_15_11, signal_15_14}),
		.north_data_o(data_15_11),
		.west_data_o(data_15_14),
		.local_data_o(ifc.data_15_o),
		.local_full_o(ifc.local_full[15])
		);
endmodule

