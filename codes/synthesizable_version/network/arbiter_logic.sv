
module arbiter_logic(

	input arb1_i, arb2_i, arb3_i, arb4_i, arb5_i,
	input [4 : 0] fil1_i, fil2_i, fil3_i, fil4_i, fil5_i,
	output logic arb_o, 
	output logic [4 : 0] filter_o
);

	logic arb;
	logic [4 : 0] filter;
	
	always_comb begin
		arb = arb1_i|arb2_i|arb3_i|arb4_i|arb5_i;
		filter[0] = fil1_i[0] | fil2_i[0] | fil3_i[0] | fil4_i[0] | fil5_i[0];
		filter[1] = fil1_i[1] | fil2_i[1] | fil3_i[1] | fil4_i[1] | fil5_i[1];
		filter[2] = fil1_i[2] | fil2_i[2] | fil3_i[2] | fil4_i[2] | fil5_i[2];
		filter[3] = fil1_i[3] | fil2_i[3] | fil3_i[3] | fil4_i[3] | fil5_i[3];
		filter[4] = fil1_i[4] | fil2_i[4] | fil3_i[4] | fil4_i[4] | fil5_i[4];
	end
		
	assign arb_o = arb;
	assign filter_o = filter;

endmodule
