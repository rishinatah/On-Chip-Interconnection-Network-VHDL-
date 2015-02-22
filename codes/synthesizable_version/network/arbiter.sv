//`include "chooser.sv"
//`include "arbiter_logic.sv"
//`include "register.sv"
//`include "FF.sv"

module arbiter (
	
	input clk, rst,
	input [5 : 0] north_dir_i, east_dir_i, west_dir_i, south_dir_i, local_dir_i,
	input [4 : 0] is_body_i,
	output arb_o,
	output [4 : 0] filter_o
);

	logic enable;
	logic [4 : 0] last_north;
	logic [4 : 0] last_east;
	logic [4 : 0] last_west;
	logic [4 : 0] last_south;
	logic [4 : 0] last_local;
	logic [4 : 0] curr_north;
	logic [4 : 0] curr_east;
	logic [4 : 0] curr_west;
	logic [4 : 0] curr_south;
	logic [4 : 0] curr_local;
	logic arb1,arb2,arb3,arb4,arb5;
	logic [4 : 0] fil1,fil2,fil3,fil4,fil5;
	logic arb_result;
	logic [4 : 0] fil_result;
	logic [4 : 0] valid;
	
	
		register #(.DATA_WIDTH(5)) 
			register_north (
				.clk(clk),
				.rst(rst),
				.receive_i(1'b1),
				.send_i(1'b0),
				.data_i(curr_north),
				.data_o(last_north),
				.valid_o(valid[4])
				);
		register #(.DATA_WIDTH(5))
			register_east (
				.clk(clk),
				.rst(rst),
				.receive_i(1'b1),
				.send_i(1'b0),
				.data_i(curr_east),
				.data_o(last_east),
				.valid_o(valid[3])
				);
		register #(.DATA_WIDTH(5))
			register_west (
				.clk(clk),
				.rst(rst),
				.receive_i(1'b1),
				.send_i(1'b0),
				.data_i(curr_west),
				.data_o(last_west),
				.valid_o(valid[2])
				);
		register #(.DATA_WIDTH(5))
			register_south (
				.clk(clk),
				.rst(rst),
				.receive_i(1'b1),
				.send_i(1'b0),
				.data_i(curr_south),
				.data_o(last_south),
				.valid_o(valid[1])
				);
		register #(.DATA_WIDTH(5))
			register_local (
				.clk(clk),
				.rst(rst),
				.receive_i(1'b1),
				.send_i(1'b0),
				.data_i(curr_local),
				.data_o(last_local),
				.valid_o(valid[0])
				);
		
	chooser chooser_north (
				.north_hit_i(north_dir_i[4]),
				.east_hit_i(east_dir_i[4]),
				.west_hit_i(west_dir_i[4]),
				.south_hit_i(south_dir_i[4]),
				.local_hit_i(local_dir_i[4]),
				.last_dir_i(last_north),
				.is_body_i(is_body_i),
				.dir_o(curr_north),
				.filter_o(fil1),
				.arb_o(arb1)
			);
	chooser chooser_east (
				.north_hit_i(north_dir_i[3]),
				.east_hit_i(east_dir_i[3]),
				.west_hit_i(west_dir_i[3]),
				.south_hit_i(south_dir_i[3]),
				.local_hit_i(local_dir_i[3]),
				.last_dir_i(last_east),
				.is_body_i(is_body_i),
				.dir_o(curr_east),
				.filter_o(fil2),
				.arb_o(arb2)
			);		
	chooser chooser_west (
				.north_hit_i(north_dir_i[2]),
				.east_hit_i(east_dir_i[2]),
				.west_hit_i(west_dir_i[2]),
				.south_hit_i(south_dir_i[2]),
				.local_hit_i(local_dir_i[2]),
				.last_dir_i(last_west),
				.is_body_i(is_body_i),
				.dir_o(curr_west),
				.filter_o(fil3),
				.arb_o(arb3)
			);
	chooser chooser_south (
				.north_hit_i(north_dir_i[1]),
				.east_hit_i(east_dir_i[1]),
				.west_hit_i(west_dir_i[1]),
				.south_hit_i(south_dir_i[1]),
				.local_hit_i(local_dir_i[1]),
				.last_dir_i(last_south),
				.is_body_i(is_body_i),
				.dir_o(curr_south),
				.filter_o(fil4),
				.arb_o(arb4)
			);
	chooser chooser_local (
				.north_hit_i(north_dir_i[0]),
				.east_hit_i(east_dir_i[0]),
				.west_hit_i(west_dir_i[0]),
				.south_hit_i(south_dir_i[0]),
				.local_hit_i(local_dir_i[0]),
				.last_dir_i(last_local),
				.is_body_i(is_body_i),
				.dir_o(curr_local),
				.filter_o(fil5),
				.arb_o(arb5)
			);
			
	arbiter_logic arbiter_logic_instance(
				.arb1_i(arb1),
				.arb2_i(arb2),
				.arb3_i(arb3),
				.arb4_i(arb4),
				.arb5_i(arb5),
				.fil1_i(fil1),
				.fil2_i(fil2),
				.fil3_i(fil3),
				.fil4_i(fil4),
				.fil5_i(fil5),
				.arb_o(arb_result),
				.filter_o(fil_result)
			);		
	assign arb_o = arb_result;
	assign filter_o = fil_result;
	
endmodule
//just the module interface, no functionality included
