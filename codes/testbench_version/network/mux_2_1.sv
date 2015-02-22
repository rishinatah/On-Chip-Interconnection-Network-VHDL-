

module mux_2_1 #(parameter DATA_WIDTH = 17)(
	input control,
	input [DATA_WIDTH-1 : 0] data1_i,
	input [DATA_WIDTH-1 : 0] data2_i,
	output [DATA_WIDTH-1 : 0]	data_o
);
	logic [DATA_WIDTH-1 : 0] data;
	always_comb begin
		if (control) begin
		data = data2_i;
		end
		else begin
			data = data1_i;
		end
	end
	assign data_o = data;
	
endmodule
