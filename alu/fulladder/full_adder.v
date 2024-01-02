module full_adder (
  input 	[31:0] A, B, // Entradas de 32 bits				
  input 	Cin,         // Acarreo de entrada				
  output [31:0] Sum,  // Salida de la suma de 32 bits	
  output Cout         // Acarreo de salida				
);

  wire [31:0] sum_intermediate; // Almacena las sumas intermedias de cada bit
  wire c_intermediate [31:0];   // Almacena los acarreos intermedios de cada bit

  // Instanciar 32 Full Adders de 1 bit
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : full_adder_instance
      FullAdder full_adder_instance (
        .A(A[i]),
        .B(B[i]),
        .Cin(i == 0 ? Cin : c_intermediate[i-1]),
        .Sum(sum_intermediate[i]),
        .Cout(c_intermediate[i])
      );
    end
  endgenerate

  // Salida de la suma de 32 bits y acarreo de salida
  assign Sum = sum_intermediate;
  assign Cout = c_intermediate[31];

endmodule


//Fulladder de un bit
module FullAdder (
  input A, B, Cin,
  output Sum, Cout
);

  // Sum bit
  assign Sum = A ^ B ^ Cin;

  // Carry out
  assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule
