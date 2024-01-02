module display7seg(
	input				[3:0] entrada_i,
	output reg		[6:0] salida_o
	);
	
	always @*
	begin
		case(entrada_i)
			4'h0:
				salida_o = 7'b100000;
			4'h1:
				salida_o = 7'b1111001;
			4'h2:
				salida_o = 7'b0100100;
			4'h3:
				salida_o = 7'b0110000;
			4'h4:
				salida_o = 7'b0011001;
			4'h5:
				salida_o = 7'b0010010;
			4'h6:
				salida_o = 7'b0000010;
			4'h7:
				salida_o = 7'b0111000;
			4'h8:
				salida_o = 7'b0000000;
			4'h9:
				salida_o = 7'b0010000;
			4'ha:
				salida_o = 7'b0001000;
			4'hb:
				salida_o = 7'b0000011;
			4'hc:
				salida_o = 7'b0100111;
			4'hd:
				salida_o = 7'b0100001;
			4'he:
				salida_o = 7'b0001010;
			4'hf:
				salida_o = 7'b0001110;	
		endcase
	end

endmodule