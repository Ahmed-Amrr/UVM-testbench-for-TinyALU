import tinyalu_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module tinyalu_top ();
	bit clk;

	initial begin
		clk=0;
		forever
		#1 clk=~clk;
	end

	tinyalu_inter inter (clk);
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

	initial begin
		uvm_config_db#(virtual tinyalu_inter)::set(null,"uvm_test_top","VIF",inter);
		run_test("tinyalu_test");
	end

endmodule : tinyalu_top