//`include "buffer_storage.sv"
//`include "valid_tester.sv"
//`include "register.sv"
//`include "FF.sv"
//`include "priority_decoder.sv"
//`include "mux_4_1.sv"
//`include "mux_2_1.sv"
module input_buffer (

	input clk,
	input rst,
	input [16 : 0] data_i,
	input data_send_i,
	output logic [16 : 0] data_o
);
	
	logic [16 : 0] data;
	logic valid;
	valid_tester valid_tester_instance(
	.data_i(data_i),
	.data_o(data),
	.valid_o(valid)
	);

	buffer_storage buffer_storage_instance(
	.clk(clk),
	.rst(rst),
	.receive_i(valid),
	.send_i(data_send_i),
	.data_i(data), 
	.data_o(data_o)
	);

endmodule

