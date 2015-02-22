
module chooser(
	input north_hit_i,
	input east_hit_i,
	input west_hit_i,
	input south_hit_i,
	input local_hit_i,
	input [4 : 0] last_dir_i,
	input [4 : 0] is_body_i,
	output [4 : 0] dir_o,
	output [4 : 0] filter_o,
	output arb_o
);
	logic arb;
	logic [4 : 0] filter;
	logic [4 : 0] dir;
	always_comb begin
		arb = north_hit_i & east_hit_i | north_hit_i & west_hit_i | north_hit_i & south_hit_i | north_hit_i & local_hit_i |
		east_hit_i & west_hit_i | east_hit_i & south_hit_i | east_hit_i & local_hit_i | west_hit_i & south_hit_i | west_hit_i & local_hit_i |
		south_hit_i & local_hit_i;
		
		if (arb == 1'b1) begin
			if (is_body_i[4] & north_hit_i) begin 
				dir = 5'b10000;
			end else if (is_body_i[3] & east_hit_i) begin
				dir = 5'b01000;
			end else if (is_body_i[2] & west_hit_i) begin
				dir = 5'b00100;
			end else if (is_body_i[1] & south_hit_i) begin
				dir = 5'b00010;
			end else if (is_body_i[0] & local_hit_i) begin
				dir = 5'b00001;
			end else begin
				case (last_dir_i)
					5'b00000: begin
						if (north_hit_i)
							dir = 5'b10000;
						else if (east_hit_i) 
							dir = 5'b01000;
						else if (west_hit_i)
							dir = 5'b00100;
						else if (south_hit_i) 
							dir = 5'b00010;
						else  
							dir = 5'b00001;
					end
					5'b00001: begin
						if (north_hit_i) 
							dir = 5'b10000;
						else if (east_hit_i) 
							dir = 5'b01000;
						else if (west_hit_i)
							dir = 5'b00100;
						else if (south_hit_i) 
							dir = 5'b00010;
						else 
							dir = 5'b00001;
					end
					5'b00010: begin
						if (local_hit_i) 
							dir = 5'b00001;
						else if (north_hit_i) 
							dir = 5'b10000;
						else if (east_hit_i) 
							dir = 5'b01000;
						else if (west_hit_i) 
							dir = 5'b00100;
						else  
							dir = 5'b00010;
					end
					5'b00100: begin
						if (south_hit_i)  
							dir = 5'b00010;
						else if (local_hit_i)  
							dir = 5'b00001;
						else if (north_hit_i) 
							dir = 5'b10000;
						else if (east_hit_i)
							dir = 5'b01000;
						else  
							dir = 5'b00100;
					end	
					5'b01000: begin
						if (west_hit_i)
							dir = 5'b00100;
						else if (south_hit_i) 
							dir = 5'b00010;
						else if (local_hit_i) 
							dir = 5'b00001;
						else if (north_hit_i) 
							dir = 5'b10000;
						else  
							dir = 5'b01000;		
					end
					5'b10000: begin
						if (east_hit_i)  
							dir = 5'b01000;
						else if (west_hit_i) 
							dir = 5'b00100;
						else if (south_hit_i) 
							dir = 5'b00010;
						else if (local_hit_i)
							dir = 5'b00001;
						else 
							dir = 5'b10000;			
					end
					default : begin
						dir = 5'b00000;
					end
				endcase
			end
			filter = {north_hit_i, east_hit_i, west_hit_i, south_hit_i, local_hit_i} & (~dir);
		end
		else begin
			filter = 5'b00000;
			dir = last_dir_i;
		end
	end

	assign dir_o = dir;
	assign filter_o = filter;
	assign arb_o = arb;

endmodule
