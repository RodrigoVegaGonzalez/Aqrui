module adderNbit #(
	parameter N = 32
	);(
	input		[N-1:0]	a_i,
	input		[N-1:0]	b_i,
	input					c_i,
	output	[N-1:0]	s_o,
	output				c_o

);
	wire		[N:0]		carry_w;
	assign 				carry_w[0]=c_i;
	genvar i;
	generate 
		for (i = 0; i < N ; i = i+1)
			begin: adderN
				full_adder fa_N(
					.a_i		(a_i[i]),
					.b_i		(b_i[i]),
					.c_i		(carry_w[i]),		//pendiente
				   .s_o		(s_o[i]),
				   .c_o		(carry_w[i+1])			//pendiente
				);
			end
	endgenerate
endmodule