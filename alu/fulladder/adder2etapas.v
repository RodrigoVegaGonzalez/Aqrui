module adder2etapas #(
	parameter N = 16,
	parameter M = 32
	)(
	input							clk_i,
	input				[M-1:0]	a_i,
	input				[M-1:0]	b_i,
	input							c_i,
	output reg		[M-1:0]	sfinal_o,
	output reg					cfinal_o
);
	//definicion de señales para registrar
	reg		[N-1:0] alow_r;
	reg		[N-1:0] blow_r;
	reg		[N-1:0] ahigh_r;
	reg		[N-1:0] bhigh_r;
	reg				  cin_r;
	wire		[N-1:0] slow_o;
	wire				  clow_o;	
	//registramos señales
	always @(posedge clk_i)
	begin
		alow_r	<=			a_i[15:0];
		ahigh_r	<=			a_i[31:16];
		blow_r	<=			b_i[15:0];
		bhigh_r	<=			b_i[31:16];
		cin_r		<=			c_i;
	end
	//instanciamos sumador
	adderNbit #(
		.N				(N)
	)
	adder32low(
		.a_i						(alow_r),
		.b_i						(blow_r),
		.c_i						(cin_r),
		.s_o						(slow_o),
		.c_o						(clow_o)
	);
	//definicion de señales para el latch interetapa
	reg		[N-1:0]	ahighr_r;
	reg		[N-1:0]	bhighr_r;
	reg					clowr_r;
	reg		[N-1:0]	slowr_r;
	//latch interetapa
	always @(posedge clk_i)
	begin
		ahighr_r		<= ahigh_r;
		bhighr_r		<= bhigh_r;
		clowr_r 		<= clow_o;
	   slowr_r 		<= slow_o;
	end
	//definicion de señales registradas para sumador high
	reg 		[N-1:0]	shigh_o;
	reg 					chigh_o;
	//instanciamos sumador parte alta
		adderNbit #(
		.N				(N)
	)
	adder16high(
		.a_i						(ahigh_r),
		.b_i						(bhigh_r),
		.c_i						(clow_r),
		.s_o						(shign_o),
		.c_o						(chigh_o)
	);
	//registrar las salidas
	always @(posedge clk_i)
	begin
		sfinal_o	<=	{shigh_o, slowr_r};
		cfinal_o	<=	chigh_o;
	end
endmodule