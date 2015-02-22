
class transaction;

   rand int data_0_valid;
   rand int data_0_body; 
   rand int data_1_valid;
   rand int data_1_body; 
   rand int data_2_valid;
   rand int data_2_body; 
   rand int data_3_valid;
   rand int data_3_body; 
   rand int data_4_valid;
   rand int data_4_body; 
   rand int data_5_valid;
   rand int data_5_body; 
   rand int data_6_valid;
   rand int data_6_body; 
   rand int data_7_valid;
   rand int data_7_body; 
   rand int data_8_valid;
   rand int data_8_body; 
   rand int data_9_valid;
   rand int data_9_body; 
   rand int data_10_valid;
   rand int data_10_body; 
   rand int data_11_valid;
   rand int data_11_body; 
   rand int data_12_valid;
   rand int data_12_body; 
   rand int data_13_valid;
   rand int data_13_body; 
   rand int data_14_valid;
   rand int data_14_body; 
   rand int data_15_valid;
   rand int data_15_body;    
   
   constraint c0 { 0 <= data_0_valid;  data_0_valid < 100; }
   constraint c1 { 0 <= data_1_valid;  data_1_valid < 100; }
   constraint c2 { 0 <= data_2_valid;  data_2_valid < 100; }
   constraint c3 { 0 <= data_3_valid;  data_3_valid < 100; }
   constraint c4 { 0 <= data_4_valid;  data_4_valid < 100; }
   constraint c5 { 0 <= data_5_valid;  data_5_valid < 100; }
   constraint c6 { 0 <= data_6_valid;  data_6_valid < 100; }
   constraint c7 { 0 <= data_7_valid;  data_7_valid < 100; }
   constraint c8 { 0 <= data_8_valid;  data_8_valid < 100; }
   constraint c9 { 0 <= data_9_valid;  data_9_valid < 100; }
   constraint c10 { 0 <= data_10_valid;  data_10_valid < 100; }
   constraint c11 { 0 <= data_11_valid;  data_11_valid < 100; }
   constraint c12 { 0 <= data_12_valid;  data_12_valid < 100; }
   constraint c13 { 0 <= data_13_valid;  data_13_valid < 100; }
   constraint c14 { 0 <= data_14_valid;  data_14_valid < 100; }
   constraint c15 { 0 <= data_15_valid;  data_15_valid < 100; }

   int data_0 = 0; 
   int data_1 = 0;
   int data_2 = 0;
   int data_3 = 0; 
   int data_4 = 0;
   int data_5 = 0;
   int data_6 = 0; 
   int data_7 = 0;
   int data_8 = 0;
   int data_9 = 0; 
   int data_10 = 0;
   int data_11 = 0;
   int data_12 = 0; 
   int data_13 = 0;
   int data_14 = 0;
   int data_15 = 0; 
   int count[16] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	// generate random variables
	function int get_location(int body, int range, int self);
		int ret = 0;
		int loc;
		if (body < 0)
			body = -body;
		loc = body % range;
		if (self == loc)
			loc = (loc + 1) % range; //to avoid destination equals source
		
		case(loc)
			0: ret = 8'b00010001;
			1: ret = 8'b00010010;
			2: ret = 8'b00010100;
			3: ret = 8'b00011000;
			4: ret = 8'b00100001;
			5: ret = 8'b00100010;
			6: ret = 8'b00100100;
			7: ret = 8'b00101000;
			8: ret = 8'b01000001;
			9: ret = 8'b01000010;
			10: ret = 8'b01000100;
			11: ret = 8'b01001000;
			12: ret = 8'b10000001;
			13: ret = 8'b10000010;
			14: ret = 8'b10000100;
			15: ret = 8'b10001000;
			default : ret = 0;
		endcase		
		if (self == loc)
			$display("%s, %d\n","location creation fails ", self);
		return ret;
	endfunction	

	function int get_one_data(int density, int range, int valid, int body, int self, bit local_full);
		int data;
		bit tmp;
		data[31 : 17] = 15'b0;
		if (count[self] > 0) begin
			tmp = 1'b1;
		end else begin
			tmp = valid < density;
		end
		data[16] = tmp & (~local_full);
		if (data[16] == 1'b1) begin
			count[self]++;
		end
		if (count[self] >= 5) begin
			count[self] = 0;
		end
		data[15 : 8] = body[15 : 8];
		data[7 : 0] = get_location(body, range, self);
		return data;
	endfunction

	function gen_packet (
		environment env,
		bit local_full[16]
	);

		// randomize
		this.randomize();
		
		data_0 = get_one_data(env.data_0_density, env.data_0_range, data_0_valid, data_0_body, 0, local_full[0]);
		data_1 = get_one_data(env.data_1_density, env.data_1_range, data_1_valid, data_1_body, 1, local_full[1]);
		data_2 = get_one_data(env.data_2_density, env.data_2_range, data_2_valid, data_2_body, 2, local_full[2]);
		data_3 = get_one_data(env.data_3_density, env.data_3_range, data_3_valid, data_3_body, 3, local_full[3]);
		data_4 = get_one_data(env.data_4_density, env.data_4_range, data_4_valid, data_4_body, 4, local_full[4]);
		data_5 = get_one_data(env.data_5_density, env.data_5_range, data_5_valid, data_5_body, 5, local_full[5]);
		data_6 = get_one_data(env.data_6_density, env.data_6_range, data_6_valid, data_6_body, 6, local_full[6]);
		data_7 = get_one_data(env.data_7_density, env.data_7_range, data_7_valid, data_7_body, 7, local_full[7]);
		data_8 = get_one_data(env.data_8_density, env.data_8_range, data_8_valid, data_8_body, 8, local_full[8]);
		data_9 = get_one_data(env.data_9_density, env.data_9_range, data_9_valid, data_9_body, 9, local_full[9]);
		data_10 = get_one_data(env.data_10_density, env.data_10_range, data_10_valid, data_10_body, 10, local_full[10]);
		data_11 = get_one_data(env.data_11_density, env.data_11_range, data_11_valid, data_11_body, 11, local_full[11]);
		data_12 = get_one_data(env.data_12_density, env.data_12_range, data_12_valid, data_12_body, 12, local_full[12]);
		data_13 = get_one_data(env.data_13_density, env.data_13_range, data_13_valid, data_13_body, 13, local_full[13]);
		data_14 = get_one_data(env.data_14_density, env.data_14_range, data_14_valid, data_14_body, 14, local_full[14]);
		data_15 = get_one_data(env.data_15_density, env.data_15_range, data_15_valid, data_15_body, 15, local_full[15]);

		
	endfunction
	

	function gen_reminder();
		if (count[0] > 0) begin
			data_0 = 17'b10000000000010001;
			count[0]++;
			if (count[0] >= 5)
				count[0] = 0;
		end else begin
			data_0 = 17'b0;
		end
		if (count[1] > 0) begin
			data_1 = 17'b10000000000010001;
			count[1]++;
			if (count[1] >= 5)
				count[1] = 0;
		end else begin
			data_1 = 17'b0;
		end
		if (count[2] > 0) begin
			data_2 = 17'b10000000000010001;
			count[2]++;
			if (count[2] >= 5)
				count[2] = 0;
		end else begin
			data_2 = 17'b0;
		end
		if (count[3] > 0) begin
			data_3 = 17'b10000000000010001;
			count[3]++;
			if (count[3] >= 5)
				count[3] = 0;
		end else begin
			data_3 = 17'b0;
		end

		if (count[4] > 0) begin
			data_4 = 17'b10000000000010001;
			count[4]++;
			if (count[4] >= 5)
				count[4] = 0;
		end else begin
			data_4 = 17'b0;
		end
		if (count[5] > 0) begin
			data_5 = 17'b10000000000010001;
			count[5]++;
			if (count[5] >= 5)
				count[5] = 0;
		end else begin
			data_5 = 17'b0;
		end
		if (count[6] > 0) begin
			data_6 = 17'b10000000000010001;
			count[6]++;
			if (count[6] >= 5)
				count[6] = 0;
		end else begin
			data_6 = 17'b0;
		end
		if (count[7] > 0) begin
			data_7 = 17'b10000000000010001;
			count[7]++;
			if (count[7] >= 5)
				count[7] = 0;
		end else begin
			data_7 = 17'b0;
		end
		if (count[8] > 0) begin
			data_8 = 17'b10000000000010001;
			count[8]++;
			if (count[8] >= 5)
				count[8] = 0;
		end else begin
			data_8 = 17'b0;
		end
		
		if (count[9] > 0) begin
			data_9 = 17'b10000000000010001;
			count[9]++;
			if (count[9] >= 5)
				count[9] = 0;
		end else begin
			data_9 = 17'b0;
		end

		if (count[10] > 0) begin
			data_10 = 17'b10000000000010001;
			count[10]++;
			if (count[10] >= 5)
				count[10] = 0;
		end else begin
			data_10 = 17'b0;
		end

		if (count[11] > 0) begin
			data_11 = 17'b10000000000010001;
			count[11]++;
			if (count[11] >= 5)
				count[11] = 0;
		end else begin
			data_11 = 17'b0;
		end
		if (count[12] > 0) begin
			data_12 = 17'b10000000000010001;
			count[12]++;
			if (count[12] >= 5)
				count[12] = 0;
		end else begin
			data_12 = 17'b0;
		end

		if (count[13] > 0) begin
			data_13 = 17'b10000000000010001;
			count[13]++;
			if (count[13] >= 5)
				count[13] = 0;
		end else begin
			data_13 = 17'b0;
		end
		if (count[14] > 0) begin
			data_14 = 17'b10000000000010001;
			count[14]++;
			if (count[14] >= 5)
				count[14] = 0;
		end else begin
			data_14 = 17'b0;
		end
		
		if (count[15] > 0) begin
			data_15 = 17'b10000000000010001;
			count[15]++;
			if (count[15] >= 5)
				count[15] = 0;
		end else begin
			data_15 = 17'b0;
		end




	endfunction	

endclass
