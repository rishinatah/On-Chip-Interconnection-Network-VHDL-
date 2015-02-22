//`include "register.sv"

module counter(clk, rst, up_i, down_i, value_o);

	input clk;
	input rst;
	input up_i;
	input down_i;
	output logic [2 : 0] value_o;

	logic [2 : 0] value;
	
	always_ff @(posedge clk) begin
		if (rst) begin 
			value <= 3'b101;
		end else if (up_i & down_i) begin
			value <= value;
		end else if (up_i & ~down_i) begin
			case(value) 
				3'b000: value <= 3'b001;
				3'b001: value <= 3'b010;
				3'b010: value <= 3'b011;
				3'b011: value <= 3'b100;
				3'b100: value <= 3'b101;
				default: value <= 3'b110;
			endcase
		end else if (~up_i & down_i) begin
			case(value)
				3'b001: value <= 3'b000;
				3'b010: value <= 3'b001;
				3'b011: value <= 3'b010;
				3'b100: value <= 3'b011;
				3'b101: value <= 3'b100;
				default: value <= 3'b110;
			endcase
		end else begin
			value <= value;
		end
	end
	
	assign value_o = value;
	
endmodule
