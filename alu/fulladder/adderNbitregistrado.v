module adderNbitregistrado #(
	parameter N = 32
	)(
	
	input							clk_i,
	input				[N-1:0]	a_i,
	input				[N-1:0]	b_i,
	input							c_i,
	output reg		[N-1:0]	sr_o,
	output reg					cr_o

);

	//definicion de señales para registrar
	reg		[N-1:0] a_r;
	reg		[N-1:0] b_r;
	reg				  cin_r;
	wire		[N-1:0] s_o;
	wire				  c_o;
	
	//registramos señales
	always @(posedge clk_i)
	begin
		a_r	<=			a_i;
		b_r	<=			b_i;
		cin_r	<=			c_i;
	end
	
	//instanciamos sumador
	adderNbit adder32(
		.a_i						(a_r),
		.b_i						(b_r),
		.c_i						(cin_r),
		.s_o						(s_o),
		.c_o						(c_o)
	);
	
	//registrar las salidas
	always @(posedge clk_i)
	begin
		sr_o	<=	s_o;
		cr_o	<=	c_o;
	end
endmodule