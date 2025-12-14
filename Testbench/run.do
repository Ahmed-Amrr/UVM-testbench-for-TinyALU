vlib work
vlog -f src_files.list +cover -covercells
vsim +UVM_TESTNAME=tinyalu_test_base -voptargs=+acc work.tinyalu_top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/tinyalu_top/inter/*
coverage save tinyalu_top.ucdb -onexit
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/env/scoreboard/correct_count \
sim:/uvm_root/uvm_test_top/env/scoreboard/error_count \
sim:/uvm_root/uvm_test_top/env/scoreboard/done_exp \
sim:/uvm_root/uvm_test_top/env/scoreboard/result_exp
run -all