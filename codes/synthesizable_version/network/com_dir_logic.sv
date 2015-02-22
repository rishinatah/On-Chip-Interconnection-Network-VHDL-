//`include "mux.sv"

module com_dir_logic (

	input [1 : 0] com1_i, com2_i,
	input valid_i,
	output [5 : 0] dir_o
);

	logic [5: 0] dir;
	
	always_comb begin
		if (valid_i == 0)
			dir = 6'b100000;
		else if (com1_i == 2'b00 && com2_i == 2'b00)
			dir = 6'b000001;
		else if (com1_i == 2'b01 && com2_i == 2'b00)
			dir = 6'b001000;
		else if (com1_i == 2'b10 && com2_i == 2'b00)
			dir = 6'b000100;
		else if (com1_i != 2'b11 && com2_i == 2'b01)
			dir = 6'b000010;
		else if (com1_i != 2'b11 && com2_i == 2'b10)
			dir = 6'b010000;
		else 
			dir = 6'b100000;
	end

	assign dir_o = dir;
	
endmodule
