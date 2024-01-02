module dcache (
	input				 clk_i,
	input		[8:0]  addrrd_i,
	input		[31:0] datord_i,
	input				 writeen_i,
	input				 readen_i,
	output	[31:0] dators1_o
);

	//Definicion de memoria
	reg		[31:0]datacache	[0:15];
	
	always @(posedge clk_i)
	begin
		if(writeen_i)
			datacache[addrrd_i]	<= datord_i;
	end
	
	assign	dators1_o = (readen_i) ? datacache[addrrd_i] : 32'b0;

endmodule 