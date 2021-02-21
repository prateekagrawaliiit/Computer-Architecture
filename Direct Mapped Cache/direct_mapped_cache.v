/*
		**DIRECT MAPPED CACHE WITH WRITE BACK**

				BLOCKS	WORDS	WORD SIZE	INDEX
MAIN MEMORY 	8192	16		32			13 (Block index (BI))
CACHE MEMORY	1024	16		32			10 (Cache index (CI))

TAG = Block index - Cache index = 3 bits
BLOCK OFFSET (BO) = bits for no. of blocks (16) = 4 bits
VALID (V): 1 bit
DIRTY (D): 1 bit

PHYSICAL ADDRESS: { BI(13) BO(4) } = 17 bits
LOGICAL ADDRESS : { V(1) D(1) TAG(3) CI(10) BO(4) } = 19 bits

*/

module cache (
	output reg [31:0] read_data,     // 32 bit data to be read {OUTPUT}
	input [16:0] read_addr,			 // 17 bit address which contains tag,cache-line and word offset
	input [16:0] write_addr,		 // 17 bit address which contains tag,cache-line and word offset
	input [31:0] write_data,	     // 32 bit data to be written
	input read_enable,			     // read enable
	input write_enable,				 // write enable
	input clk						 // clock
);
	//DECLARATIONS
	reg [31:0] r_main_memory [8191:0][15:0];     // Create 8192 blocks in Main Memory which is 8 times the cache memory.
	reg [31:0] r_cache [1023:0][15:0];			 // Create 1024 blocks in Cache Memory
	reg [2:0] r_cache_tags [1023:0];			 // Create an array of 3 bit 1024 elements to store the tags. Since MS/CS is 8 we need 3 bits
	reg r_valid [1023:0];	// 0 is for invalid, 1 => valid 
	reg r_dirty [1023:0];	// 0 is not dirty, 1 => dirty

	//READING DETAILS
	wire [2:0] w_tag_r;							 // tag for reading 
	wire [9:0] w_line_r; 						 // cache line for reading 
	wire [3:0] w_block_offset_r;				 // word offset for reading

	//WRITING DETAILS
	wire [2:0] w_tag_w;							 // tag for writing 
	wire [9:0] w_line_w; 						 // cache line for writing 
	wire [3:0] w_block_offset_w;				 // word offset for writing

	integer i, j;

	// Split the data into its components.

	assign w_tag_r = read_addr[16:14];			// First 3 bits from MSB represent the tag
	assign w_line_r = read_addr[13:4];			// The next 10 bits represent the block 
	assign w_block_offset_r = read_addr[3:0];	// The next 4 bits represent the word.

	assign w_tag_w = write_addr[16:14];			// First 3 bits from MSB represent the tag											
	assign w_line_w = write_addr[13:4];			// The next 10 bits represent the block 						
	assign w_block_offset_w = write_addr[3:0];	// The next 4 bits represent the word.			

	//	INTIALISATION OF VALUES IN MAIN MEMORY
	initial 
	begin
		for (i = 0; i < 8192; i = i + 1) 
		begin
			for (j = 0; j < 16; j = j + 1) 
			begin
				r_main_memory[i][j] = j;
			end
		end
		
		// Initially all tags are invalid
		for (i = 0; i < 1024; i = i + 1) 
		begin
			r_valid[i] = 0;
			r_dirty[i] = 0;
		end
	end
	
		
	always @(posedge clk) 
	begin
		if (read_enable) 
		begin

			// Check if the tags in the requested address and the one in the cache match and also if the data is valid.

			if (r_cache_tags[w_line_r] == w_tag_r && r_valid[w_line_r] == 1'b1) 
			begin
				$monitor("%d # Hit: Reading", $time);
				read_data = r_cache[w_line_r][w_block_offset_r];
			end 
			
			// READ MISS - Replace with correct data
			else 
			begin
				$display("%d # Read Miss", $time);

				// check if line is DIRTY
				
				if (r_dirty[w_line_w] == 1'b1) 
				begin
					// write cache line to memory block (cache line is modified)
					$display("%d # Dirty line", $time);
					for(i=0; i < 16; i = i+1)
					begin
						r_main_memory[{r_cache_tags[w_line_r], w_line_r}][i] = r_cache[w_line_r][i];
					end	
					r_dirty[w_line_r] = 1'b0;

				end

				else 
				begin
					// bring correct block to cache
					$display("%d # Bringing Main Memory Block to cache", $time);	
					for(i=0; i < 16; i = i+1)
					begin
						r_cache[w_line_r][i] = r_main_memory[{w_tag_r, w_line_r}][i];
					end	
					r_valid[w_line_r] = 1'b1;
					r_cache_tags[w_line_r] = w_tag_r;

				end
			end
		end

		if (write_enable) 
		begin
			// check if block is in cache and is valid
			// Write the data in cache and change the dirty bit to 1.
			if (r_cache_tags[w_line_w] == w_tag_w && r_valid[w_line_w] == 1'b1) 
			begin
				$display("%d # Hit: Writing", $time);
				r_cache[w_line_w][w_block_offset_w] = write_data;
				r_dirty[w_line_w] = 1'b1;
			end

			// replace with correct line 
			else 
			begin
				$display("%d # Write Miss", $time);
				// check if line is dirty
				// If the value has already been modified in the cache and the dirty bit is 1 then first copy the data into main memory and then update the value in the cache.
				if (r_dirty[w_line_w] == 1'b1) 
				begin
					// write cache line to memory block
					$display("%d # Dirty line", $time);
					for(i=0; i < 16; i = i+1)
					begin
						r_main_memory[{r_cache_tags[w_line_r], w_line_r}][i] = r_cache[w_line_r][i];
					end	
					r_dirty[w_line_w] = 1'b0;
				end
				
				else 
				begin
					// bring correct block to cache
					$display("%d # Bringing Main Memory Block to cache", $time);
					for(i=0; i < 16; i = i+1)
					begin
						r_cache[w_line_w][i] = r_main_memory[{w_tag_r, w_line_r}][i];
					end				
					r_valid[w_line_w] = 1'b1;
					r_cache_tags[w_line_w] = w_tag_w;
				end
			end
		end
	end

endmodule