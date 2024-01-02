module decode (
	input 		[6:0] opcode_i,
	output reg			regwrite_o,
	output reg			alusrc_o,
	output reg 			memwrite_o,
	output reg			memeread_o,
	output reg			memtoreg_o,
	output reg			branch_o,
	output reg	[4:0]	aluop
);

	always @(*)
	begin
		case (opcode_i)
			7'b0110011:			//TIPO R
				begin
					regwrite_o 	= 1'b1;
					alusrc_o		= 1'b0;
					memwrite_o	= 1'b0;
					memeread_o	= 1'b0;
					memtoreg_o	= 1'b0;
					branch_o		= 1'b0;
					aluop 		= 5'b01100;
				end
			7'b0010011:			//TIPO I
				begin
					regwrite_o 	= 1'b1;
					alusrc_o		= 1'b1;
					memwrite_o	= 1'b0;
					memeread_o	= 1'b0;
					memtoreg_o	= 1'b0;
					branch_o		= 1'b0;
					aluop 		= 5'b01100;
				end
			7'b0000011:			//TIPO L
				begin
					regwrite_o 	= 1'b1;
					alusrc_o		= 1'b1;
					memwrite_o	= 1'b0;
					memeread_o	= 1'b1;
					memtoreg_o	= 1'b1;
					branch_o		= 1'b0;
					aluop 		= 5'b01100;
				end
			7'b0100011:			//TIPO S
				begin
					regwrite_o 	= 1'b0;
					alusrc_o		= 1'b1;
					memwrite_o	= 1'b1;
					memeread_o	= 1'b0;
					memtoreg_o	= 1'b0;
					branch_o		= 1'b0;
				end
				7'b1100011:			//TIPO B
				begin
					regwrite_o 	= 1'b0;
					alusrc_o		= 1'b0;
					memwrite_o	= 1'b0;
					memeread_o	= 1'b0;
					memtoreg_o	= 1'b0;
					branch_o		= 1'b1;
					aluop 		= 5'b01100;
				end
			
			default:				//DEFAULT
				begin
					regwrite_o 	= 1'b0;
					alusrc_o		= 1'b0;
					memwrite_o	= 1'b0;
					memeread_o	= 1'b0;
					memtoreg_o	= 1'b0;
					branch_o		= 1'b0;
				end
		endcase
	end

endmodule 