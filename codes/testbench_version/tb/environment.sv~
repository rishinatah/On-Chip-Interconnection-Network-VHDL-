
class environment;
	
	int data_0_density = 0;//data 0 valid frequency
	int data_0_range = 0;//data 0 destination range
	int data_1_density = 0;
	int data_1_range = 0;
	int data_2_density = 0;
	int data_2_range = 0;
	int data_3_density = 0;
	int data_3_range = 0;
	int data_4_density = 0;
	int data_4_range = 0;
	int data_5_density = 0;
	int data_5_range = 0;
	int data_6_density = 0;
	int data_6_range = 0;
	int data_7_density = 0;
	int data_7_range = 0;
	int data_8_density = 0;
	int data_8_range = 0;
	int data_9_density = 0;
	int data_9_range = 0;
	int data_10_density = 0;
	int data_10_range = 0;
	int data_11_density = 0;
	int data_11_range = 0;
	int data_12_density = 0;
	int data_12_range = 0;
	int data_13_density = 0;
	int data_13_range = 0;
	int data_14_density = 0;
	int data_14_range = 0;
	int data_15_density = 0;
	int data_15_range = 0;
	
	function configure (string filename);
		int file, chars_returned;
		string param, value;
		file = $fopen(filename, "r");
		if (file)
		$display("%s\n","File open succeeds");
		while(!$feof(file)) begin
			// we'll capture value as string now and convert it later
			chars_returned = $fscanf(file, "%s %s", param, value);
			if("data_0_density" == param) begin
				data_0_density = value.atoi();
			end
			else if("data_0_range" == param) begin
				data_0_range = value.atoi();
			end
			else if("data_1_density" == param) begin
				data_1_density = value.atoi();
			end
			else if("data_1_range" == param) begin
				data_1_range = value.atoi();
			end
			else if("data_2_density" == param) begin
				data_2_density = value.atoi();
			end
			else if("data_2_range" == param) begin
				data_2_range = value.atoi();
			end
			else if("data_3_density" == param) begin
				data_3_density = value.atoi();
			end
			else if("data_3_range" == param) begin
				data_3_range = value.atoi();
			end
			else if("data_4_density" == param) begin
				data_4_density = value.atoi();
			end
			else if("data_4_range" == param) begin
				data_4_range = value.atoi();
			end
			else if("data_5_density" == param) begin
				data_5_density = value.atoi();
			end
			else if("data_5_range" == param) begin
				data_5_range = value.atoi();
			end
			else if("data_6_density" == param) begin
				data_6_density = value.atoi();
			end
			else if("data_6_range" == param) begin
				data_6_range = value.atoi();
			end
			else if("data_7_density" == param) begin
				data_7_density = value.atoi();
			end
			else if("data_7_range" == param) begin
				data_7_range = value.atoi();
			end
			else if("data_8_density" == param) begin
				data_8_density = value.atoi();
			end
			else if("data_8_range" == param) begin
				data_8_range = value.atoi();
			end
			else if("data_9_density" == param) begin
				data_9_density = value.atoi();
			end
			else if("data_9_range" == param) begin
				data_9_range = value.atoi();
			end
			else if("data_10_density" == param) begin
				data_10_density = value.atoi();
			end
			else if("data_10_range" == param) begin
				data_10_range = value.atoi();
			end
			else if("data_11_density" == param) begin
				data_11_density = value.atoi();
			end
			else if("data_11_range" == param) begin
				data_11_range = value.atoi();
			end
			else if("data_12_density" == param) begin
				data_12_density = value.atoi();
			end
			else if("data_12_range" == param) begin
				data_12_range = value.atoi();
			end
			else if("data_13_density" == param) begin
				data_13_density = value.atoi();
			end
			else if("data_13_range" == param) begin
				data_13_range = value.atoi();
			end
			else if("data_14_density" == param) begin
				data_14_density = value.atoi();
			end
			else if("data_14_range" == param) begin
				data_14_range = value.atoi();
			end
			else if("data_15_density" == param) begin
				data_15_density = value.atoi();
			end
			else if("data_15_range" == param) begin
				data_15_range = value.atoi();
			end
			else begin
				$display("Never heard of a: %s", param);
			end
		end
	endfunction	

endclass	
