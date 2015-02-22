
module header_body_record (clk, rst, dir_i, add_i, new_data_i, dir_o, count_o);

	input clk;
	input rst;
	input add_i;
	input new_data_i;
	input [5 : 0] dir_i;
	output [5 : 0] dir_o;
	output [2 : 0] count_o;

	logic [5 : 0] dir;
	logic [2 : 0] count;
	
	always_ff @(posedge clk) begin
		if (rst) begin
			count <= 3'b000;
			dir <= 6'b100000;
		end 
		else if (add_i & new_data_i) begin
			case(count)
				3'b000: begin 
					count <= 3'b001;
					dir <= dir_i;
				end
				3'b001: begin
					count <= 3'b010;
					dir <= dir;
				end
				3'b010: begin
					count <= 3'b011;
					dir <= dir;
				end
				3'b011: begin
					count <= 3'b100;
					dir <= dir;
				end
				3'b100: begin
					count <= 3'b000;
					dir <= dir;
				end
				default: begin
					count <= 3'b000;
					dir <= 6'b100000;
				end
			endcase			
		end else begin
			count <= count;
			dir <= dir;
		end
	end
	
	assign count_o = count;
	assign dir_o = dir;
	
endmodule

