module FF(clk,rst, data_i, enable_i, data_o);

	input clk;
	input rst;
	input data_i;
	input enable_i;
	output data_o;
	logic data;

	always_ff @(posedge clk) begin
		if (rst) data <= 1'b0;
		else if (enable_i) data <= data_i;
	end

	assign data_o = data;
endmodule

