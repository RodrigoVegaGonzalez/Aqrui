module aluctrl(
	input 		[2:0]	f3_i,
	input 				f7_i
);
	always @(*)
	begin
		case (opcode_i)
			7'b0110011:			//Tipo R
				begin
					aluope_o = {f7_i,f3_i};
				end
			7'b0010011:
				begin
					case(f3_i)
					
						3'b101:		//shift right
							if(f7_i)
								aluope_o = 4'b1101;
							else
								aluope_o = 4'b0101;
							default
								aluope_o = {1'b0, f3_i};
					endcase
				end
			7'b0000011:
				begin
					aluope_o = 4'b0000;
				end
			7'b0100011:
				begin
					aluope_o = 4'b0000;
				end
			7'b1100011: //branches
				begin
					case (f3_i)
						//beq - xor
						3'b000:
							aluope_o = 4'b0100;
						//bneq - xor
						3'b001: 
							aluope_o = 4'b0100;
						//blt- slt
						3'b100:
							aluope_o = 4'b0010;
						//bge - slt 
						3'b101:
							aluope_o = 4'b0010;
					endcase
				end
				7'b1101111:
				begin
					case (f3_i)
						3'b000:
							aluope_o = 4'b0001; // Salto incondincional (jump)
						3'b001:
							aluope_o = 4'b0010; // Salto si igual a cero (jump if zero)
						3'b010:
							aluope_o = 4'b0011; // Salto si no igual a cero (jump if not zero)
						default:
							aluope_o = 4'b1111; // Valor predeterminado para saltos no especificados
					endcase
				end
			default:
				aluope_o = 4'b1111;
		endcase
		end
endmodule