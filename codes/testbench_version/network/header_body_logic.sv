
module header_body_logic (

	input [5 : 0] dir_i, dir_record_i,
	input [2 : 0] count_i,
	output [5 : 0] dir_o, dir_record_o,
	output add_o,
	output is_body_o
);
	
	logic add;
	logic is_body;
	logic [5: 0] dir, dir_record;
	
	always_comb begin
		if (dir_i[5] == 1'b0) begin
			if (count_i == 3'b000) begin //header flit
				add = 1'b1;
				dir = dir_i;
				dir_record = dir_i;
				is_body = 1'b0;
			end
			else begin //body flit
				add = 1'b1;
				dir = dir_record_i;
				is_body = 1'b1;
			end
		end
		else begin
			add = 1'b0;
			dir = dir_i;
			is_body = 1'b0;
		end
	end

	assign dir_o = dir;
	assign add_o = add;
	assign dir_record_o = dir_record;
	assign is_body_o = is_body;
	
endmodule
