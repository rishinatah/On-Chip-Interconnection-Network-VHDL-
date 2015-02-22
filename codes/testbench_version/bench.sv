//`timescale 1ns/1ps
`include "tb/environment.sv"
`include "tb/transaction.sv"
`include "tb/checker.sv"


program tb (ifc.bench ds);

	environment env;
	transaction packet;
	checker golden_model;
	int errors = 0;
	bit judge;
	bit local_full[16];//for back pressure mechanism
	initial begin
		for (int j = 0; j < 16; j++)
			local_full[j] = 0;
		env = new();
		env.configure ("config.txt");
		golden_model = new();
		golden_model.reset;
		packet = new();
		ds.cb.rst <= 1; //give the reset signal first
		@(ds.cb) //since the reset signal is synchronous, we need one more cycle to pass in the reset. 
		@(ds.cb)
		ds.cb.rst <= 0; 
		
		repeat(4000) begin
			packet.gen_packet(env, local_full); 
			ds.cb.data_0_i <= packet.data_0;
			ds.cb.data_1_i <= packet.data_1;
			ds.cb.data_2_i <= packet.data_2;
			ds.cb.data_3_i <= packet.data_3;
			ds.cb.data_4_i <= packet.data_4;
			ds.cb.data_5_i <= packet.data_5;
			ds.cb.data_6_i <= packet.data_6;
			ds.cb.data_7_i <= packet.data_7;
			ds.cb.data_8_i <= packet.data_8;
			ds.cb.data_9_i <= packet.data_9;
			ds.cb.data_10_i <= packet.data_10;
			ds.cb.data_11_i <= packet.data_11;
			ds.cb.data_12_i <= packet.data_12;
			ds.cb.data_13_i <= packet.data_13;
			ds.cb.data_14_i <= packet.data_14;
			ds.cb.data_15_i <= packet.data_15;
			golden_model.insert(packet.data_0, 0);//place data into testbench software golden answer
			golden_model.insert(packet.data_1, 1);
			golden_model.insert(packet.data_2, 2);
			golden_model.insert(packet.data_3, 3);
			golden_model.insert(packet.data_4, 4);
			golden_model.insert(packet.data_5, 5);
			golden_model.insert(packet.data_6, 6);
			golden_model.insert(packet.data_7, 7);
			golden_model.insert(packet.data_8, 8);
			golden_model.insert(packet.data_9, 9);
			golden_model.insert(packet.data_10, 10);
			golden_model.insert(packet.data_11, 11);
			golden_model.insert(packet.data_12, 12);
			golden_model.insert(packet.data_13, 13);
			golden_model.insert(packet.data_14, 14);
			golden_model.insert(packet.data_15, 15);
			
			@(ds.cb);
			for (int i = 0; i < 16; i++) begin
				local_full[i] = ds.cb.local_full[i];
			end	

			judge = golden_model.check(ds.cb.data_0_o, 0);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_1_o, 1);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_2_o, 2);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_3_o, 3);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_4_o, 4);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_5_o, 5);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_6_o, 6);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_7_o, 7);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_8_o, 8);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_9_o, 9);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_10_o, 10);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_11_o, 11);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_12_o, 12);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_13_o, 13);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_14_o, 14);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_15_o, 15);
				errors = errors + judge;
		end
		repeat(100) begin //time for data in network to finish
			packet.gen_reminder(); //if the body flits number is not enough, fix it.
			ds.cb.data_0_i <= packet.data_0;
			ds.cb.data_1_i <= packet.data_1;
			ds.cb.data_2_i <= packet.data_2;
			ds.cb.data_3_i <= packet.data_3;
			ds.cb.data_4_i <= packet.data_4;
			ds.cb.data_5_i <= packet.data_5;
			ds.cb.data_6_i <= packet.data_6;
			ds.cb.data_7_i <= packet.data_7;
			ds.cb.data_8_i <= packet.data_8;
			ds.cb.data_9_i <= packet.data_9;
			ds.cb.data_10_i <= packet.data_10;
			ds.cb.data_11_i <= packet.data_11;
			ds.cb.data_12_i <= packet.data_12;
			ds.cb.data_13_i <= packet.data_13;
			ds.cb.data_14_i <= packet.data_14;
			ds.cb.data_15_i <= packet.data_15;
			golden_model.insert(packet.data_0, 0);
			golden_model.insert(packet.data_1, 1);
			golden_model.insert(packet.data_2, 2);
			golden_model.insert(packet.data_3, 3);
			golden_model.insert(packet.data_4, 4);
			golden_model.insert(packet.data_5, 5);
			golden_model.insert(packet.data_6, 6);
			golden_model.insert(packet.data_7, 7);
			golden_model.insert(packet.data_8, 8);
			golden_model.insert(packet.data_9, 9);
			golden_model.insert(packet.data_10, 10);
			golden_model.insert(packet.data_11, 11);
			golden_model.insert(packet.data_12, 12);
			golden_model.insert(packet.data_13, 13);
			golden_model.insert(packet.data_14, 14);
			golden_model.insert(packet.data_15, 15);
			@(ds.cb);
			judge = golden_model.check(ds.cb.data_0_o, 0);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_1_o, 1);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_2_o, 2);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_3_o, 3);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_4_o, 4);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_5_o, 5);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_6_o, 6);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_7_o, 7);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_8_o, 8);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_9_o, 9);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_10_o, 10);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_11_o, 11);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_12_o, 12);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_13_o, 13);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_14_o, 14);
				errors = errors + judge;
			judge = golden_model.check(ds.cb.data_15_o, 15);
				errors = errors + judge;
		end
	end	
	
	final $display("%s, %d\n","The error number is ",errors);	
	final $display("%s, %d\n","The data number in the network is ",golden_model.data_remain);

endprogram
