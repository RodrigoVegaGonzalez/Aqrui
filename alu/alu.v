module alu(
	input [31:0]a_i,
	input [31:0]b_i,
	input [31:0]c_i,
	input [3:0] ope_i,	
	output reg 	res_o,
	output[31:0]c_o,
	input			less_i,
	input			invert_i
);

	wire aandb_w;
	wire aorb_w;
	wire fa1_w;
	wire nob_w;
	wire b_w;
	wire axorb_w;
	wire ashiftright_l_w;
	wire ashiftleft_l_w;
	wire ashiftright_a_w;
	wire ashiftleft_a_w;
	wire less_unsigned_w;
	wire [31:0] result;
	
	reg [31:0] input_data;
   reg [4:0] shift_amount;
  

 
	
	//Inversion de b
	assign nob_w = ~b_i;
	//Selector de b ~ nob
	assign b_w = (invert_i) ? nob_w : b_i;
	
	//Estructural
	and	and1	(aandb_w, a_i, b_w);
	or		or1	(aorb_w, a_i, b_w);
	xor	xor1	(axorb_w, a_i, b_w);
	
	//Corrimientos
	assign ashiftright_l_w = a_i >> b_w;
	assign ashiftleft_l_w = a_i << b_w;
	assign ashiftright_a_w = a_i >>> b_w;
	assign ashiftleft_a_w = a_i <<< b_w;
	
	
	//Shift logical left
	 ShiftLeft shift_left_inst (
    .data_in(input_data),
    .shift_amount(shift_amount),
    .shifted_data(result)
  );
	//Set on less than unsigned
	assign less_unsigned_w = (a_i < b_w) ? 1'b1 : 1'b0;

	
	
	
	
	// Declaracion de wires
	wire Cin;
	wire [31:0]Sum;
	wire Cout;
	wire senal_b_i;
	assign senal_b_i = (b_i[2]) ? ~b_i : b_i;
	
	//Sumador completo
	
	full_adder  full_adder_inst (
		.A(a_i),
		.B(senal_b_i),
		.Cin(b_i[2]),
		.Sum(Sum),
		.Cout(Cout)  
	);
	//Algoritmo
	always @(*)
	begin
		case(ope_i)
			4'b0000: //suma  1
				begin
					c_o = sum;	
				end
			4'b0101: //resta  2
				begin
					c_o = sum;	
				end
			4'b0110: //slt  3
				begin
					c_o = (suma <= 0) ? 1 : 0;	
					c_o = ~Cout;
				end
			4'b0001: //and  4
				begin
					c_o = a_i & b_i;	
				end
			4'b0100: //sltu  5
				begin
					c_o = Sum[31];	
				end
			4'b0010: //xor 6
				begin
					c_o = a_i ^ b_i;	
				end
			
			4'b0011: //or 9
				begin
					c_o = a_i | b_i;	
				end
			default:
				begin
					res_o = 1'b0;
				end
		endcase
	end
endmodule 

module alucorrimiento(
	input [31:0]a_i,
	input [31:0]b_i,
	input [31:0]c_i,
	input [3:0] ope_i,	
	output reg 	res_o,
	output[31:0] c_o,
	input			less_i,
	input			invert_i
);

	wire [31:0]signresult; 


	wire ashiftright_l_w;
	wire ashiftleft_l_w;
	wire ashiftright_a_w;
	wire ashiftleft_a_w;
	

   reg [4:0] shift_amount;
  

		
	//Corrimientos
	assign ashiftright_l_w = a_i >> b_i;
	assign ashiftleft_l_w = a_i << b_i;
	assign ashiftright_a_w = a_i >>> b_i;
	assign ashiftleft_a_w = a_i <<< b_i;
	
	
	//Shift logical left
	 ShiftLeft shift_left_inst (
    .data_in(input_data),
    .shift_amount(shift_amount),
    .shifted_data(result)
  );
	//Set on less than unsigned
	assign less_unsigned_w = (a_i < b_w) ? 1'b1 : 1'b0;

	
	// Declaracion de wires
	wire Cin;
	wire [31:0]Sum;
	wire Cout;
	wire senal_b_i;
	assign senal_b_i = (b_i[2]) ? ~b_i : b_i;
	
	//Sumador completo

	//Algoritmo
	always @(*)
	begin
		case(ope_i)
			4'b1001: //sll 1
				begin
					c_o = ashiftleft_l_w;	
				end
			4'b1010: //srl 2
				begin
					c_o = ashiftright_l_w;	
				end
			4'b1000: //sra 3
				begin
					c_o = ashiftright_a_w;	
				end
			default:
				begin
					res_o = 1'b0;
				end
		endcase
	end
endmodule 