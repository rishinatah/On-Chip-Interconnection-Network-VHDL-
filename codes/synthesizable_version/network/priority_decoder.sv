module priority_decoder (
	input [4 : 0] valid_i,
	output logic [4 : 0] write_o
);
	
	logic [4 : 0] write;

	always_comb begin
		if (valid_i[4]) write = 5'b10000;
		else if (valid_i[3]) write = 5'b01000;
		else if (valid_i[2]) write = 5'b00100;
		else if (valid_i[1]) write = 5'b00010;
		else if (valid_i[0]) write = 5'b00001;
		else write = 5'b00000;
	end
	
	assign write_o = write;
	
endmodule

