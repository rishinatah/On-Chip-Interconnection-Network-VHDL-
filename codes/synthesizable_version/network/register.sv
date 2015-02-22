//`include "FF.sv"

module register #(parameter DATA_WIDTH = 17)(

	input clk, 
	input rst, 
	input receive_i,
	input send_i,
	input [DATA_WIDTH-1 : 0] data_i, 
	output logic [DATA_WIDTH-1 : 0] data_o,
	output logic valid_o //indicate whether register has valid data
);
	logic valid;
	logic [DATA_WIDTH-1 : 0] data;
	logic new_rst;
	
	always_comb begin
		new_rst = rst | (~receive_i & send_i);
	end
	
	generate
		for (genvar iter = 0; iter < DATA_WIDTH; iter++) begin
				FF FF_instance(
				.clk(clk),
				.rst(new_rst),
				.data_i(data_i[iter]),
				.enable_i(receive_i),
				.data_o(data[iter])
			); 
		end
	endgenerate
	
	always_ff @(posedge clk) begin		
		if (rst) begin
			valid <= 1'b0;
		end else if (receive_i & ~send_i) begin
			valid <= 1'b1;
		end else if (receive_i & send_i) begin
			valid <= 1'b1;
		end else if (~receive_i & send_i) begin
			valid <= 1'b0;
		end else begin
			valid <= valid;
		end		
	end
	
	assign valid_o = valid;
	assign data_o = data & {DATA_WIDTH{valid}};
endmodule
