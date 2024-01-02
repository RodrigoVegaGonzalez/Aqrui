module registerfile(
	input				clk_i,
	input		[4:0]addrs1_i,
	input		[4:0]addrs2_i,
	input		[4:0]addrrd_i,
	input		[31:0]datord_i,
	input				writeen_i,
	output	[31:0]dators1_o,
	output	[31:0]dators2_o
);

	//Definicion de memoria
	reg		[31:0]regfile	[0:31];
	
	//Inicializacion
	initial
	begin
		regfile[0]	=	32'b0;
	end
	
	always @(posedge clk_i)
	begin
		if(writeen_i)
			regfile[addrrd_i]	<= datord_i;
	end
	
	assign	dators1_o = regfile[addrs1_i];
	assign	dators2_o = regfile[addrs2_i];

endmodule 