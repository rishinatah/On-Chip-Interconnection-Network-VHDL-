// cam interface
interface ifc (
	input bit clk
);
	logic rst;
	logic [16 : 0]	data_0_i, data_1_i, data_2_i, data_3_i, data_4_i, data_5_i, data_6_i, data_7_i, data_8_i, data_9_i, data_10_i, data_11_i, data_12_i, data_13_i, data_14_i, data_15_i; 
	
	logic [16 : 0] data_0_o, data_1_o, data_2_o, data_3_o, data_4_o, data_5_o, data_6_o, data_7_o, data_8_o, data_9_o, data_10_o, data_11_o, data_12_o, data_13_o, data_14_o, data_15_o;

	logic [15 : 0] local_full;
	
	clocking cb @(posedge clk);
		//default input #0 output #0;
		output rst;
		output data_0_i, data_1_i, data_2_i, data_3_i, data_4_i, data_5_i, data_6_i, data_7_i, data_8_i, data_9_i, data_10_i, data_11_i, data_12_i, data_13_i, data_14_i, data_15_i;
		input data_0_o, data_1_o, data_2_o, data_3_o, data_4_o, data_5_o, data_6_o, data_7_o, data_8_o, data_9_o, data_10_o, data_11_o, data_12_o, data_13_o, data_14_o, data_15_o, local_full;
	endclocking

	modport bench (clocking cb);

	modport dut (
		input clk,
		input rst,
		input data_0_i, data_1_i, data_2_i, data_3_i, data_4_i, data_5_i, data_6_i, data_7_i, data_8_i, data_9_i, data_10_i, data_11_i, data_12_i, data_13_i, data_14_i, data_15_i,
		output data_0_o, data_1_o, data_2_o, data_3_o, data_4_o, data_5_o, data_6_o, data_7_o, data_8_o, data_9_o, data_10_o, data_11_o, data_12_o, data_13_o, data_14_o, data_15_o, local_full
	);

endinterface
