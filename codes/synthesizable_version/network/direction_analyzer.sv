//`include "comparator_4_bit.sv"
//`include "com_dir_logic.sv"

module direction_analyzer #(parameter ROUTER_ID = 0)(
	
		input [16 : 0] data_i,
		input valid_i,
		output [5 : 0] direction_o
);
	
	logic [1 : 0] com_result1, com_result2;
	logic [7 : 0] router_location;
	logic [5 : 0] dir;
	
	always_comb begin
		case(ROUTER_ID)
			0: router_location = 8'b00010001;
			1: router_location = 8'b00010010;
			2: router_location = 8'b00010100;
			3: router_location = 8'b00011000;
			4: router_location = 8'b00100001;
			5: router_location = 8'b00100010;
			6: router_location = 8'b00100100;
			7: router_location = 8'b00101000;
			8: router_location = 8'b01000001;
			9: router_location = 8'b01000010;
			10: router_location = 8'b01000100;
			11: router_location = 8'b01001000;
			12: router_location = 8'b10000001;
			13: router_location = 8'b10000010;
			14: router_location = 8'b10000100;
			15: router_location = 8'b10001000;
			default: router_location = 8'b0;
		endcase
	end
	
	comparator_4_bit //to judge EW
	comparator1 (
	.data1_i(data_i[3 : 0]),
	.data2_i(router_location[3 : 0]),
	.result_o(com_result1)
	);
	
	
	comparator_4_bit //to judge NS
	comparator2 (
	.data1_i(data_i[7 : 4]),
	.data2_i(router_location[7 : 4]),
	.result_o(com_result2)
	);
	
	com_dir_logic com_dir_logic_instance(
	.com1_i(com_result1),
	.com2_i(com_result2),
	.valid_i(valid_i),
	.dir_o(dir)
	);
	
	assign direction_o = dir;
endmodule
