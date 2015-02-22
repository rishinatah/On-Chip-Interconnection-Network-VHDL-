//`timescale 1ns/1ns
//`include "network/interface.sv"
//`include "network/network.sv"
//`include "tb/bench.sv"

module top();
	bit clk = 0;
	always #5 clk = ~clk;

	initial $vcdpluson;

	ifc ifc(clk); // instantiate the interface file
	network dut(ifc.dut); 
	tb bench(ifc.bench);
endmodule
