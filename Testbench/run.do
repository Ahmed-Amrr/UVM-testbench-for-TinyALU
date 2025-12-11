vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.tinyalu_top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/tinyalu_top/inter/*
coverage save tinyalu_top.ucdb -onexit
run -all