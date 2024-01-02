module icache(
	input		[7:0]addrread_i,
	output	[31:0]inst_o
);

	//Definicion de memoria
	reg		[31:0]memoria	[0:15];
	
	//Inicializacion
	initial
	begin
		$readmemh("bubblesort_int_3CV11.hex", memoria);
	end
	
	assign	inst_o = memoria[addrread_i];

endmodule 