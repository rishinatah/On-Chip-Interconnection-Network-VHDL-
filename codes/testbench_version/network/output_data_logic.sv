

module output_data_logic (
	
		input [16 : 0] north_data_i, east_data_i, west_data_i, south_data_i, local_data_i, 
		input arb_i,
		input [4 : 0] filter_i,
		input [5 : 0] north_dir_i, east_dir_i, west_dir_i, south_dir_i, local_dir_i,
		input [14 : 0] credit_all_i,
		output logic [16 : 0] north_data_o, east_data_o, west_data_o, south_data_o, local_data_o, 
		output logic [4 : 0] send_data_o,//which input buffers are allowed to send a data flit
		output logic [4 : 0] counter_minus_o
);

	logic send_north, send_east, send_west, send_south, send_local;
	logic [16 : 0] north_data, east_data, west_data, south_data, local_data;
	assign send_north = (north_dir_i[4] | east_dir_i[4] | west_dir_i[4] | south_dir_i[4] | local_dir_i[4]) & (credit_all_i[14 : 12] != 3'b000) & (credit_all_i[14 : 12] != 3'b110);
	assign send_east = (north_dir_i[3] | east_dir_i[3] | west_dir_i[3] | south_dir_i[3] | local_dir_i[3]) & (credit_all_i[11 : 9] != 3'b000) & (credit_all_i[11 : 9] != 3'b110);
	assign send_west = (north_dir_i[2] | east_dir_i[2] | west_dir_i[2] | south_dir_i[2] | local_dir_i[2]) & (credit_all_i[8 : 6] != 3'b000) & (credit_all_i[8 : 6] != 3'b110);
	assign send_south = (north_dir_i[1] | east_dir_i[1] | west_dir_i[1] | south_dir_i[1] | local_dir_i[1]) & (credit_all_i[5 : 3] != 3'b000) & (credit_all_i[5 : 3] != 3'b110);
	assign send_local = north_dir_i[0] | east_dir_i[0] | west_dir_i[0] | south_dir_i[0] | local_dir_i[0];
	
	always_comb begin		
		if ((arb_i == 0 || (arb_i == 1 && filter_i[4] == 0)) && (north_dir_i[5] == 0)) begin
			if ((north_dir_i == 6'b001000) &  (credit_all_i[11 : 9] != 3'b000) & (credit_all_i[11 : 9] != 3'b110)) begin
				east_data = north_data_i;
				send_data_o[4] = 1'b1;
			end else if ((north_dir_i == 6'b000100) &  (credit_all_i[8 : 6] != 3'b000) & (credit_all_i[8 : 6] != 3'b110)) begin
				west_data = north_data_i;
				send_data_o[4] = 1'b1;
			end else if ((north_dir_i == 6'b000010) &  (credit_all_i[5 : 3] != 3'b000) & (credit_all_i[5 : 3] != 3'b110)) begin
				south_data = north_data_i;
				send_data_o[4] = 1'b1;
			end else if (north_dir_i == 6'b000001) begin
				local_data = north_data_i;
				send_data_o[4] = 1'b1;
			end else begin
				send_data_o[4] = 1'b0;
			end
		end else begin
			send_data_o[4] = 1'b0;
		end
		
		if ((arb_i == 0 || (arb_i == 1 && filter_i[3] == 0)) && (east_dir_i[5] == 0)) begin
			if ((east_dir_i == 6'b010000) &  (credit_all_i[14 : 12] != 3'b000) & (credit_all_i[14 : 12] != 3'b110)) begin
				north_data = east_data_i;
				send_data_o[3] = 1'b1;
			end else if ((east_dir_i == 6'b000100) &  (credit_all_i[8 : 6] != 3'b000) & (credit_all_i[8 : 6] != 3'b110)) begin
				west_data = east_data_i;
				send_data_o[3] = 1'b1;
			end else if ((east_dir_i == 6'b000010) &  (credit_all_i[5 : 3] != 3'b000) & (credit_all_i[5 : 3] != 3'b110)) begin
				south_data = east_data_i;
				send_data_o[3] = 1'b1;
			end else if (east_dir_i == 6'b000001) begin
				local_data = east_data_i;
				send_data_o[3] = 1'b1;
			end else begin
				send_data_o[3] = 1'b0;
			end
		end else begin
			send_data_o[3] = 1'b0;
		end
		
		if ((arb_i == 0 || (arb_i == 1 && filter_i[2] == 0)) && (west_dir_i[5] == 0)) begin
			if ((west_dir_i == 6'b010000) &  (credit_all_i[14 : 12] != 3'b000) & (credit_all_i[14 : 12] != 3'b110)) begin
				north_data = west_data_i;
				send_data_o[2] = 1'b1;
			end else if ((west_dir_i == 6'b001000) &  (credit_all_i[11 : 9] != 3'b000) & (credit_all_i[11 : 9] != 3'b110)) begin
				east_data = west_data_i;
				send_data_o[2] = 1'b1;
			end else if ((west_dir_i == 6'b000010) &  (credit_all_i[5 : 3] != 3'b000) & (credit_all_i[5 : 3] != 3'b110)) begin
				south_data = west_data_i;
				send_data_o[2] = 1'b1;
			end else if (west_dir_i == 6'b000001) begin
				local_data = west_data_i;
				send_data_o[2] = 1'b1;
			end else begin
				send_data_o[2] = 1'b0;
			end
		end else begin
			send_data_o[2] = 1'b0;
		end

		if ((arb_i == 0 || (arb_i == 1 && filter_i[1] == 0)) && (south_dir_i[5] == 0)) begin
			if ((south_dir_i == 6'b010000) &  (credit_all_i[14 : 12] != 3'b000) & (credit_all_i[14 : 12] != 3'b110)) begin
				north_data = south_data_i;
				send_data_o[1] = 1'b1;
			end else if ((south_dir_i == 6'b001000) &  (credit_all_i[11 : 9] != 3'b000) & (credit_all_i[11 : 9] != 3'b110)) begin
				east_data = south_data_i;
				send_data_o[1] = 1'b1;
			end else if ((south_dir_i == 6'b000100) &  (credit_all_i[8 : 6] != 3'b000) & (credit_all_i[8 : 6] != 3'b110)) begin
				west_data = south_data_i;
				send_data_o[1] = 1'b1;
			end else if (south_dir_i == 6'b000001) begin
				local_data = south_data_i;
				send_data_o[1] = 1'b1;
			end else begin
				send_data_o[1] = 1'b0;
			end
		end else begin
			send_data_o[1] = 1'b0;
		end

		if ((arb_i == 0 || (arb_i == 1 && filter_i[0] == 0)) && (local_dir_i[5] == 0)) begin
			if ((local_dir_i == 6'b010000) &  (credit_all_i[14 : 12] != 3'b000) & (credit_all_i[14 : 12] != 3'b110)) begin
				north_data = local_data_i;
				send_data_o[0] = 1'b1;
			end else if ((local_dir_i == 6'b001000) &  (credit_all_i[11 : 9] != 3'b000) & (credit_all_i[11 : 9] != 3'b110)) begin
				east_data = local_data_i;
				send_data_o[0] = 1'b1;
			end else if ((local_dir_i == 6'b000100) &  (credit_all_i[8 : 6] != 3'b000) & (credit_all_i[8 : 6] != 3'b110)) begin
				west_data = local_data_i;
				send_data_o[0] = 1'b1;
			end else if ((local_dir_i == 6'b000010) &  (credit_all_i[5 : 3] != 3'b000) & (credit_all_i[5 : 3] != 3'b110)) begin
				south_data = local_data_i;
				send_data_o[0] = 1'b1;
			end else begin
				send_data_o[0] = 1'b0;
			end
		end else begin
			send_data_o[0] = 1'b0;
		end

	end

	assign north_data_o = (send_north)? north_data : 17'b0;
	assign east_data_o = (send_east) ? east_data : 17'b0;
	assign west_data_o = (send_west) ? west_data : 17'b0;
	assign south_data_o = (send_south) ? south_data : 17'b0;
	assign local_data_o = (send_local) ? local_data : 17'b0;
	assign counter_minus_o = {send_north, send_east, send_west, send_south, send_local};//which output direction pass a new data flit
	

endmodule
