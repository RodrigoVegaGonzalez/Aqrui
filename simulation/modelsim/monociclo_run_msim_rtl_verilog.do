transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alucontrol {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alucontrol/aluctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alu/fulladder {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alu/fulladder/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alu {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alu/aluN.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alu {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/alu/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/monociclo.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/regfile {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/regfile/registerfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/signextend {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/signextend/signextend.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/decode {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/decode/decode.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/dcache {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/dcache/dcache.v}
vlog -vlog01compat -work work +incdir+C:/Users/sr.\ cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/icache {C:/Users/sr. cobaya/Documents/ESCOM/Ar/Monociclo/monociclo/icache/icache.v}

