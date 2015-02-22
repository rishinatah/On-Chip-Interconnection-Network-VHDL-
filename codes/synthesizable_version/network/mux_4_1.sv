//`include "mux_2_1.sv"

module mux_4_1 #(parameter DATA_WIDTH = 17)(
	input [1 : 0] control,
	input [DATA_WIDTH-1 : 0] data1_i,
	input [DATA_WIDTH-1 : 0] data2_i,
	input [DATA_WIDTH-1 : 0] data3_i,
	input [DATA_WIDTH-1 : 0] data4_i,
	output [DATA_WIDTH-1 : 0]	data_o
);
	logic [DATA_WIDTH-1 : 0] data, d1, d2;
	mux_2_1 #(.DATA_WIDTH(DATA_WIDTH))
		mux1 (
			.control(control[0]),
			.data1_i(data1_i),
			.data2_i(data2_i),
			.data_o(d1)	
		);
	mux_2_1 #(.DATA_WIDTH(DATA_WIDTH))
		mux2 (
			.control(control[0]),
			.data1_i(data3_i),
			.data2_i(data4_i),
			.data_o(d2)	
		);
	mux_2_1 #(.DATA_WIDTH(DATA_WIDTH))
		mux3 (
			.control(control[1]),
			.data1_i(d1),
			.data2_i(d2),
			.data_o(data)	
		);
		
	assign data_o = data;
	
endmodule
