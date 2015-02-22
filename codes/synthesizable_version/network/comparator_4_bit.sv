
module comparator_4_bit (
	input [3 : 0] data1_i,
	input [3 : 0] data2_i,
	output logic [1 : 0] result_o
);
//data1_i and data2_i are one_hot input
	logic [1 : 0] result;
	
	always_comb begin
	if ((data1_i[3] == 1)&& (data2_i[3] == 1))
		result = 2'b00;
	else if ((data1_i[3] == 1)&& (data2_i[3] == 0))
		result = 2'b01;
	else if ((data1_i[2] == 1)&& (data2_i[3] == 1))
		result = 2'b10;
	else if ((data1_i[2] == 1)&& (data2_i[2] == 1))
		result = 2'b00;
	else if ((data1_i[2] == 1)&& (data2_i[2] == 0))
		result = 2'b01;
	else if ((data1_i[1] == 1)&& (data2_i[3] == 1))
		result = 2'b10;
	else if ((data1_i[1] == 1)&& (data2_i[2] == 1))
		result = 2'b10;
	else if ((data1_i[1] == 1)&& (data2_i[1] == 1))
		result = 2'b00;
	else if ((data1_i[1] == 1)&& (data2_i[0] == 1))
		result = 2'b01;
	else if ((data1_i[0] == 1)&& (data2_i[0] == 0))
		result = 2'b10;
	else if ((data1_i[0] == 1)&& (data1_i[0] == 1))
		result = 2'b00;
	else
		result = 2'b00;
	end
	
	assign result_o = result;
	
endmodule
