//`include "mux_2_1.sv"
module valid_tester (

	input [16 : 0] data_i,
	output[16 : 0] data_o,
	output valid_o
);
	logic [16 : 0] data;
	logic valid;
	
	always_comb begin
		if (data_i[16]) begin
			valid = 1;
		end else begin
			valid = 0;
		end
	end
	
	mux_2_1 #(.DATA_WIDTH(17)) 
		data_valid (
		.control(valid),
		.data1_i(17'b0),
		.data2_i(data_i),
		.data_o(data)
	);	

	assign data_o = data;
	assign valid_o = valid;

endmodule

