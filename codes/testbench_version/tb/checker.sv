
class checker;

	int r [3200];//each data owns 200 blocks to store their data;
	int count[16];
	int header[16];
	function void reset;
		int i;
		for (i = 0; i < 3200; i++) begin
			r[i] = -1;
		end
		for (i = 0; i < 16; i++) begin
			count[i] = 0;
			header[i] = -1;
		end
	endfunction
	
	function int get_block(int data);
		int ret;
		case(data)
			8'b00010001: ret = 0;
			8'b00010010: ret = 1;
			8'b00010100: ret = 2;
			8'b00011000: ret = 3;
			8'b00100001: ret = 4;
			8'b00100010: ret = 5;
			8'b00100100: ret = 6;
			8'b00101000: ret = 7;
			8'b01000001: ret = 8;
			8'b01000010: ret = 9;
			8'b01000100: ret = 10;
			8'b01001000: ret = 11;
			8'b10000001: ret = 12;
			8'b10000010: ret = 13;
			8'b10000100: ret = 14;
			8'b10001000: ret = 15;
			default: ret = -1;
		endcase	
		return ret;		
	endfunction

	function void insert (int data, int block);
		int i;
		int dst;
		if (data[16] == 1'b1) begin
			if (count[block] > 0) //body flit
				dst = header[block];
			else begin
				dst = get_block(data[7 : 0]);
				header[block] = dst;
			end
			count[block]++;
			if (count[block] >= 5)
				count[block] = 0;
			if (dst == -1) begin
			end else begin	
				for (i = 200 * dst; i < 200 * dst + 200; i++) begin
					if (r[i] == -1) begin
						r[i] = data;
						break;
					end
				end
			end	
		end
	endfunction	

	function int data_remain;
		int i;
		int num = 0;
		int block;
		for (i = 0; i < 3200; i++) begin
			if (r[i] != -1) begin
				block = i / 200;
				$display("%s, %5h\n", "The remaining data is in block", r[i], block);
				num++;
			end
		end
		return num;
	endfunction

	function bit check(int data, int block);
		int i;
		if (data[16] == 0)
			return 0;
		for (i = 200 * block; i < 200 * block + 200; i++) begin
			if (r[i] == data) begin
				r[i] = -1;
				return 0;
			end
		end	
		$display("%s, %5h\n", "The check fails, data and output block is ", data, block);
		return 1;
	endfunction

endclass
