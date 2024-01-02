module aluN #(
	parameter N = 32 //Tamaño de la palabra
)
(
	input 	[N-1:0]	a_i,
	input 	[N-1:0]	b_i,
	input					c_i,
	input		[3:0]		ope_i,
	input		[3:0]		aluoper_i,
	output				c_o,
	output	[N-1:0]	res_o,
	output				zeroflag_o
);

	//Registro para acarreos internos
	wire		[N:0]		carryint_w;
	assign				carryint_w[0]	=	c_i;
	wire 					invert_w;
	assign 				invert_w = c_i;
	
	genvar	i;
	generate
		for (i=0; i<N; i=i+1)
			begin:estotienequeir
				if (i==0)
					alu alu_N(
						.a_i		(a_i[i]),
						.b_i		(b_i[i]),
						.c_i		(carryint_w[i]),
						.ope_i	(ope_i),
						.res_o	(res_o[i]),
						.c_o		(carryint_w[i+1]),
						.less_i	(res_o[N-1]),
						.invert_i(invert_w)
					);
				else
					alu alu_N(
						.a_i		(a_i[i]),
						.b_i		(b_i[i]),
						.c_i		(carryint_w[i]),
						.ope_i	(ope_i),
						.res_o	(res_o[i]),
						.c_o		(carryint_w[i+1]),
						.less_i	(1'b0),
						.invert_i(invert_w)
					);
			end
	endgenerate
	assign	c_o	=	carryint_w[N];
	//zero flag
	assign	zeroflag_o		=		~(|(res_o));
endmodule 