module monociclo (
	input					 clk_i,
	input					 rst_ni,
	output		[31:0] monitor_o
);

	//Definicion de señales
	reg		[31:0]pc_w;
	wire		[31:0]pcnext_w;
	wire		[31:0]if_inst_o;
	wire		[31:0]wb_dato_o;
	wire		[31:0]rr_dators1_o;
	wire		[31:0]rr_dators2_o;
	wire		[31:0]ex_res_o;
	wire				ex_carry_o;
	wire		[31:0]se_dato_o;
	wire				id_regwrite_o;
	wire				id_alusrc_o;
	wire		[31:0]muxalu_dato_o;
	wire		[31:0]mem_dato_o;
	wire				id_memread_o;
	wire				id_memwrite_o;
	wire				id_memtoreg_o;
	wire				ex_zeroflag_o;
	wire				id_branch_o;
	wire				id_aluop_o;
	wire				id_aluope_o;
	wire				pcsrc_branch_O;
	wire		[31:0]sll1_dato_o;	 
	wire		[31:0]pcbranch_dato_o;

	
	//Seccion para asignar señal de monitoreo
	assign	monitor_o = wb_dato_o;

	/////*****
	//ETAPA DE FETCH
	/////*****
	always @(posedge clk_i, negedge rst_ni)
	begin
		if (!rst_ni)
			pc_w <= 32'b0;
		else
			pc_w <= pcnext_w;
	end
	
	//assign	pcnext_w = pc_w + 4'd4;
	
	icache icache_o (
		.addrread_i	(pc_w[9:2]),
		.inst_o		(if_inst_o)
	);
	
	/////*****
	//ETAPA DE DECODIFICACION
	/////*****
	
	decode decode_u0(
		.opcode_i	(if_inst_o[6:0]),
		.regwrite_o	(id_regwrite_o),
		.alusrc_o	(id_alusrc_o),
		.memwrite_o (id_memwrite_o),
		.memeread_o (id_memread_o),
		.memtoreg_o (id_memtoreg_o),
		.branch_o	(id_branch_o),
		.aluop		(id_aluop_o)
	);
	
	/////*****
	//ETAPA DE BUSQUEDA DE OPERANDOS
	/////*****
	
	registerfile regfile(
		.clk_i		(clk_i),
		.addrs1_i	(if_inst_o[19:15]),
		.addrs2_i	(if_inst_o[24:20]),
		.addrrd_i	(if_inst_o[11:7]),
		.datord_i	(wb_dato_o),
		.writeen_i	(id_regwrite_o),
		.dators1_o	(rr_dators1_o),
		.dators2_o	(rr_dators2_o)
	);
	
	//ETAPA DE EXTENCION DE SIGNO
	
	signextend signextend_u0 (
		.instr_i	(if_inst_o),
		.dato_o	(se_dato_o)
	);
	
	/////*****
	//MUX ALU SOURCE
	/////*****
	
	assign muxalu_dato_o 	= 	(id_alusrc_o) ? se_dato_o : rr_dators2_o;
	
	
	/////*****
	//ETAPA DE EJECUCION
	/////*****
	aluN excute(
		.a_i			(rr_dators1_o),
		.b_i			(muxalu_dato_o),
		.c_i			(1'b0), //AQUI EL PROFE DIJO CAMBIAR POR CONTROL
		.ope_i		({if_inst_o[30],if_inst_o[14:12]}),
		.c_o			(ex_carry_o),
		.res_o		(ex_res_o),
		.zeroflag_o	(ex_zeroflag_o),
		.aluoper_i	(id_aluope_o)
	);
	/////*****
	//ALU Control
	/////*****
	aluctrl ALUctrl(
		.f3_i			(if_inst_o[2:0]),
		.f7_i			(if_inst_o[7:5]),
		.aluinst_i	(id_aluop_o),
		.aluope_o	(id_aluope_o)
		
	);
	
	/////*****
	//MUX de Branches
	/////*****
	assign	pcsrc_branch_O		=	ex_zeroflag_o & id_branch_o;
	assign 	sll1_dato_o			=	se_dato_o << 1;
	assign 	pcbranch_dato_o	=	sll1_dato_o	+	pc_w;
	
	assign   pcnext_w				=	(pcsrc_branch_O) ? se_dato_o	:	pc_w + 4'd4;

	/////*****
	//ETAPA DE ACCESS MEMORY
	/////*****
	
	dcache dcache_u0(
		.clk_i		(clk_i),
		.addrrd_i	(ex_res_o[10:2]),
		.datord_i	(rr_dators2_o),
		.writeen_i	(id_memwrite_o),
		.readen_i	(id_memread_o),
		.dators1_o	(mem_data_o)
	);
	
	/////*****
	//ETAPA DE WRITEBACK
	/////*****
	
	assign		wb_dato_o	=	(id_memtoreg_o) ? mem_data_o : ex_res_o;
endmodule

/*
//para simulacion Monociclo y se agrega _tb
module monociclo_tb();//test bench
//inputs son reg y output son wire
	reg					 clk_i;
	reg					 rst_ni;
	wire			[31:0] monitor_o;
//valores iniciales
	initial
	begin
			clk_i		=	1'b1;
			rst_ni	=	1'b0;
		#100
			rst_ni	=	1'b1;
	end
	//instanciar DUT (De)
	monociclo (
		.clk_i,		(clk_i),
		.rst_ni,		(rst_ni),
		.monitor_o	(monitor_o)
	);
	
	//generacion de señales
	always
		#50
			clk_i	=	~clki_i;
endmodule
*/