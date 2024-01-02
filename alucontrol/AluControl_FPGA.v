module AluControl_FPGA(

	input 	[6:0]	opcode_i,
	input 			f7,
	input 	[2:0]	f3,
	output 	[6:0]	salida_7_seg
	
);

wire [3:0] alu_operacion;

 alucontrol controlalu(
	.opcode 				(opcode),
	.f7 					(f7),
	.f3 					(f3),
	.aluope_o			(alu_operacion)
		);
		
		

		
 display7segs dis7seg(
	.entrada_i	(alu_operacion),
	.salida_o 	(salida_7_seg)
 );

endmodule