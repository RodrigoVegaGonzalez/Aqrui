module signextend (
	input 		[31:0]	instr_i,
	output reg	[31:0]	dato_o
);

	always @(*)
	begin
		case (instr_i[6:0])
			7'b0010011:			//TIPO I
				dato_o = {{20{instr_i[31]}},instr_i[31:20]};
			7'b0110011:			//TIPO R
				dato_o = {{20{instr_i[31]}},{instr_i[31:25], instr_i[14:12]}};
			7'b0100011:			//TIPO S
				dato_o = {{20{instr_i[31]}},{instr_i[31:25], instr_i[11:7]}};
			7'b1100011:			//TIPO B
				dato_o = {{20{instr_i[31]}},instr_i[31:30],instr_i[30:25],instr_i[11:8],instr_i[7:6]};
			7'b0000011:			//Tipo L
				dato_o =	{{20{instr_i[31]}},instr_i[31:20]};
				
			default:
				dato_o = 32'b0;
		endcase
	end

endmodule
