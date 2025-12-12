import tinyalu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module tinyalu_top ();
	bit clk;

	initial begin
		clk=0;
		forever
		#5 clk=~clk;
	end

	tinyalu_if inter (clk);
	tinyalu DUT (
		.clk        (clk),
		.A      (inter.A),
		.B      (inter.B),
		.op      (inter.op),
		.reset_n    (inter.reset_n),
		.start       (inter.start),
		.done      (inter.done),
		.result     (inter.result)
		);

	bind tinyalu tinyalu_sva tinyalu_sva_inst(
		.clk        (clk),
		.A      (inter.A),
		.B      (inter.B),
		.op      (inter.op),
		.reset_n    (inter.reset_n),
		.start       (inter.start),
		.done      (inter.done),
		.result     (inter.result)
		);

	initial begin
		uvm_config_db#(virtual tinyalu_if)::set(null,"uvm_test_top","tinyalu_if",inter);
		run_test();
	end

endmodule : tinyalu_top